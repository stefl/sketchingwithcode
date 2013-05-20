Sketching.controllers :hacks do

  get :index, :map=>"/hacks", :cache => true do
    expires_in 5
    @hacks = Hack.all.order_by([[:published_at, :desc]])
    @hack = @hacks.first
    @screengrabs = Screengrab.all
    haml :"hacks/index", :layout => !request.xhr?
  end

  get :show, :map => "/hacks/:slug", :cache => true do
    expires_in 5
    @hack = Hack.where(:slug => params[:slug]).first
    haml :"hacks/show", :layout => !request.xhr?
  end

  post :refresh, :map => "/hacks/refresh" do
    Resque.enqueue(HackFetching)
    redirect "/"
  end

  get :sitemap, :map => "/hacks/sitemap", :provides => [:xml], :cache => true do
    expires_in 5
    @hacks = Hack.all.order_by([[:published_at, :desc]])
    map = XmlSitemap::Map.new('sketchingwithcode.com') do |m|
      @hacks.each do |hack|
        m.add(:url => hack.url)
      end
    end
    map.render.gsub("http://sketchingwithcode.com/{:url=&gt;&quot;", "").gsub("&quot;}","")
  end

end