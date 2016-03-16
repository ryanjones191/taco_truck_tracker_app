class VendorsController < ApplicationController
  def new
  	@vendor = Vendor.new
  end

  def index
    @vendors = Vendor.all
    @vendors = @vendors.where(status: "true")
    @pins = Vendor.all
    @pins = @pins.where(status: "true")
    @hash = Gmaps4rails.build_markers(@pins) do |pin, marker|
      marker.lat pin.latitude
      marker.lng pin.longitude
      marker.json({:id => pin.id })
      marker.infowindow render_to_string(:partial => "/vendors/infowindow", :locals => { :object => pin})    end
  end

  def show
    @vendor = Vendor.find(params[:id])
    @reviews =Review.where(vendor_id: @vendor.id).order("created_at DESC")
    @hash = Gmaps4rails.build_markers(@vendor) do |vendor, marker|
      marker.lat vendor.latitude
      marker.lng vendor.longitude


    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def create
    @vendor = Vendor.new(vendor_params)    #@user = User.new(user_params)
    if @vendor.save
      vendor_log_in @vendor
      flash[:success] = "Welcome to the T3 App!"
      redirect_to @vendor
    else
      render 'new'
    end
  end

  def update
    @vendor = Vendor.find(params[:id])
    if @vendor.update_attributes(vendor_params)
      flash[:success] = "Profile updated"
      redirect_to @vendor 
    else
      render 'edit'
    end
  end


  private

    def vendor_params
      params.require(:vendor).permit(:username, :email, :company, :image, :website,
                          :password, :password_confirmation, :phone, :menu1, :menu2, 
                          :latitude, :longitude, :sun_open, :sun_close, :mon_open, :mon_close,
                          :tues_open, :tues_close, :weds_open, :weds_close, :thurs_open, :thurs_close,
                          :fri_open, :fri_close, :sat_open, :sat_close, :sun_loc, :mon_loc,
                          :tues_loc, :weds_loc, :thurs_loc, :fri_loc, :sat_loc)
    end
end
