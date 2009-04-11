class Volume

	def initialize
		self.left_channel = self.right_channel = 99
	end

	attr_accessor :left_channel, :right_channel

	def set(volume)
		self.left_channel = self.right_channel = volume
	end

	def to_s
		"channels: #{self.left_channel} - #{self.right_channel}"
	end

end