require "rails_helper"

RSpec.describe "Coupon Show" do
  before :each do
    coupon_test_data
    # @merchant1 = Merchant.create!(name: "Dolly Parton")
    # @coupon1 = @merchant1.coupons.create!(name: "Ten Percent Off", unique_code: "10%OFF", amount_off: 10, discount: 1, status: 1)
    # @coupon2 = @merchant1.coupons.create!(name: "Five Percent Off", unique_code: "5%OFF", amount_off: 5, discount: 1, status: 1)
    # @coupon3 = @merchant1.coupons.create!(name: "Fifteen Percent Off", unique_code: "15%OFF", amount_off: 15, discount: 1, status: 1)
    # @coupon4 = @merchant1.coupons.create!(name: "Ten Dollars Off", unique_code: "10$OFF", amount_off: 10, discount: 0, status: 1)
    # @coupon5 = @merchant1.coupons.create!(name: "Twelve Percent Off", unique_code: "12%OFF",amount_off: 12, discount: 1, status: 0)

  end

  describe "US3 Merchant Coupon Show Page" do
    it " see that coupon's name and code And I see the percent/dollar off value As well as its status (active or inactive)
    And I see a count of how many times that coupon has been used." do
      visit merchant_coupon_path(@merchant1, @coupon1)
save_and_open_page
      expect(page).to have_content("Name: #{@coupon1.name}")
      expect(page).to have_content("Code: #{@coupon1.unique_code}")
      expect(page).to have_content("Amount Off: #{@coupon1.amount_off} #{@coupon1.discount}")
      expect(page).to have_content("Status: #{@coupon1.status}")
      expect(page).to have_content("Number of times Used: #{@coupon1.counts_use}")
      end
    end
  end
  # 3. Merchant Coupon Show Page 

  # As a merchant 
  # When I visit a merchant's coupon show page 
  # I see that coupon's name and code 
  # And I see the percent/dollar off value
  # As well as its status (active or inactive)
  # And I see a count of how many times that coupon has been used.
  
  # (Note: "use" of a coupon should be limited to successful transactions.)
  