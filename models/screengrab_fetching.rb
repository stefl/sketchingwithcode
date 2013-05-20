class ScreengrabFetching
  @queue = :web

  def self.perform
    Screengrab.fetch
  end
end