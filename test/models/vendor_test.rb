require "test_helper"

describe Vendor do
  describe "validations" do
    let(:new_tobias) { Vendor.new(uid: 89098, provider: "github", email: "tobias2@example.com", username: "mrs_featherbottom") }
    let(:new_maeby) { Vendor.new(uid: 3948, provider: "github", email: "maeby@example.com", username: "babysitme") }
    let(:no_uid) { Vendor.new(provider: "google", email: "george@example.com", username: "pop-pop") }
    let(:no_provider) { Vendor.new(uid: 808080, email: "lucille@example.com", username: "lucille1") }
    let(:no_username) { Vendor.new(uid: 456, provider: "google", email: "buster@example.com") }
    let(:no_email) { Vendor.new(uid: 90, provider: "google", username: "ivemadeahugemistake") }

    it "requires a username" do
      no_username.valid?.must_equal false
      no_username.errors.messages.must_include :username
    end

    it "username must be unique" do
      new_tobias.valid?.must_equal false
      new_tobias.errors.messages.must_include :username
    end

    it "requires an email" do
      no_email.valid?.must_equal false
      no_email.errors.messages.must_include :email
    end

    it "email must be unique" do
      new_maeby.valid?.must_equal false
      new_maeby.errors.messages.must_include :email
    end

    it "requires a uid" do
      no_uid.valid?.must_equal false
      no_uid.errors.messages.must_include :uid
    end

    it "requires a provider" do
      no_provider.valid?.must_equal false
      no_provider.errors.messages.must_include :provider
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
    it "can access products if a vendor has some" do
      vendor_products = vendors(:one).products
      vendor_products.first.class.must_equal Product
      vendor_products.last.class.must_equal Product
    end

    it "returns correct number of products for a vendor" do
      vendor_products = vendors(:three).products
      vendor_products.length.must_equal 2
    end

    it "a vendor with no products returns an empty array" do
      vendor_products = vendors(:four).products
      vendor_products.must_equal []
    end
  end
end
