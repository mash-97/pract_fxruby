require "bundler/setup"
require 'mashz'
require 'thor'
require 'fileutils'
require 'digest/md5'

class Populate < Thor
	desc "assets SOURCE_DIR FILE_TYPE SIZE QUANTITY DESTINATION_DIR", 
		"populates DESTINATION_DIR with QUANTITY(default 3) files which names extended with FILE_TYPE(default .jpg) with SIZE(default 512kb) from SOURCE_DIR"
	
	option :src, :type => :string, :required => true
	option :quantity, :type => :numeric, :required => false
	option :type, :type => :string, :required => false
	option :dest, :type => :string, :required => true
	option :size, :type => :numeric, :required => false
	
	def assets()
		src_dir = options[:src]
		dest_dir = options[:dest]
		file_type = options[:type] || ".jpg"
		size = (options[:size] || 512)*1024
		quantity = options[:quantity] || 3

		files = Dir[File.join(src_dir, "**/**")]
			.select{|x|x=~/#{file_type}$/ and File.size(x) < size}
			.sample(quantity)
		
		# Collecting files MD5 sums for existency checking in the destination directory with associated file_name as a hash
		files_md5s = files.collect do |file_name|
			[File.basename(file_name), Digest::MD5.hexdigest(File.readlines(file_name, "rb").join)]
		end.to_h
			
		puts("Copyting these files into #{dest_dir}: ")
		puts(files)
		FileUtils.cp(files, dest_dir)
		
		puts()
		puts()
		# Checking if copied files exist in the destination directory
		Dir.chdir(dest_dir) do 
			fatal_count = 0
			files_md5s.each do |file_name, md5_sum|
				print("#{file_name} :: exists: #{File.exist?(file_name)} :: md5_sum_check: ")
				check = Digest::MD5.hexdigest(File.readlines(file_name, "rb").join) == md5_sum
				puts(check.to_s) 
				fatal_count += check ? 0:1
			end
			puts
			puts("Fatals: #{fatal_count}")
		end
	end.def!(:assets)
end

Populate.start(ARGV)
