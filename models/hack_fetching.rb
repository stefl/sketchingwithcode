class HackFetching
  @queue = :web

  def self.perform
    Hack.fetch
  end
end