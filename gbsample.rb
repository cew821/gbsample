require 'sinatra'

get '/greenbutton/:source' do
  gb = [ params[:source], 3, 5, 12, 4, 3, 13, 7 ]
  "This is the hash #{gb}"
end