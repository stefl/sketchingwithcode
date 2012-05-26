Sketching.controllers :thanks do

  get :index, :map => "/thanks" do
    begin
      @members = Twitter.list_members("stef", "sketching-with-code")
    rescue Twitter::Error::ServiceUnavailable
      @message = "Twitter is over capacity!"
    end
    render :"thanks/index"
  end
  
end
