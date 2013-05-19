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
    @post = Post.where(:slug => params[:slug]).first
    haml :"posts/show", :layout => !request.xhr?
  end

  post :refresh, :map => "/posts/refresh" do
    Resque.enqueue(PostFetching)
    redirect "/"
  end

  #   get :sitemap, :map => "/blog/sitemap", :provides => [:xml] do
  #     #expires_in 30
  #     File.open(blog_path + "/sitemap.xml").read
  #   end

end
