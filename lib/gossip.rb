require 'csv'
class Gossip

	attr_accessor :author, :content

	def initialize(author, content)
		@author = author
		@content = content
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end

	def self.all
		@all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv|
			@all_gossips << Gossip.new(csv[0], csv[1])
		end
		return @all_gossips
	end

	def self.find(id)
		self.all[id.to_i]
	end

	def self.update(number, new_gossip_author, new_gossip_content)
		finalthing = []
		CSV.table("./db/gossip.csv", headers:false).each_with_index do |csv, id|
			(id.to_i == number.to_i) ? (finalthing << "#{new_gossip_author},#{new_gossip_content}\n"):(finalthing << csv.to_csv)
		end
		File.write("./db/gossip.csv", finalthing.join)
	end
end