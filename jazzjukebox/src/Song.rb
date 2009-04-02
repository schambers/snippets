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

class SongLogger

	private_class_method :new

	@@logger = nil

	def self.create
		@@logger = new unless @@logger
		@@logger
	end	

end

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

class WordList

	def initialize()
		@index = {}
	end

	def add_to_index(obj, *phrases)
		phrases.each do |phrase|
			phrase.scan(/\w[-\w']+/) do |word| # extract each word
				word.downcase!
				@index[word] = [] if @index[word].nil?
				@index[word].push(obj)
			end
		end
	end

	def lookup(word)
		@index[word.downcase]
	end

end

song = Song.new('Henry the Octopus', 'The Wiggles', 60)
puts song.to_s
puts song.name
puts song.artist
puts song.duration

puts SongList.is_too_long(song)
puts "\n\n"

puts "SongLogger"
puts SongLogger.create.object_id
puts SongLogger.create.object_id

puts "---Song Loader---"
song_loader = SongLoader.new
song_loader.load()

require 'test/unit'
class SongListTests < Test::Unit::TestCase

	def test_delete
		list = SongList.new

		song1 = Song.new('Bounce That', 'Girl Talk', 30)
		song2 = Song.new('Kryp Tonight', 'Girl Talk', 60)
		song3 = Song.new('Hot Blooded', 'White Snake', 2)
		song4 = Song.new('Kryptonite', 'Someone', 8)

		list.append(song1).append(song2).append(song3).append(song4)

		assert_equal(song1, list[0])
		assert_equal(song2, list[1])
		assert_nil(list[9])

		assert_equal(song1, list.delete_first)
		assert_equal(song2, list.delete_first)
		assert_equal(song4, list.delete_last)
		assert_equal(song3, list.delete_last)
	end

	def test_songloader
		song_loader = SongLoader.new
		song_loader.load()
	end

	def test_indexer
		puts '---Testing Indexer---'
		song_loader = SongLoader.new
		puts song_loader.songs.lookup("Chambers")
	end

end
