class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    vendor = Vendor.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])

    if vendor.nil?
      vendor = Vendor.create_from_google(auth_hash)
      if vendor.nil?
        flash[:error] = "Could not log in."
      else
        session[:vendor_id] = vendor.id
        flash[:success] = "Logged in successfully!"
      end
    else
      session[:vendor_id] = vendor.id
      flash[:success] = "Logged in successfully!"
    end

    redirect_to root_path
  end

  def logout
    session[:vendor_id] = nil
    flash[:success] = "You are now logged out."
    redirect_to root_path
  end
end
