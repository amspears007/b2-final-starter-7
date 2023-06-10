class CouponsController < ApplicationController
  before_action :more_than_five?, only: [:create]

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

  def more_than_five?
    merchant = Merchant.find( params[:merchant_id])
    if merchant.active_coupon_count >= 5
      redirect_to new_merchant_coupon_path(merchant)
      flash[:alert] = "Can only have 5 active coupons"
    end
  end
end