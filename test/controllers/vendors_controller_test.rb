require "test_helper"

describe VendorsController do
  it "should get index" do
    get vendors_path
    must_respond_with :success
  end

  describe "vendor show page" do
    it "should show one vendor" do
      get vendor_path(vendors(:one))
      must_respond_with :success
    end

    it "should show a 404 when vendor not found" do
      get vendor_path(1)
      must_respond_with :missing
    end
  end

  describe "vendor edit page" do
    it "cannot access edit page when not logged in" do
      get edit_vendor_path(vendors(:two))
      must_redirect_to root_path
      flash[:error].must_equal "You cannot access this page."
    end

    it "cannot access edit page when logged in as a different vendor" do
      login_vendor(vendors(:three))
      get edit_vendor_path(vendors(:four))
      must_redirect_to root_path
      flash[:error].must_equal "You cannot access this page."
    end

    it "vendor can get to their own edit page" do
      login_vendor(vendors(:one))
      get edit_vendor_path(vendors(:one))
      must_respond_with :success
    end

    it "should show a 404 for edit page of a vendor not found" do
      get edit_vendor_path(3)
      must_respond_with :missing
    end
  end

  describe "vendor update" do
    it "logged in vendor can update their own profile" do
      first_vendor = Vendor.first
      login_vendor(first_vendor)
      new_data = { vendor: { username: "new_username", name: "New Name" } }
      patch vendor_path(first_vendor.id), params: new_data

      Vendor.first.username.must_equal new_data[:vendor][:username]
      flash[:success].must_equal "Successfully updated profile."
    end

    it "redirects to vendor path after successfully updating" do
      first_vendor = Vendor.first
      login_vendor(first_vendor)
      new_data = { vendor: { username: "new_username", name: "New Name" } }
      patch vendor_path(first_vendor.id), params: new_data

      must_redirect_to vendor_path(first_vendor.id)
    end

    it "doesn't update if invalid data given" do
      first_vendor = Vendor.first
      login_vendor(first_vendor)
      new_data = { vendor: { username: "", name: "New Name" } }
      patch vendor_path(first_vendor.id), params: new_data

      Vendor.first.username.must_equal "besthair"
      flash.now[:error].must_equal "Error: Profile not updated."
    end


    it "doesn't update if vendor not logged in & redirects to root" do
      first_vendor = Vendor.first
      new_data = { vendor: { username: "new_username", name: "New Name" } }
      patch vendor_path(first_vendor.id), params: new_data

      must_redirect_to root_path
      Vendor.first.username.must_equal "besthair"
      flash[:error].must_equal "You cannot access this page."
    end

    it "doesn't update if different vendor logged in & redirects to root" do
      first_vendor = Vendor.first
      login_vendor(Vendor.last)
      new_data = { vendor: { username: "new_username", name: "New Name" } }
      patch vendor_path(first_vendor.id), params: new_data

      must_redirect_to root_path
      Vendor.first.username.must_equal "besthair"
      flash[:error].must_equal "You cannot access this page."
    end
  end

  describe "vendor fulfillment pages" do
    describe "correct log in" do
      before do
        login_vendor(vendors(:one))
      end

      it "vendor can access their own fulfillment page" do
        get fulfillment_path(vendors(:one).id)
        must_respond_with :success
      end

      it "vendor can access their own fulfillment pending page" do
        get fulfillment_pending_path(vendors(:one).id)
        must_respond_with :success
      end

      it "vendor can access their own fulfillment paid page" do
        get fulfillment_paid_path(vendors(:one).id)
        must_respond_with :success
      end

      it "vendor can access their own fulfillment shipped page" do
        get fulfillment_shipped_path(vendors(:one).id)
        must_respond_with :success
      end

      it "vendor can access their own fulfillment cancelled page" do
        get fulfillment_cancelled_path(vendors(:one).id)
        must_respond_with :success
      end
    end

    describe "wrong log in" do
      before do
        login_vendor(vendors(:two))
      end

      it "vendor cannot access someone else's fulfillment page" do
        get fulfillment_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end

      it "vendor cannot access someone else's fulfillment pending page" do
        get fulfillment_pending_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end

      it "vendor cannot access someone else's fulfillment paid page" do
        get fulfillment_paid_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end

      it "vendor cannot access someone else's fulfillment shipped page" do
        get fulfillment_shipped_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end

      it "vendor cannot access someone else's fulfillment cancelled page" do
        get fulfillment_cancelled_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end
    end

    describe "not logged in" do
      it "guest cannot acces a fulfillment page" do
        get fulfillment_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end

      it "guest cannot acces a fulfillment pending page" do
        get fulfillment_pending_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end

      it "guest cannot acces a fulfillment paid page" do
        get fulfillment_paid_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end

      it "guest cannot acces a fulfillment shipped page" do
        get fulfillment_shipped_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end

      it "guest cannot acces a fulfillment cancelled page" do
        get fulfillment_cancelled_path(vendors(:one).id)
        flash[:error] = "You cannot access this page."
        must_redirect_to root_path
      end
    end
  end
end
