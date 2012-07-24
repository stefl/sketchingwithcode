class Post

  attr_reader :slug

  FILENAME_FORMAT = /^(\d+-\d+-\d+)-(.*)(\.[^.]+)$/

  def initialize(path)
    @path = path
    @date_str, @slug = File.basename(path).match(FILENAME_FORMAT).captures
  end

  def to_param
    case permalink_format
    when :day   then "%04d/%02d/%02d/%s" % [year, month, day, slug]
    when :month then "%04d/%02d/%s" % [year, month, slug]
    when :year  then "%04d/%s" % [year, slug]
    when :slug  then slug
    end
  end

  def permalink_format
    Sketching.permalink_format
  end

  def to_key
    [slug]
  end

  def metadata
    load_content
    @metadata
  end

  def content
    load_content
    @content
  end

  def title
    metadata[:title] || slug.titleize
  end

  def author
    metadata[:author]
  end

  def email
    metadata[:email]
  end

  def date
    @date ||= Time.zone.parse(metadata[:date] || @date_str).to_date rescue nil
  end

  delegate :year, :month, :day, :to => :date

  def timestamp
    date
  end
  alias_method :last_modified, :timestamp

  def visible?
    true
  end

  def to_s
    "#{title.inspect} (#{slug})"
  end

  def parse_content
    @parse_content = Maruku.new(content)
  end

  def content_html
    parse_content.to_html
  end

  def word_count
    parse_content.to_s.scan(/(\w|-)+/).size
  end

  def meta
    @meta = Hashie::Mash.new(parse_content.attributes)
  end

  def summary_html
    if metadata[:summary].present?
      Maruku.new(metadata[:summary]).to_html
    else
      doc = Nokogiri::HTML.fragment(content_html)
      para = doc.search('p').detect { |p| p.text.present? }
      para.try(:to_html)
    end
  end

  def image
    @image ||= Dir.glob("#{@path.chomp(".md")}.{jpg,jpeg,png}").first
  end

  def image_url
    "/project_images/#{image.split("/").last}" if image
  end

  def path
    @path
  end

  class << self
    def all
      @@posts ||= Dir.glob(Sketching.root + "/../blog/_posts/*.md").map do |filename|
        Post.new filename
      end.select(&:visible?).sort_by(&:date).reverse
    end

    def where(conditions = {})
      conditions = conditions.symbolize_keys
      conditions.assert_valid_keys :year, :month, :day, :slug, :to_param
      [:year, :month, :day].each do |key|
        conditions[key] = conditions[key].to_i if conditions[key].present?
      end
      all.select do |post|
        conditions.all? { |key, value| post.send(key) == value }
      end
    end

    def find(id)
      where(:to_param => id).first or raise ActiveRecord::RecordNotFound, "Could not find post with ID #{id.inspect}"
    end

    def first
      all.first
    end

    def last
      all.last
    end

    def feed
      all.first(10)
    end

    def feed_last_modified
      feed.first.try(:last_modified) || Time.now.utc
    end

    def reset!
      @@posts = nil
    end
  end

  protected

  def load_content
    @content = File.read(@path)
    if @content =~ /^(---\s*\n.*?\n?)^(---\s*$\n?)/m
      @content = @content[($1.size + $2.size)..-1]
      @metadata = YAML.load($1)
    end
    @metadata = Hashie::Mash.new(@metadata || {})
  end
end