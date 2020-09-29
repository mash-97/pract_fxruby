require 'thor'

class Say < Thor
	desc "hello NAME", "say hello to NAME"
	option :from, :type => :string
	option :to, :type => :string
	
	def hello(from=nil, to=nil) 
		puts("YOH")
		puts("From: #{options[:from]}") if options[:from]
		puts("From: #{from}") if from
		puts("Hello #{options[:to]}") if options[:to]
		puts("Hello #{to}") if to
	end
end

Say.start(ARGV)

