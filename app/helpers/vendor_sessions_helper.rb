module VendorSessionsHelper
	# Logs in the given user.
  def vendor_log_in(vendor)
    session[:vendor_id] = vendor.id
  end

  # Remembers a user in a persistent session.
  def vendor_remember(vendor)
    vendor.vendor_remember
    cookies.permanent.signed[:vendor_id] = vendor.id
    cookies.permanent[:remember_token] = vendor.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  def current_vendor
    if (vendor_id = session[:vendor_id])
      @current_vendor ||= Vendor.find_by(id: vendor_id)
    elsif (vendor_id = cookies.signed[:vendor_id])
      vendor = Vendor.find_by(id: vendor_id)
      if vendor && vendor.vendor_authenticated?(cookies[:remember_token])
        vendor_log_in vendor
        @current_vendor = vendor
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def vendor_logged_in?
    !current_vendor.nil?
  end

  # Forgets a persistent session.
  def vendor_forget(vendor)
    vendor.vendor_forget
    cookies.delete(:vendor_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def vendor_log_out
    vendor_forget(current_vendor)
    session.delete(:vendor_id)
    @current_vendor = nil
  end
end
