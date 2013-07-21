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
		#user = User.new(response.symbolize_keys)
		#if user.valid?
		#	user.save!
		#else
		#	raise "Error".inspect
		#end
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