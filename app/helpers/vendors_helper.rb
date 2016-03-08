module VendorsHelper
	# Returns the Gravatar for the given user.
  def gravatar_for(vendor)
    gravatar_id = Digest::MD5::hexdigest(vendor.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: vendor.username, class: "gravatar")
  end
end
