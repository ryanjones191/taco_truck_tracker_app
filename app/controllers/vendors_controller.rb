class VendorsController < ApplicationController
  def new
  	@vendor = Vendor.new
  end

  def show
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

  private

    def vendor_params
      params.require(:vendor).permit(:username, :email, :company, :password,
                                   :password_confirmation)
    end
end
