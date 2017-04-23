class VendorsController < ApplicationController
  before_action :find_vendor, only: [:show]

  def index
    @vendors = Vendor.all
  end

  def show; end

  private

  def find_vendor
    @vendor = Vendor.find_by_id(params[:id])
    render_404 if !@vendor
  end
end
