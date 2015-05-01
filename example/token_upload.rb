require 'sinatra'
require 'sproutvideo'

Sproutvideo.api_key = 'enter_your_api_key_here'

get '/' do
  @token = Sproutvideo::UploadToken.create(:return_url => 'http://localhost:4567/upload_complete').body
  template = <<-eos
  <!doctype html>
  <html>
    <head>
      <title>Upload Test</title>
    </head>
    <body>
      <form action='https://api.sproutvideo.com/v1/videos' method='post' enctype='multipart/form-data'>
        <fieldset>
          <legend>Upload:</legend>
          Title: <input name='title'><br/>
          Description: <textarea name='description'></textarea><br/>
          File: <input name='source_video' type='file'>
          <input type='hidden' name='token' value='<%= token %>'><br/>
          <input type='submit' value='Upload'>
        </fieldset>
      </form>
    </body>
  </html>
  eos
  erb template, locals: {token: @token[:token]}
end

get '/upload_complete' do
  if params[:successful] == 'true'
    "Upload Successful! Created video: #{params[:video_id]}"
  else
    "Upload Failed! Error: #{params[:error_message]}"
  end
end
