# SproutVideo
Use this gem to interact with the [SproutVideo API](http://sproutvideo.com/docs/api.html)

# Getting Started

First, you'll need to install the gem

    gem install sproutvideo-rb

The first thing you'll need to interact with the SproutVideo API is your API key. You can use your API key in one of two ways. The first and easiest is to set it and forget it on the Sproutvideo module like so:

```ruby
Sproutvideo.api_key = 'abcd1234'
```

Alternatively, you can use an environment variable:

```ruby
ENV['SPROUTVIDEO_API_KEY'] = 'abcd1234'
```

# Videos
The following methods are available: `list`, `create`, `details`, `update`, `upload_poster_frame`,`destroy`.

## list
By default the videos listing is paginated with 25 videos per page and sorted by upload date in ascending order.
You can pass two parameters to control the paging: `page` and `per_page`.

```ruby
Sproutvideo::Video.list
Sproutvideo::Video.list(:per_page => 10)
Sproutvideo::Video.list(:per_page => 10, :page => 2)
```

You can control sorting order by `order_by` and `order_dir` parameter.

```ruby
Sproutvideo::Video.list(:order_by => "created_at")
Sproutvideo::Video.list(:order_by => "updated_at")
Sproutvideo::Video.list(:order_by => "title", :order_dir => "asc")
Sproutvideo::Video.list(:order_by => "duration", :order_dir => "desc")
```

You can also pass `tag_id`, `tag_name`, `privacy` and `state` parameters to restrict result.

```ruby
Sproutvideo::Video.list(:tag_id => 'a323d32')
Sproutvideo::Video.list(:tag_name => 'funny cat videos')
Sproutvideo::Video.list(:privacy => 2)
Sproutvideo::Video.list(:state => "processing")
```

Values of `privacy` is listed at [Video Privacy](http://sproutvideo.com/docs/api.html#VideoPrivacy) section.
Values of `state` is listed at [Video States](http://sproutvideo.com/docs/api.html#VideoStates) section.

## details
The string passed to details is the ID of a SproutVideo video.

```ruby
Sproutvideo::Video.details('abc123')
```

## create
The most basic upload you can perform is to just pass the path to the video file to the method. The title of the video will default to the name of the file.

```ruby
Sproutvideo::Video.create('/path/to/video.mp4')
```

You can set the title as well as many other parameters by passing them as a hash

 ```ruby
 Sproutvideo::Video.create('/path/to/video.mp4',
   :title => 'My Awesome Video',
   :description => 'This video is great',
   :privacy => 2)
```

You can also apply any number of tags to the new upload by passing their ids along:

```ruby
Sproutvideo::Video.create('/path/to/video.mp4',
  :tags => ['ec61', 'abc123'])
```

You can also create or add tags on the fly by passing in tag names:

```ruby
Sproutvideo::Video.create('/path/to/video.mp4',
  :tag_names => ['Tag One', 'Tag Two'])
```

You can also specify a webhook url. We'll send an HTTP POST with the video json when the video has finished processing or if there was an error during processing:

```ruby
Sproutvideo::Video.create('/path/to/video.mp4',
  :notification_url => 'http://example.com/webhook_url')
```

## update
 The first parameter is the id of the video you wish to edit. The second parameter is a hash of attributes to update on the video.

```ruby
Sproutvideo::Video.update('abc123', :title => 'Updated Title')
```

## Replace a video
The first parameter is the id of the video you wish to replace. The second parameter is the local path to the video file.

```ruby
Sproutvideo::Video.replace('abc123', '/path/to/video.mp4')
```

## Dealing with tags
To add a tag to a video, make sure to include all of the tags currently associated with the video. For instance if the video already has tags with the ids "abc" and "123" and you want to add a tag with the id "def" do pass "abc", "123" and "def" to the update method.

```ruby
Sproutvideo::Video.update('abc123',
  :tags => ["abc", "123", "def"])
```

If you want to remove a tag from a video, remove the tag from the list of tags on the video but make sure to include all of the tags you wish to keep. For instance, if you now want to remove the tag with id "123" from the example above, pass in "abc" and "def"

```ruby
Sproutvideo::Video.update("abc123",
  :tags => ["abc","def"])
```

You can remove all of the tags from a video by just passing an empty array as the tags parameter.

```ruby
Sproutvideo::Video.update('abc123', :tags => [])
```
## Upload poster frame
You can upload a custom poster frame for a video by calling the upload_poster_frame method. The first parameter is the id of the video for wish you'd like the poster frame to be associated and the second parameter is the path to the image file.

```ruby
Sproutvideo::Video.upload_poster_frame('abc123', '/path/to/image.jpg')
```

## destroy
Pass in the id of the video you wish to delete.

```ruby
Sproutvideo::Video.destroy('abc123')
```

## Signed Embed Codes
You can use this convenience method to sign an embed code. It will return the embed code URL which can be used to build an iframe embed code.
`Sproutvideo::Video.signed_embed_code(video_id, security_token, query_parameters, expiration_time, protocol)`

### Parameters
video_id - _String_ (_Required_)
: The id of the video for which you're generating the signed embed code

security_token - _String_ (_Required_)
: The security token of the video for which you're generatingn the signed embed code

query_parameteres - _Hash_ (_Optional_)
: A hash of query parameters to be passed to the embed code. Example: `{'type' => 'hd', 'autoplay' => true}`

expiration_time - _Integer_ (_Optional_)
: The number of seconds from the Epoc that this signed embed code should expire. This defaults to 5 minutes from the time the signed embed code was generated.

protocol - _String_ (_Optional_)
: `http` or `https`. Defaults to `http`

### Examples
```ruby
Sproutvideo::Video.signed_embed_code('abc123','def456') #sign a base embed code with no other options
Sproutvideo::Video.signed_embed_code('abc123','def456', {'type' => 'hd'}) #set parameters for the embed code such as changing the default video type to HD
Sproutvideo::Video.signed_embed_code('abc123','def456', {}, 1368127991) #set a specific expiration time for the signed embed code. (By default the expiration time is set to 5 minutes from the time the signed embed code was generated).
Sproutvideo::Video.signed_embed_code('abc123','def456', {}, nil, 'https') #Use https instead of http
```
# Upload Tokens
The following methods are available: `create`

## Create
```ruby
Sproutvideo::UploadToken.create
Sproutvideo::UploadToken.create(:return_url => 'http://example.com')
Sproutvideo::UploadToken.create(:return_url => 'http://example.com', :seconds_valid => 3600)
```

# Tags
The following methods are available: `list`, `create`, `details`, `update`, `destroy`.

## list
By default the tag listing is paginated with 25 tags per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page.

```ruby
Sproutvideo::Tag.list
Sproutvideo::Tag.list(:per_page => 10)
Sproutvideo::Tag.list(:per_page => 10, :page => 2)
```

## create

```ruby
Sproutvideo::Tag.create(:name => 'new tag')
```

## update
```ruby
Sproutvideo::Tag.update('abc123', :name => 'updated tag name')
```

## destroy
Pass in the id of the tag you wish to delete.

```ruby
Sproutvideo::Tag.destroy('abc123')
```
# Folders
The following methods are available: `list`, `create`, `details`, `update`, `destroy`.
## list
By default, the folder listing is paginated with 25 folders per page and sorted by `created_at` date in ascending order. You can pass tow parameters to control the paging: `page` and `per_page`. If you do not pass in a `parent_id` only the folders within the root folder will be returned. To get the folders in a specific folder, make sure to pass in that folder's id using the `parent_id` parameter.
```ruby
Sproutvideo::Folder.list
Sproutvideo::Folder.last(:per_page => 10)
Sproutvideo::Folder.last(:per_page => 10, :page => 2)
Sproutvideo::Folder.last(:parent_id => 'def456')
```

## create
Creating a folder without a `parent_id` will place that folder in the root folder. Passing in a `parent_id` will place the newly created folder in the folder specified by `parent_id`.

```ruby
# folder is created in the root folder.
Sproutvideo::Folder.create(:name => 'New Folder')

# folder is created as a child of the folder specified by the id 'def456'
Sproutvideo::Folder.create(:name => 'New Folder', :parent_id => 'def456')
```

## details
```ruby
Sproutvideo::Folder.details('def456')
```

## update
```ruby
Sproutvideo::Folder.update('def456', :name => 'New Folder Name')
```

## delete
By default, when deleting a folder, all of the contents of that folder (videos and folders), will be moved the root folder to prevent unintended data loss. If you wish to actually delete all of the content of a folder, make sure to pass in `delete_all` as true.

```ruby
# delete the folder and move it's contents to the root folder
Sproutvideo::Folder.destroy('def456')

# delete the folder and everything in it.
Sproutvideo::Folder.destroy('def456', :delete_all => true)
```

# Playlists
The following methods are available: `list`, `create`, `details`, `update`, `destroy`.
## list
By default the playlist listing is paginated with 25 playlists per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page.

```ruby
Sproutvideo::Playlist.list
Sproutvideo::Playlist.list(:per_page => 10)
Sproutvideo::Playlist.list(:per_page => 10, :page => 2)
```

## create
You can add videos to a playlist when creating it by passing in the videos you'd like to add in the videos parameter in the order you'd like them to appear.

```ruby
Sproutvideo::Playlist.create(
  :title => 'New Playlist',
  :privacy => 2,
  :videos => ['abc123','def456','ghi789'])
```
## update

```ruby
Sproutvideo::Playlist.update('abc123',
  :title => 'Update Playlist Title')
```
### videos
To add a video to a playlist, make sure to include all of the videos currently associated with that playlist. For instance if the playlist already has videos with the ids "abc" and "123" and you want to add a video with the id "def" do pass "abc", "123" and "def" to the update method.

```ruby
Sproutvideo::Playlist.update('abc123',
  :videos => ["abc", "123", "def"])
```

If you want to remove a video from a playlist, remove the video from the list of videos in the playlist but make sure to include all of the videos you wish to keep. For instance, if you now want to remove the video with id "123" from the example above, pass in "abc" and "def"

```ruby
Sproutvideo::Playlist.update("abc123",
  :videos => ["abc","def"])
```

You can remove all of the videos from a playlist by just passing an empty array as the videos parameter.

```ruby
Sproutvideo::Playlist.update('abc123', :videos => [])
```

## destroy
Pass in the id of the playlist you wish to delete.

```ruby
Sproutvideo::Playlist.destroy('abc123')
```

# Logins
The following methods are available: `list`, `create`, `details`, `update`, `destroy`

## list
By default the login listing is paginated with 25 tags per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page.

```ruby
Sproutvideo::Login.list
Sproutvideo::Login.list(:per_page => 10)
Sproutvideo::Login.list(:per_page => 10, :page => 2)
```

## create
Create takes two required parameters, `email` and `password`, which will be used to allow a viewer to login to watch a video if the login has an assocaited `access_grant` for that video.

```ruby
Sproutvideo::Login.create(
  :email => 'test@example.com',
  :password => 'thisisthepassword')
```

## details
The string passed to details is the ID of a SproutVideo login.

```ruby
Sproutvideo::Login.details('abc123')
```

## update

You can change the password for a login.

```ruby
Sproutvideo::Login.update('abc123',
  :password => 'newpassword')
```

## destroy
Pass in the id of the login you wish to delete.

```ruby
Sproutvideo::Login.destroy('asdf1234')
```

# Access Grants
The following methods are available: `list`, `create`, `details`, `update`, `destroy`

## list
By default the access grant listing is paginated with 25 tags per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page.

```ruby
Sproutvideo::AccessGrant.list
Sproutvideo::AccessGrant.list(:per_page => 10)
Sproutvideo::AccessGrant.list(:per_page => 10, :page => 2)
```

## create
Create takes two required parameters, `video_id` and `login_id`, which will be used to allow a viewer to login to watch a video based on the other optional parameters.

```ruby
Sproutvideo::AccessGrant.create(
  :video_id => 'abc123',
  :login_id => 'abc123')
```
## bulk_create
bulk_create takes an array of access grant objects and creates them in a single API call to efficiently create access grants in bulk and reduce the number of API calls needed.

```ruby
Sproutvideo::AccessGrant.bulk_create([
  {
    :video_id => 'abc123',
    :login_id => 'abc123'
  },{
    :video_id => 'def456',
    :login_id => 'def456'
  }
])
```

## details
The string passed to details is the ID of a SproutVideo login.

```ruby
Sproutvideo::AccessGrant.details('abc123')
```

## update

You can change the optional parameters for an access grant.

```ruby
Sproutvideo::AccessGrant.update('abc123',
  :allowed_plays => 20,
  :access_ends_at => DateTime.parse('8/4/2014'))
```

## destroy
Pass in the id of the access grant you wish to delete.

```ruby
Sproutvideo::AccessGrant.destroy('asdf1234')
```
#Analytics
The following methods are available through the API client for analytics:

* play_counts
* domains
* geo
* video_types
* playback types
* device_types

Check the API documentation for more information about the data returned by these calls.

Each method can be called on it's own for overall account data for all time like this:
```ruby
Sproutvideo::Analytics.play_counts
Sproutvideo::Analytics.download_counts
Sproutvideo::Analytics.domains
Sproutvideo::Analytics.geo
Sproutvideo::Analytics.video_types
Sproutvideo::Analytics.playback_types
Sproutvideo::Analytics.device_types
```
Each method can also take an options hash containing a :video_id for retrieving overall data for a specific video:
```ruby
Sproutvideo::Analytics.play_counts(:video_id => 'abc123')
Sproutvideo::Analytics.download_counts(:video_id => 'abc123')
Sproutvideo::Analytics.domains(:video_id => 'abc123')
Sproutvideo::Analytics.geo(:video_id => 'abc123')
Sproutvideo::Analytics.video_types(:video_id => 'abc123')
Sproutvideo::Analytics.playback_types(:video_id => 'abc123')
Sproutvideo::Analytics.device_types(:video_id => 'abc123')
```
The following methods can also take an options hash containing a :live_stream_id for retrieving overall data for a specific live_stream:
```ruby
Sproutvideo::Analytics.play_counts(:live_stream_id => 'abc123')
Sproutvideo::Analytics.domains(:live_stream_id => 'abc123')
Sproutvideo::Analytics.geo(:live_stream_id => 'abc123')
Sproutvideo::Analytics.device_types(:live_stream_id => 'abc123')
```
Each method can also take an optional :start_date and :end_date to specify a date range for the returned data:
```ruby
Sproutvideo::Analytics.play_counts(:start_date => '2013-01-01')
Sproutvideo::Analytics.device_types(:video_id => 'abc123', :end_date => '2012-12-31')
```

The geo method can take an optional :country to retrieve playback data by city within that country
```ruby
Sproutvideo::Analytics.geo(:video_id => 'abc123', :country => 'US')
```

## Misc endpoints
see api docs for more info

```ruby
Sproutvideo::Analytics.popular_videos
SproutVideo::Analytics.popular_downloads
```

```ruby
Sproutvideo::Analytics.live_stream_overview('abc123')
```

# Engagement
You can grab the total number of seconds of your videos that have been watched like this:
```ruby
Sproutvideo::Analytics.engagement
```

and for all livestreams:
```ruby
Sproutvideo::Analytics.live_stream_engagement
```

You can grab engagement for a specific video like so:
```ruby
Sproutvideo::Analytics.engagement(:video_id => 'abc123')
```

or for a specific live stream:
```ruby
Sproutvideo::Analytics.live_stream_engagement(:live_stream_id => 'abc123')
```

You can grab playback sessions data for your videos with:
```ruby
Sproutvideo::Analytics.engagement_sessions
```

and for live streams with
```ruby
Sproutvideo::Analytics.live_stream_engagement_sessions
```

Lastly, you can grab every single playback session for a video like this:
```ruby
Sproutvideo::Analytics.engagement_sessions('abc123')
Sproutvideo::Analytics.engagement_sessions('abc123', page: 3)
Sproutvideo::Analytics.engagement_sessions('abc123', page: 3, :per_page => 40)
```

and for a live stream:
```ruby
Sproutvideo::Analytics.live_stream_engagement_sessions('abc123')
```

You can also grab engagement sessions for a video for a specific email address like so:
```ruby
Sproutvideo::Analytics.engagement_sessions(video_id: 'abc123', vemail: 'test@example.com')
```

# Account
The following methods are available: `details`, `update`.

## details
To get information about your account:

```ruby
Sproutvideo::Account.details
```

## update
To update account settings:

```ruby
Sproutvideo::Account.update({download_sd: true})
```

# Subtitles
The following methods are available: `list`, `create`, `details`, `update`, `destroy`. All requests for a subtitle must be given a `video_id` option indicating the video that you want to access or update the subtitles of.

## list
By default the subtitle listing is paginated with 25 tags per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page.

```ruby
Sproutvideo::Subtitle.list(:video_id => 'abc123')
Sproutvideo::Subtitle.list(:video_id => 'abc123', :per_page => 10)
Sproutvideo::Subtitle.list(:video_id => 'abc123', :per_page => 10, :page => 2)
```

## create
Create takes three required parameters, `video_id`, `language`, and `content`, which will be to add the newly created subtitle file and associate it with the provided video id.

```ruby
Sproutvideo::Subtitle.create(
  :video_id => 'abc123',
  :language => 'en',
  :content => 'WEBVTT FILE...')
```

## details
pass both the video and the subtitle id.

```ruby
Sproutvideo::Subtitle.details(:video_id => 'abc123', id: 'fdc432')
```

## update

You can change the optional parameters for a subtitle.

```ruby
Sproutvideo::Subtitle.create(
  :video_id => 'abc123',
  :language => 'de',
  :id => 'fdc432')
```

## destroy
Pass in the id of the subtitle you wish to delete.

```ruby
Sproutvideo::Subtitle.destroy(:video_id => 'abc123', id: 'fdc432')
```

# Calls to Action
The following methods are available: `list`, `create`, `details`, `update`, `destroy`. All requests for a call to action must be given a `video_id` option indicating the video that you want to access or update the calls to action of.

## list
By default the call to action listing is paginated with 25 tags per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page.

```ruby
Sproutvideo::CallToAction.list(:video_id => 'abc123')
Sproutvideo::CallToAction.list(:video_id => 'abc123', :per_page => 10)
Sproutvideo::CallToAction.list(:video_id => 'abc123', :per_page => 10, :page => 2)
```

## create
Create takes five required parameters, `video_id`, `text`, `url`, `start_time`, and `end_time`, which will be to add the newly created subtitle file and associate it with the provided video id.

```ruby
Sproutvideo::CallToAction.create(
  :video_id => 'abc123',
  :text => 'join now',
  :start_time => 1,
  :end_time => 2,
  :content => 'https://sproutvideo.com')
```

## details
pass both the video and the call to action id.

```ruby
Sproutvideo::CallToAction.details(:video_id => 'abc123', id: 'fdc432')
```

## update

You can change the optional parameters for a call to action.

```ruby
Sproutvideo::CallToAction.create(
  :video_id => 'abc123',
  :text => 'get it done!',
  :id => 'fdc432')
```

## destroy
Pass in the id of the call to action you wish to delete.

```ruby
Sproutvideo::CallToAction.destroy(:video_id => 'abc123', id: 'fdc432')
```

# Live Streams
The following methods are available: `list`, `create`, `details`, `update`, `destroy`, and `end_stream`.

## list
By default the call to action listing is paginated with 25 tags per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page.

```ruby
Sproutvideo::LiveStream.list
Sproutvideo::LiveStream.list(:per_page => 10, :page => 2)
```

## create

```ruby
Sproutvideo::LiveStream.create(title: 'hello')
# with a poster frame
Sproutvideo::LiveStream.create(title: 'hello', custom_poster_frame: '/path/to/posterframe.jpg')
```

## details

```ruby
Sproutvideo::LiveStream.details('abc123')
```

## update
You can change the optional parameters

```ruby
Sproutvideo::LiveStream.update(title: 'get it done!')
# with a poster frame
Sproutvideo::LiveStream.update(title: 'hello', custom_poster_frame: '/path/to/posterframe.jpg')
```

## destroy

```ruby
Sproutvideo::LiveStream.destroy('abc123')
```

## end_stream

```ruby
Sproutvideo::LiveStream.end_stream('abc123')
```

# Contributing to sproutvideo-rb

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright (c) 2021 SproutVideo. See LICENSE.txt for
further details.
