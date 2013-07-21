class UserController < ApplicationController
	include RestGraph::RailsUtil
  #before_filter :setup

  def show
  #	require "fbgraph"

  	#https://graph.facebook.com/608823529?fields=id,name,username,gender,hometown,location,bio
  	if params[:access_token].present?
  		require 'rest-graph'
		rg = RestGraph.new(:access_token => params[:access_token])
		data = rg.get("#{params[:id]}")
		fields = ["id", "username", "name", "gender", "hometown", "location", "bio"]
		response = {}
		fields.each { |f| response[f] = data[f]}
		u = User.new
		fields.each { |f| u[f.to_sym] = data[f]}
		if u.save!
			puts "saved"
		else
			puts "some problem in savin"
		end
		render :json => response and return
	end
  end

  private
  def setup
    rest_graph_setup(:app_id               => '123',
                     :canvas               => 'mycanvas',
                     :auto_authorize_scope => 'email')
                     # See below for more options
  end

end