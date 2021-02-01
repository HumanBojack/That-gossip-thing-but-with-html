require 'gossip'
class ApplicationController < Sinatra::Base

	get "/" do 
		erb :index, locals: {gossips: Gossip.all}
	end

	get "/gossips/new/" do 
		erb :new_gossips
	end

	post "/gossips/new/" do 
		puts "Voici params: #{params}"
		puts "L'auteur: #{params["gossip_author"]}"
		puts "Le message #{params["gossip_content"]}"
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		redirect "/"
	end

	get "/gossips/:id" do |id| #id peut être remplacé par params["id"]
		erb :show, locals: {id: id, gossip: Gossip.find(id)}
	end

	get "/gossips/:id/edit/" do |id|
		erb :edit, locals: {id: id}
	end

	post "/gossips/:id/edit/" do |ide|
		Gossip.update(ide, params["gossip_author"], params["gossip_content"])
		redirect "/"
	end
end