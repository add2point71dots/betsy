require "test_helper"

describe SessionsController do
  describe "auth_callback" do
    it "can login an existing user" do
      proc {
        login_vendor(vendors(:one))
        must_redirect_to root_path
        session[:vendor_id].must_equal vendors(:one).id
        flash[:success].must_equal "Logged in successfully!"
      }.must_change 'Vendor.count', 0
    end

    it "creates a new vendor first time logging in" do
      vendor = Vendor.new(name: "New Guy", uid: "908989", provider: "google_oauth2", email: "guy@example.com", username: "guy@example.com")
      proc {
        login_vendor(vendor)
        must_redirect_to root_path
        session[:vendor_id].must_equal Vendor.find_by(name: "New Guy").id
        flash[:success].must_equal "Logged in successfully!"
      }.must_change 'Vendor.count', 1
    end

    it "can't login without a uid" do
      vendor = Vendor.new(name: "New Guy", provider: "google_oauth2", email: "guy@example.com", username: "guy@example.com")
      proc {
        login_vendor(vendor)
        must_redirect_to root_path
        session[:vendor_id].must_be_nil
        flash[:error].must_equal "Could not log in."
      }.must_change 'Vendor.count', 0
    end

    it "can't login without a provider" do
      vendor = Vendor.new(name: "New Guy", uid: "908989", email: "guy@example.com", username: "guy@example.com")
      proc {
        login_vendor(vendor)
        must_redirect_to root_path
        session[:vendor_id].must_be_nil
        flash[:error].must_equal "Could not log in."
      }.must_change 'Vendor.count', 0
    end

    it "can't login without an email" do
      vendor = Vendor.new(name: "New Guy", uid: "908989", provider: "google_oauth2", username: "guy@example.com")
      proc {
        login_vendor(vendor)
        must_redirect_to root_path
        session[:vendor_id].must_be_nil
        flash[:error].must_equal "Could not log in."
      }.must_change 'Vendor.count', 0
    end
  end

  describe "logging out" do
    it "can log out" do
      login_vendor(vendors(:two))
      delete logout_path

      session[:user_id].must_be_nil
      flash[:success].must_equal "You are now logged out."
      must_redirect_to root_path
    end
  end
end
