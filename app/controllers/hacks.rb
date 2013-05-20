Sketching.controllers :hacks do

  get :index, :map=>"/hacks" do
    #expires_in 30
    @hacks = Hack.all.order_by([[:published_at, :desc]])
    @hack = @hacks.first
    @screengrabs = Screengrab.all
    haml :"hacks/index", :layout => !request.xhr?
  end

  get :show, :map => "/hacks/:slug" do
    #expires_in 30
    @hack = Hack.where(:slug => params[:slug]).first
    haml :"hacks/show", :layout => !request.xhr?
  end

  post :refresh, :map => "/hacks/refresh" do
    Resque.enqueue(HackFetching)
    redirect "/"
  end

  get :sitemap, :map => "/hacks/sitemap", :provides => [:xml] do
    #expires_in 30
    @hacks = Hack.all.order_by([[:published_at, :desc]])
    map = XmlSitemap::Map.new('sketchingwithcode.com') do |m|
      @hacks.each do |hack|
        m.add(:url => hack.url)
      end
    end
    map.render.gsub("http://sketchingwithcode.com/{:url=&gt;&quot;", "").gsub("&quot;}","")
  end

end