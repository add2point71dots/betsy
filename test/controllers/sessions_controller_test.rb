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
  end
end
