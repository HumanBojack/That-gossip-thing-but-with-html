require 'pry'
class Comments
	attr_reader :all, :author, :comment
	@@all = Array.new
	@@all << File.read("./db/comments.json")
	def initialize(author, comment)
		@author = author
		@comment = comment
		@@all << self
	end

	def self.all
		@@all
	end

	def self.save(comments)
		File.write("./db/comments.json", comments)
	end
end
binding.pry