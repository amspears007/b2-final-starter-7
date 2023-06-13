require "rails_helper"

RSpec.describe "Coupon Show" do
  before :each do
    coupon_test_data
  end

  describe "US3 Merchant Coupon Show Page" do
    it " see that coupon's name and code And I see the percent/dollar off value As well as its status (active or inactive)
    And I see a count of how many times that coupon has been used." do
      visit merchant_coupon_path(@merchant1, @coupon1)

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

      within("#status-control")do
        expect(page).to have_content("Status: #{@coupon1.status}")
        expect(page).to have_button("Deactivate")
        click_button("Deactivate")
        
        expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
        expect(page).to have_content("Status: Deactivated")
        expect(page).to have_button("Activate")
        end
      end
    end

    describe "US5 Merchant Coupon Activate" do
      it "I visit one of my inactive coupon show pages I see a button to activate that coupon.  When I click that button I'm taken back to the coupon show page And I can see that its status is now listed as 'active'." do
      visit merchant_coupon_path(@merchant1, @coupon6)
     
      within("#status-control")do
        expect(page).to have_content("Status: #{@coupon6.status}")
        expect(page).to have_button("Activate")
        click_button("Activate")
        expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon6))
        expect(page).to have_button("Deactivate")
        expect(page).to have_content("Status: Activated")
        end
      end
    end

    it "When I have five active coupons already when I try to activate my inactive coupon I receive a flash message" do
      @coupon10 = @merchant1.coupons.create!(name: "12 Percent!!!", unique_code: "12%",amount_off: 12, discount: 1, status: 1)
      visit merchant_coupon_path(@merchant1, @coupon6)
      
      within("#status-control")do
        expect(page).to have_content("Status: #{@coupon6.status}")
        expect(page).to have_button("Activate")
        click_button("Activate")
        expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon6))
      end
      expect(page).to have_content("Can only have 5 active coupons")
    end
  end


  