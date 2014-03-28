class DashboardsController < ApplicationController
  before_action :set_scan, only: [:summary, :analytics, :locations, :connections]
  before_filter :login_required
  
  # GET /dashboard/current
  def current
    redirect_to dashboard_path(current_user.scans.last.id)
  end

  # GET /dashboard/:id
  def summary
    #set_scan
    @dashboard_type = gon.dashboard_type = "summary"
  end

  # GET /dashboard/:id/analytics
  def analytics
    #set_scan
    @dirty_tweets = @scan.tweets.where('score > 0')
    gon.dirty_tweets = structure_dirty_tweets_for_chart(@dirty_tweets) unless @dirty_tweets.empty?
    @dashboard_type = gon.dashboard_type = "analytics"
  end

  # GET /dashboard/:id/locations
  def locations
    #set_scan
    @location_tweets = @scan.tweets.where('has_geo = true')
    gon.location_tweets = @location_tweets
    @dashboard_type = gon.dashboard_type = "locations"
  end

  # GET /dashboard/:id/connections
  def connections
    #set_scan
    # @location_tweets = @scan.tweets.where('has_geo = true')   
    # gon.location_tweets = @location_tweets.collect{|t| [t.text,t.lat,t.lng]}
    # puts gon.location_tweets
    @dashboard_type = gon.dashboard_type = "connections"
  end

  def sub_layout
    "dashboard"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_scan
    @scan = Scan.find(params[:id])
  end

  def structure_dirty_tweets_for_chart(dirty_tweets)
    array = []
    dirty_tweets.each do |t|
      array << [t.tweet_time,t.score]
    end
    array
  end 

end
