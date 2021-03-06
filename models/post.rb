class Post
  include Mongoid::Document

  field :published_at, :type => Date
  field :slug
  field :revision
  field :body
  field :path
  field :word_count

  before_save :calculate_word_count

  def calculate_word_count
    self.word_count = content.to_s.scan(/(\w|-)+/).size
  end

  FILENAME_FORMAT = /^(\d+-\d+-\d+)-(.*)(\.[^.]+)$/

  def self.fetch force=false
    STDOUT.sync = true
    client = Dropbox::API::Client.new :token => ENV["DROPBOX_ACCESS_TOKEN"], :secret => ENV["DROPBOX_ACCESS_SECRET"]
    client.ls.select {|f| !f.is_dir }.each do |file|
      puts "\n"
      puts file
      if file.path =~ /\.md$/
        date_str, slug = File.basename(file.path).match(FILENAME_FORMAT).captures
        puts date_str
        puts slug
        if(post = Post.where(:slug => slug ).first)
          puts "UPDATING from #{post.revision} to revision #{file.revision} ?"
          if post.revision != file.revision
            post.update_attributes :path => file.path, :slug => slug, :published_at => Date.parse(date_str), :revision => file.revision, :body => file.download
          end
        else
          Post.create :path => file.path, :slug => slug, :published_at => Date.parse(date_str), :revision => file.revision, :body => file.download
        end
      end
    end
    puts "Finished fetching"
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
    :day
  end

  def url
    "/#{to_param}"
  end

  def cache_key
    "#{slug}-#{revision}"
  end

  def title
    meta[:title] || slug.titleize
  end

  def author
    meta[:author]
  end

  def email
    meta[:email]
  end

  def draft
    meta[:draft]
  end

  def date
    published_at
  end

  def content
    Maruku.new(body)
  end

  def hue
    (MurmurHash3::V32.str_hash(self.title).to_f % 256).to_i
  end

  delegate :year, :month, :day, :to => :date

  def timestamp
    date
  end

  def previous_post
    self.class.where(:_id.lt => self._id).order_by([[:_id, :desc]]).limit(1).first
  end

  def next_post
    self.class.where(:_id.gt => self._id).order_by([[:_id, :asc]]).limit(1).first
  end

  alias_method :last_modified, :timestamp

  def to_s
    slug
  end

  def content_html
    content.to_html
  end

  def meta
    @meta ||= content.attributes
  end

end