class Chapter
  include Mongoid::Document

  field :published_at, :type => Date
  field :slug
  field :revision
  field :body
  field :path
  field :word_count
  field :ordering

  before_save :calculate_word_count

  def calculate_word_count
    self.word_count = content.to_s.scan(/(\w|-)+/).size
  end

  FILENAME_FORMAT = /^(\d+)-(.*)(\.[^.]+)$/

  def self.fetch force=false
    STDOUT.sync = true
    client = Dropbox::API::Client.new :token => ENV["DROPBOX_ACCESS_TOKEN"], :secret => ENV["DROPBOX_ACCESS_SECRET"]
    client.ls("chapters").select {|f| !f.is_dir }.each do |file|
      puts "\n"
      puts file
      if file.path =~ /\.md$/
        ordering, slug = File.basename(file.path).match(FILENAME_FORMAT).captures
        puts ordering
        puts slug
        if(chapter = Chapter.where(:slug => slug ).first)
          puts "UPDATING from #{chapter.revision} to revision #{file.revision} ?"
          if chapter.revision != file.revision
            chapter.update_attributes :path => file.path, :slug => slug, :ordering => ordering.to_i, :revision => file.revision, :body => file.download
          end
        else
          Chapter.create :path => file.path, :slug => slug, :ordering => ordering.to_i, :revision => file.revision, :body => file.download
        end
      end
    end
    puts "Finished fetching"
  end

  def url
    "/book/#{slug}"
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

  def previous_chapter
    self.class.where(:_id.lt => self._id).order_by([[:ordering, :desc]]).limit(1).first
  end

  def next_chapter
    self.class.where(:_id.gt => self._id).order_by([[:ordering, :asc]]).limit(1).first
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