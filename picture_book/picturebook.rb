require 'fox16'
include Fox

require_relative 'photo'
require_relative 'photo_view'
require_relative 'album'
require_relative 'album_view'
require_relative 'album_list'
require_relative 'album_list_view'


class PictureBook < FXMainWindow

	def initialize(app)
		super(app, "Picture Book", width: 627, height: 451)
		self.add_menu_bar()
		
		splitter = FXSplitter.new(self, opts: SPLITTER_HORIZONTAL|LAYOUT_FILL)
		
		@album = Album.new("My Photos")
		@album_list = AlbumList.new
		@album_list.add_album(@album)
		@album_list_view = AlbumListView.new(splitter, LAYOUT_FILL_Y, @album_list)
		@album_view = AlbumView.new(splitter, @album)		
		
	end
	
	def create()
		super()
		show(PLACEMENT_SCREEN)
	end
	
	def add_menu_bar()
		menu_bar = FXMenuBar.new(self, LAYOUT_SIDE_TOP|LAYOUT_FILL_X)
		self.add_file_menu_pane_to(menu_bar)
		self.add_view_menu_pane_to(menu_bar)
	end
	
	def add_view_menu_pane_to(menu_bar)
		view_menu = FXMenuPane.new(self)
		FXMenuTitle.new(menu_bar, "View", popupMenu: view_menu)
		
		size_cmd = FXMenuCommand.new(view_menu, "Size")
		size_cmd.connect(SEL_COMMAND) do 
			puts("View \n\t--> Size")
		end
		
		zoom_cmd = FXMenuCommand.new(view_menu, "Zoom")
		zoom_cmd.connect(SEL_COMMAND) do 
			puts("View \n\t--> Zoom")
		end
	end
	
	def add_file_menu_pane_to(menu_bar)
		file_menu = FXMenuPane.new(self)
		FXMenuTitle.new(menu_bar, "File", popupMenu: file_menu)
		
		import_cmd = FXMenuCommand.new(file_menu, "Import...")
		import_cmd.connect(SEL_COMMAND) do
			# ...
			dialog = FXFileDialog.new(self, "Import Photos")
			dialog.selectMode = SELECTFILE_MULTIPLE
			dialog.patternList = ["JPEG Images (*.jpg, *.jpeg)"]
			if dialog.execute != 0 then
				puts("dialog.filenames: ")
				puts(dialog.filenames)
				self.import_photos(dialog.filenames)
			end
		end
		
		exit_cmd = FXMenuCommand.new(file_menu, "Exit")
		exit_cmd.connect(SEL_COMMAND) do
			self.exit()
		end
	end
	
	def import_photos(filenames)
		filenames.each do |filename|
			photo = Photo.new(filename)
			@album.add_photo(photo)
			@album_view.add_photo(photo)
		end
		
		@album_view.create()
	end
	
	def layout()
		puts("width: #{self.width()}, height: #{self.height()}")
		super()
	end
end


if __FILE__ == $0	then
	FXApp.new do |app| 
		PictureBook.new(app)
		app.create()
		app.run()
	end
end
