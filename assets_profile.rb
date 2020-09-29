pictures = Dir["/home/mash/Pictures/**/**"]
			.select{|file|file=~/\.(jpg|jpeg|png|)/i and File.size(file)/1024 <= 512}
			.sample(10)

