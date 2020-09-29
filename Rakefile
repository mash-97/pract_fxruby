require "mashz"
require_relative "assets_profile"


def download_assets(assets_urls, destination_dir) 
	puts("loading down gem: #{require("down")}")
	assets_urls.each do |asset_url|
		puts("Downloading: #{asset_url}")
		tempfile = Down::download(asset_url)
		FileUtils.mv(tempfile.path, File.join(destination_dir, tempfile.original_filename))
		puts("Downloaded!")
	end
end

namespace :download do
	task :test do
		puts(ARGV)
	end
	
	task :assets do |task, args|
		puts(args.keys)
	end
end

namespace :say do
	task :hello do 
		ARGV.delete("--") if ARGV.include?("--")
		puts `ruby say.rb hello #{ARGV[1..-1].join(" ")}`
		exit
	end
	
end

namespace :populate do 
	task :assets do 
		ARGV.delete("--") if ARGV.include?("--")
		puts `ruby populator.rb assets #{ARGV[1..-1].join(" ")}`
		exit
	end
end



namespace :picture_book do 
	namespace :populate do
		task :assets do
			assets_path = "./picture_book/assets"
			FileUtils.mkdir(assets_path) if not Dir.exist?(assets_path)
			puts `ruby populator.rb assets --src ~/Pictures --dest ./picture_book/assets`
		end
	end
end
