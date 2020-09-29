
class AlbumListView < FXList
	attr_reader :album_list
	
	def initialize(parent, opts, album_list)
		super(parent, opts: opts)
		@album_list = album_list
		@album_list.each_album do |album|
			self.add_album(album)
		end
	end
	
	def layout()
		puts("album_list_view: width: #{width()}, height: #{height()}")
		super()
	end
	
	def add_album(album)
		self.appendItem(album.title)
	end
end

