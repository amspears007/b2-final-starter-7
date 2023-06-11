require "rails_helper"

RSpec.describe "Coupon Show" do
  before :each do
    coupon_test_data
  end

  describe "US3 Merchant Coupon Show Page" do
    it " see that coupon's name and code And I see the percent/dollar off value As well as its status (active or inactive)
    And I see a count of how many times that coupon has been used." do
      visit merchant_coupon_path(@merchant1, @coupon1)
# save_and_open_page
      expect(page).to have_content("Name: #{@coupon1.name}")
      expect(page).to have_content("Code: #{@coupon1.unique_code}")
      expect(page).to have_content("Amount Off: #{@coupon1.amount_off} #{@coupon1.discount}")
      expect(page).to have_content("Status: #{@coupon1.status}")
      expect(page).to have_content("Number of times Used: #{@coupon1.counts_use}")
      end
    end

    describe "US4 Merchant Coupon Deactivate" do
      it "I see a button to deactivate that coupon When I click that button I'm taken back to the coupon show page And I can see that its status is now listed as 'inactive'." do
      visit merchant_coupon_path(@merchant1, @coupon1)
      expect(page).to have_button("Deactivate")
      click_button("Deactivate")
      
      save_and_open_page
      expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
      expect(page).to have_content("Status: Deactivated")
      # expect(page).to have_button("Activate")
      # require 'pry'; binding.pry
      end
    end
  end

#   Merchant Coupon Deactivate

# As a merchant 
# When I visit one of my active coupon's show pages
# I see a button to deactivate that coupon
# When I click that button
# I'm taken back to the coupon show page 
# And I can see that its status is now listed as 'inactive'.

# * Sad Paths to consider: 
# 1. A coupon cannot be deactivated if there are any pending invoices with that coupon.

  