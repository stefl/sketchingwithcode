Sketching.controllers :screengrabs do

  get :show, :map => "/screengrabs/:size/:slug", :provides => [:jpg], :cache => true do
    expires_in 720000 - rand(10000).to_i
    not_found unless screengrab = Screengrab.where(:slug => params[:slug]).first
    content_type "image/jpeg"
    screengrab.thumbnail(params[:size])
  end
end