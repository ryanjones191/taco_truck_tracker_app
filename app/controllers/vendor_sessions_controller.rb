class VendorSessionsController < ApplicationController
  def new
  end

  def create
    vendor = Vendor.find_by(email: params[:session][:email].downcase)
    if vendor && vendor.authenticate(params[:session][:password])
      vendor_log_in vendor
      params[:session][:remember_me] == '1' ? vendor_remember(vendor) : vendor_forget(vendor)
      redirect_back_or vendor
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    vendor_log_out if vendor_logged_in?
    redirect_to root_url
  end
end
