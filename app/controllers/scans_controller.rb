class ScansController < ApplicationController
  before_action :set_scan, only: [:show, :edit, :update, :destroy]
  before_filter :login_required

  # GET /scans
  # GET /scans.json
  def index
    if current_user.scans.empty? || current_user.username = "corbin_page"
      @scans = Scan.all
    else
      @scans = current_user.scans
    end
  end

  # GET /scans/1
  # GET /scans/1.json
  def show
    redirect_to dashboard_path(params[:id])
  end

  # GET /scans/new
  def new
    @scan = Scan.new
  end

  # GET /scans/1/edit
  def edit
  end

  # POST /scans
  # POST /scans.json
  def create
    @scan = Scan.create(scan_params)
    @scan.user = current_user
    Tweet.initialize_twitter_client
    @user = Tweet.client.user(@scan.username)
    # Need to put in logic if the twitter user does not exist
    @scan.twitter_detail = TwitterDetail.new(TwitterDetail.user_attributes(@user))
    @scan.save
    @scan.run
    # Stalker.enqueue("scan.run", id: @scan.id)
    
    respond_to do |format|
      if @scan.save
        format.html { redirect_to @scan, notice: 'Scan was successfully created.' }
        format.json { render action: 'show', status: :created, location: @scan }
      else
        format.html { render action: 'new' }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scans/1
  # PATCH/PUT /scans/1.json
  def update
    respond_to do |format|
      if @scan.update(scan_params)
        format.html { redirect_to @scan, notice: 'Scan was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @scan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scans/1
  # DELETE /scans/1.json
  def destroy
    puts @scan.inspect
    @scan.destroy
    respond_to do |format|
      format.html { redirect_to scans_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scan
      @scan = Scan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scan_params
      params.require(:scan).permit(:username)
    end
end
