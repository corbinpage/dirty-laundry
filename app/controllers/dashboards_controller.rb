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
    hashtag_hash = @scan.tweets.joins(:hashtags).group("hashtags.text").count
    h = hashtag_hash.sort_by {|_key, value| value}
    gon.hashtag_values = []
    gon.hashtag_text = []
    h.reverse.each_with_index do |arr,i|
      gon.hashtag_values.push(arr[1])
      gon.hashtag_text.push(arr[0])
      break if i >= 21
    end

    mention_hash = @scan.tweets.joins(:mentions).group("mentions.text").count
    m = mention_hash.sort_by {|_key, value| value}
    gon.mention_values = []
    gon.mention_text = []
    m.reverse.each_with_index do |arr,i|
      gon.mention_values.push(arr[1])
      gon.mention_text.push(arr[0])
      break if i >= 21
    end

    @dirty_tweets = @scan.tweets.where('score > 0 AND html IS NOT NULL')
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

    @dirty_tweets = @scan.tweets.where('score > 0 AND html IS NOT NULL')
    gon.dirty_tweets = structure_dirty_tweets_for_chart(@dirty_tweets) unless @dirty_tweets.empty?
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
      t.risque_string = t.words.map(&:text)
    end
    array
  end 

end
