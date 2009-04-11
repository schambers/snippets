class SongLogger

	private_class_method :new

	@@logger = nil

	def self.create
		@@logger = new unless @@logger
		@@logger
	end	

end