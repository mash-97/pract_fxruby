require_relative("photo_view") if __FILE__ == $0

class AlbumView < FXScrollWindow
	attr_reader :album
	
	def initialize(p, album)
		super(p, opts: LAYOUT_FILL)
		@child = FXMatrix.new(self, opts: LAYOUT_FILL|MATRIX_BY_COLUMNS)
		
		@album = album
		@album.each_photo {|photo| self.add_photo(photo)}
	end
	
	def add_photo(photo)
		PhotoView.new(@child, photo)
	end
	
	def layout()
		@child.numColumns = [self.width()/PhotoView::MAX_WIDTH, 1].max
		super()
	end
	
end


