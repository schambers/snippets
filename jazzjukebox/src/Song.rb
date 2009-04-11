class Song
	
	def initialize(name, artist, duration)
		@name = name
		@artist = artist
		@duration = duration
	end

	attr_writer :duration
	attr_reader :name, :artist, :duration

	def to_s
		"Song: #@name, #@artist (#@duration seconds)"
	end
	
end