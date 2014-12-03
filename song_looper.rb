require_relative "rap_genius"

file = File.open("nas_songs.txt").read
file.gsub!(/\n\n/, ",")
file.gsub!(/\n/, "")
song_list = file.split(",")
song_list.each do |song_id|
	song = Split.new
	song.index = song_id
	song.title = song.full_title(song_id)
	song.lyrics = song.full_lyrics(song_id)
	begin
		song.annotations = song.full_annotations(song_id)
	rescue
	
	ensure
		song.pyongs = song.pyongs(song_id)
		song.views = song.views(song_id)
		song.hot = song.hot(song_id)
		song.save
	end
end