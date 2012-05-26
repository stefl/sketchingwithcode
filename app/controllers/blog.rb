# encoding: utf-8

Sketching.controllers :blog do
  
  blog_path = File.join(File.dirname(__FILE__), '..', '..', 'blog', "_site")
  blog_posts_path = File.join(File.dirname(__FILE__), '..', '..', 'blog', "_posts")

  get :index, :map=>"/" do
    index_path = File.join(blog_path, "index.html")
    @content = File.open(index_path).read
    haml :"blog/index", :layout => !request.xhr?
  end

  get :page, :map => "/blog/page:number" do 
    file_path = File.join(blog_path,  request.path.sub("blog/",""))
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i  
    pass unless File.exist?(file_path)
    @content = File.open(file_path).read
    haml :"blog/index", :layout => !request.xhr?
  end

  get :show, :map => "/:year/:month/:day/:slug" do
    file_path = File.join(blog_path,  request.path)
    file_path = File.join(file_path, 'index.html') unless file_path =~ /\.[a-z]+$/i  
    pass unless File.exist?(file_path)
    @content = File.open(file_path).read
    haml :"blog/post", :layout => !request.xhr?
  end

  get :sitemap, :map => "/blog/sitemap", :provides => [:xml] do
    File.open(blog_path + "/sitemap.xml").read
  end
  
end
