class SongLoader

	attr_reader :songs

	def initialize()
		@songs = SongList.new
	end

	def load()
		File.open("songdata") do |song_file|
			song_file.each do |line|
				file, length, name, title = line.chomp.split(/\s*\|\s*/)
				name.squeeze!(" ")
				mins, secs = length.scan(/\d+/)
				@songs.append(Song.new(title, name, mins.to_i*60+secs.to_i))
			end

			puts @songs[1]
		end
	end

end