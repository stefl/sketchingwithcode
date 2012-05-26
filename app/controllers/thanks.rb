Sketching.controllers :thanks do

  get :index, :map => "/thanks" do
    @members = Twitter.list_members("stef", "sketching-with-code")
    render :"thanks/index"
  end
  
end
