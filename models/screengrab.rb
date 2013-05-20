class Screengrab
  include Mongoid::Document
  include Mongoid::Timestamps

  field :published_at, :type => Date
  field :revision
  field :path
  field :expires_at, :type => DateTime

  def self.filename_format
    /(.*)\.(jpeg|jpg|png|gif)$/i
  end

  def self.fetch force=false
    client = Dropbox::API::Client.new :token => ENV["DROPBOX_ACCESS_TOKEN"], :secret => ENV["DROPBOX_ACCESS_SECRET"]
    client.ls("screengrabs").select {|f| !f.is_dir }.each do |entry|
      puts entry.inspect
      if entry.path =~ filename_format
        slug, format = entry.path.match(filename_format).captures
        slug = slug.split("/").last.gsub(".", "-")
        if screengrab = Screengrab.where(:path => entry.path).first
          if entry.is_deleted
            screengrab.destroy
          else
            screengrab.update_attributes :slug => slug, :path => entry.path, :revision => entry.revision
          end
        else
          if entry.is_deleted

          else
            url = entry.direct_url
            Screengrab.create :slug => slug, :path => entry.path, :revision => entry.revision, :url => url.url, :expires_at => DateTime.parse(url.expires)
          end
        end
      end
    end
  end

  def thumbnail size
    client = Dropbox::API::Client.new :token => ENV["DROPBOX_ACCESS_TOKEN"], :secret => ENV["DROPBOX_ACCESS_SECRET"]
    file = client.find self.path
    file.thumbnail(:size => size)
  end
end