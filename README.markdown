#SproutVideo

# Getting Started
The first thing you'll need to interact with the SproutVideo API is your API key. You can use your API key in one of two ways. The first and easiest is to set it and forget it on the Sproutvideo module like so:

```ruby
SproutVideo.api_key = 'abcd1234'
```

Alternatively, you can use an environment variable:

```ruby
ENV['SPROUTVIDEO_API_KEY']  = 'abcd1234'
```

# Videos
The following methods are available: `list`, `create`, `details`, `update`, `delete`.

##list
By default the videos listing is paginated with 25 videos per page and sorted by upload date in ascending order. You can pass two parameters to control the paging: page and per_page. You can also pass in the id of a tag to just return the videos tagged with that tag.

```ruby
Sproutvideo::Video.list
Sproutvideo::Video.list(:per_page => 10)
Sproutvideo::Video.list(:per_page => 10, :page => 2)
Sproutvideo::Video.list(:tag_id => 'abc')
```

##details
The string passed to details is the ID of a SproutVideo video.

```ruby
Sproutvideo::Video.details('abc123')
```

##create
The most basic upload you can perform is to just pass the path to the video file to the method. The title of the video will default to the name of the file.

```ruby
Sproutvideo::Video.create('/path/to/video.mp4')
```

You can set the title as well as many other parameters by passing them as a hash

```ruby
Sproutvideo::Video.create('/path/to/video.mp4', {
  :title => 'My Awesome Video',
  :description => 'This video is great',
  :privacy => 2})
```

You can also apply any number of tags to the new upload by passing their ids along:

```ruby
Sproutvideo::Video.create('/path/to/video.mp4', {
  :tags => ['ec61', 'abc123']})
```

You can also specify a webhook url. We'll send an HTTP POST with the video json when the video has finished processing or if there was an error during processing:

```ruby
Sproutvideo::Video.create('/path/to/video.mp4',{
  :notification_url => 'http://example.com/webhook_url'})
```

##update
 The first parameter is the id of the video you wish to edit. The second parameter is a hash of attributes to update on the video.

```ruby
Sproutvideo::Video.update('abc123', {:title => 'Updated Title'})
```

## Tags
To add a tag to a video, make sure to include all of the tags currently associated with the video. For instance if the video already has tags with the ids "abc" and "123" and you want to add a tag with the id "def" do pass "abc", "123" and "def" to the update method.

```ruby
Sproutvideo::Video.update('abc123', {
  :tags => ["abc", "123", "def"]})
```

If you want to remove a tag from a video, remove the tag from the list of tags on the video but make sure to include all of the tags you wish to keep. For instance, if you now want to remove the tag with id "123" from the example above, pass in "abc" and "def"

```ruby
Sproutvideo::Video.update("abc123", {
  :tags => ["abc","def"]})
```

You can remove all of the tags from a video by just passing an empty array as the tags parameter.

```ruby
Sproutvideo::Video.update('abc123', {:tags => []})
```

##delete
Pass in the id of the video you wish to delete.

```ruby
Sproutvideo::Video.delete('abc123')
```
# Tags
The following methods are available: `list`, `create`, `details`, `update`, `delete`.

##list
By default the tag listing is paginated with 25 tags per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page. 

```ruby
Sproutvideo::Tag.list
Sproutvideo::Tag.list(:per_page => 10)
Sproutvideo::Tag.list(:per_page => 10, :page => 2)
```

##create
    
```ruby
Sproutvideo::Tag.create(:name => 'new tag')
```

##update
```ruby
Sproutvideo::Tag.update('abc123', :name => 'updated tag name')
```

##delete
```ruby
Sproutvideo::Tag.delete('abc123')
```

# Playlists
The following methods are available: `list`, `create`, `details`, `update`, `delete`.
##list
By default the playlist listing is paginated with 25 playlists per page and sorted by created at date in ascending order. You can pass two parameters to control the paging: page and per_page. 
```ruby
Sproutvideo::Playlist.list
Sproutvideo::Playlist.list(:per_page => 10)
Sproutvideo::Playlist.list(:per_page => 10, :page => 2)
```

##create
You can add videos to a playlist when creating it by passing in the videos you'd like to add in the videos parameter in the order you'd like them to appear.

```ruby
Sproutvideo::Playlist.create(
  :title => 'New Playlist',
  :privacy => 2,
  :videos => ['abc123','def456','ghi789'])
```
##update

```ruby
Sproutvideo::Tag.update('abc123',
  :title => 'Update Playlist Title')
```

## videos
To add a video to a playlist, make sure to include all of the videos currently associated with that playlist. For instance if the playlist already has videos with the ids "abc" and "123" and you want to add a video with the id "def" do pass "abc", "123" and "def" to the update method.

```ruby
Sproutvideo::Playlist.update('abc123', {
  :videos => ["abc", "123", "def"]})
```

If you want to remove a video from a playlist, remove the video from the list of videos in the playlist but make sure to include all of the videos you wish to keep. For instance, if you now want to remove the video with id "123" from the example above, pass in "abc" and "def"

```ruby
Sproutvideo::Playlist.update("abc123", {
  :videos => ["abc","def"]})
```

You can remove all of the videos from a playlist by just passing an empty array as the videos parameter.

```ruby
Sproutvideo::Playlist.update('abc123', {:videos => []})
```

##delete

```ruby
Sproutvideo::Playlist.delete('abc123')
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

Copyright (c) 2012 SproutVideo. See LICENSE.txt for
further details.

