class PostFetching
  @queue = :web

  def self.perform
    Post.fetch
  end
end