require 'song'
require 'songlist'
require 'songloader'
require 'songlogger'
require 'wordlist'
require 'volume'

song = Song.new('Henry the Octopus', 'The Wiggles', 60)
puts song.to_s
puts "SongLogger"
puts SongLogger.create.object_id
puts SongLogger.create.object_id

puts "---Song Loader---"
song_loader = SongLoader.new
song_loader.load()

puts "---- SongLoader.songs.lookup ----"
puts song_loader.songs.lookup("Chambers")
puts "---- End SongLoader ----"

volume = Volume.new
puts volume.to_s
volume.set(10)
puts volume.to_s

#
# Tests
# 
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
