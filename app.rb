require 'sinatra'

set :public_folder, File.dirname(__FILE__)

post '/levels' do
  data = params["data"]
  name = params["name"]

  File.open("levels/#{name}.json", 'w') do |file|
    file.write(data)
  end

  200
end
