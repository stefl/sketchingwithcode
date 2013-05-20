class ChapterFetching
  @queue = :web

  def self.perform
    Chapter.fetch
  end
end