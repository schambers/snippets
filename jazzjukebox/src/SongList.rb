class SongList

	MAX_TIME = 5*60

	def initialize()
		@songs = Array.new
		@index = WordList.new
	end

	def append(song)
		@songs.push(song)
		@index.add_to_index(song, song.name, song.artist)
		self
	end

	def lookup(word)
		@index.lookup(word)
	end

	def delete_first()
		@songs.shift
	end

	def delete_last()
		@songs.pop
	end

	def [](index)
		@songs[index]
	end

	def with_title(title)
		@songs.find {|song| title == song.name}
	end

	def SongList.is_too_long(song)
		return song.duration > MAX_TIME
	end

end
