# encoding: utf-8

Sketching.controllers :chapters do

  get :index, :map=>"/book" do
    #expires_in 30
    @chapters = Chapter.all.order_by([[:published_at, :desc]])
    @chapter = @chapters.first
    haml :"chapters/index", :layout => !request.xhr?
  end

  get :show, :map => "/book/:slug" do
    #expires_in 30
    not_found unless @chapter = Chapter.where(:slug => params[:slug]).first
    haml :"chapters/show", :layout => !request.xhr?
  end

end