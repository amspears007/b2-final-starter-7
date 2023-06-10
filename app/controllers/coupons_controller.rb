class CouponsController < ApplicationController
  def index
    @merchant = Merchant.find( params[:merchant_id])
    @coupons = @merchant.coupons
  end

  def show
    @merchant = Merchant.find( params[:merchant_id])
    @coupons = @merchant.coupons
  end

  def new
    @merchant = Merchant.find( params[:merchant_id])
  end

  def create
    merchant = Merchant.find( params[:merchant_id])
    coupon = merchant.coupons.new(coupon_params)
    # require 'pry'; binding.pry
    if coupon.save
      redirect_to merchant_coupons_path(merchant)  
    else
      redirect_to new_merchant_coupon_path(merchant)
      flash[:alert] = "Error: Please Make Sure All Fields Are Filled In Correctly"
    end
  end

  private
  def coupon_params
    params.permit(:name, :unique_code, :amount_off, :discount, :status)
  end
end