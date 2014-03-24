class DashboardsController < ApplicationController
  before_action :set_scan, only: [:summary, :analytics, :locations]

  # GET /dashboard/current
  def current
    redirect_to dashboard_path(current_user.scans.last.id)
  end

  # GET /dashboard/:id
  def summary
    #set_scan
  end

  # GET /dashboard/:id/analytics
  def analytics
    #set_scan
  end

  # GET /dashboard/:id/locations
  def locations
    #set_scan
  end

  def sub_layout
    "dashboard"
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_scan
    @scan = Scan.find(params[:id])
  end

end
