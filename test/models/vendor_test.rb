require "test_helper"

describe Vendor do
  let(:vendor) { Vendor.new }

  it "must be valid" do
    value(vendor).must_be :valid?
  end
end
