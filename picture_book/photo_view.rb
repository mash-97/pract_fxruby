class PhotoView < FXImageFrame
	MAX_WIDTH = 200
	MAX_HEIGHT = 200
	
	def initialize(p, photo)
		super(p, nil)
		load_image(photo.path)
		
	end
	
	def load_image(path)
		File.open(path, "rb") do |io|
			self.image = FXJPGImage.new(self.app(), io.read)
			scale_to_thumbnail()
		end
	end
	
	def scaled_width(width)
		[width, MAX_WIDTH].min
	end
	
	def scaled_height(height)
		[height, MAX_HEIGHT].min
	end
	
	def scale_to_thumbnail()
		aspect_ratio = self.image.width.to_f/self.image.height
		if true then
			self.image.scale(MAX_WIDTH, MAX_HEIGHT, 2)
			
		elsif self.image.width > self.image.height then
			self.image.scale(
				scaled_width(self.image.width()), 
				scaled_height(self.image.width())/aspect_ratio, 
				1
			)
		else
			self.image.scale(
				aspect_ratio*scaled_height(image.height),
				scaled_height(self.image.height),
				1
			)
		end
	end
end


