require "rapgenius"
require "mongoid"

Mongoid.configure do |config|
	config.connect_to("dsbs")
end

class Split
	include Mongoid::Document
	field :title, type: String
	field :lyrics, type: String
	field :annotations, type: String
	field :pyongs, type: Integer
	field :views, type: Integer
	field :hot, type: String
	field :index, type: Integer

	def full_title(song_id)
		RapGenius::Song.find(song_id).title
	end
	
	def full_lyrics(song_id)
		song = RapGenius::Song.find(song_id)
		song.lines.map do |line|
			line.lyric
		end.join("\n")
	end

	def full_annotations(song_id)
		song = RapGenius::Song.find(song_id)
		if song.lines
			song.lines.map do |line|
				line.annotations
			end.join("\n")
		end
	end

	def pyongs(song_id)
		RapGenius::Song.find(song_id).pyongs
	end

	def views(song_id)
		RapGenius::Song.find(song_id).views
	end

	def hot(song_id)
		RapGenius::Song.find(song_id).hot?
	end
end