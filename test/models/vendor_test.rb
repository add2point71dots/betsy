require "test_helper"

describe Vendor do
  describe "validations" do
    let(:new_tobias) { Vendor.new(uid: 89098, provider: "github", email: "tobias2@example.com", username: "mrs_featherbottom") }
    let(:new_maeby) { Vendor.new(uid: 3948, provider: "github", email: "maeby@example.com", username: "babysitme") }

    it "requires a username" do
      vendor = vendors(:no_username)
      vendor.valid?.must_equal false
      vendor.errors.messages.must_include :username
    end

    it "username must be unique" do
      new_tobias.valid?.must_equal false
      new_tobias.errors.messages.must_include :username
    end

    it "requires an email" do
      vendor = vendors(:no_email)
      vendor.valid?.must_equal false
      vendor.errors.messages.must_include :email
    end

    it "email must be unique" do
      new_maeby.valid?.must_equal false
      new_maeby.errors.messages.must_include :email
    end

    it "requires a uid" do
      vendor = vendors(:no_uid)
      vendor.valid?.must_equal false
      vendor.errors.messages.must_include :uid
    end

    it "requires a provider" do
      vendor = vendors(:no_provider)
      vendor.valid?.must_equal false
      vendor.errors.messages.must_include :provider
    end

    it "can create a vendor that passes validations" do
      vendor = Vendor.new
      vendor.username = "theoneson"
      vendor.email = "michael@example.com"
      vendor.uid = 242424242
      vendor.provider = "github"
      vendor.save.must_equal true
    end
  end

  describe "relations" do
    #add relations tests
  end
end
