class DashboardsController < ApplicationController

  # GET /dashboard/current
  def current
    redirect_to dashboard_path(current_user.scans.last.id)
  end

  # GET /dashboard/:id
  def summary
    @scan = Scan.find(params[:id])
    @twitter_detail = @scan.user.twitter_detail
  end

  # GET /dashboard/:id/analytics
  def analytics
    @scan = Scan.find(params[:id])
    @twitter_detail = @scan.user.twitter_detail
  end

  # GET /dashboard/:id/locations
  def locations
    @scan = Scan.find(params[:id])
    @twitter_detail = @scan.user.twitter_detail
  end

  def sub_layout
    "dashboard"
  end

end
