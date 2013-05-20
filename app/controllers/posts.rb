# encoding: utf-8

Sketching.controllers :posts do

  get :index, :map=>"/" do
    #expires_in 30
    @posts = Post.all.order_by([[:published_at, :desc]])
    @post = @posts.first
    haml :"posts/index", :layout => !request.xhr?
  end

  get :show, :map => "/:year/:month/:day/:slug" do
    #expires_in 30
    not_found unless @post = Post.where(:slug => params[:slug]).first
    haml :"posts/show", :layout => !request.xhr?
  end

  post :refresh, :map => "/posts/refresh" do
    Resque.enqueue(PostFetching)
    redirect "/"
  end

  get :sitemap, :map => "/sitemap", :provides => [:xml], :cache => true do
    expires_in 5
    @posts = Post.all.order_by([[:created_at, :desc]])
    map = XmlSitemap::Map.new('sketchingwithcode.com') do |m|
      @posts.each do |post|
        m.add( post.url)
      end
    end
    map.render
  end

end
