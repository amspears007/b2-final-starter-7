require "rails_helper"

RSpec.describe "Coupon Index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Dolly Parton")
    @coupon1 = @merchant1.coupons.create!(name: "Ten Percent Off", unique_code: "10%OFF", amount_off: 10, discount: 1, status: 1)
    @coupon2 = @merchant1.coupons.create!(name: "Five Percent Off", unique_code: "5%OFF", amount_off: 5, discount: 1, status: 1)
    @coupon3 = @merchant1.coupons.create!(name: "Fifteen Percent Off", unique_code: "15%OFF", amount_off: 15, discount: 1, status: 1)
    @coupon4 = @merchant1.coupons.create!(name: "Ten Dollars Off", unique_code: "10$OFF", amount_off: 10, discount: 0, status: 1)
    @coupon5 = @merchant1.coupons.create!(name: "Twelve Percent Off", unique_code: "12%OFF",amount_off: 12, discount: 1, status: 0)

  end

  describe "US1 merchant_coupons_path(@merchant1)" do
    it "I see all of my coupon names including their amount off And each coupon's name is also a link to its show page." do
      visit merchant_coupons_path(@merchant1)
# save_and_open_page
      within("h2") do
        expect(page).to have_content("Coupon Index Page")
      end

      within("#coupon-#{@coupon1.id}") do
        expect(page).to have_content("Coupon Name: #{@coupon1.name}")
        expect(page).to have_content("Amount Off: #{@coupon1.amount_off} #{@coupon1.discount}")
        expect(page).to have_link("#{@coupon1.name}")
        click_link("#{@coupon1.name}")
        expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon1))
      end

      # within("#coupon-#{@coupon2.id}") do
      #   expect(page).to have_content("Name: #{@coupon2.name}")
      #   expect(page).to have_content("Amount Off: #{@coupon2.amount_off} #{@coupon2.discount}")
      #   expect(page).to have_link("#{@coupon2.name}")
      #   click_link("#{@coupon2.name}")
      #   expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon2))
      # end 

      # within("#coupon-#{@coupon3.id}") do
      #   expect(page).to have_content("Name: #{@coupon3.name}")
      #   expect(page).to have_content("Amount Off: #{@coupon3.amount_off} #{@coupon3.discount}")
      #   expect(page).to have_link("#{@coupon3.name}")
      #   click_link("#{@coupon3.name}")
      #   expect(current_path).to eq(merchant_coupon_path(@merchant1, @coupon3))
      # end      
    end
  end
  describe "US2 Merchant Coupon Create" do
    it "I see a link to create a new coupon. When I click that link I am taken to a new page where I see a form to add a new coupon." do
      visit merchant_coupons_path(@merchant1)
      expect(page).to have_link("Create New Coupon")
      click_link("Create New Coupon")
      expect(current_path).to eq(new_merchant_coupon_path(@merchant1))
      
      expect(page).to have_field("name")
      expect(page).to have_field("discount")
      
      fill_in "name", with: "Summer Sale"
      fill_in "unique_code", with: "SUMMER30"
      fill_in "amount_off", with: 30
      select "percent", from: "discount"
      
      click_button "Add Coupon"
      expect(current_path).to eq(merchant_coupons_path(@merchant1))
      # save_and_open_page
      expect(page).to have_content("Name: Summer Sale")
      expect(page).to have_content("Amount Off: 30 percent")
    end

    it "tests if a field isn't filled out and returns flash message prompt" do
      visit merchant_coupons_path(@merchant1)

      click_link("Create New Coupon")
      fill_in "name", with: "Summer Sale"
      fill_in "unique_code", with: ""
      fill_in "amount_off", with: 30
      select "percent", from: "discount"
      click_button "Add Coupon"

      expect(page).to have_content("Error: Please Make Sure All Fields Are Filled In Correctly")
    end

    it "tests if there are more than 5 active coupons and returns flash message prompt" do
      @merchant2 = Merchant.create!(name: "Jewel")
      @coupon1 = @merchant2.coupons.create!(name: "Ten Percent Off", unique_code: "10%OFF", amount_off: 10, discount: 1, status: 1)
      @coupon2 = @merchant2.coupons.create!(name: "Five Percent Off", unique_code: "5%OFF", amount_off: 5, discount: 1, status: 1)
      @coupon3 = @merchant2.coupons.create!(name: "Fifteen Percent Off", unique_code: "15%OFF", amount_off: 15, discount: 1, status: 1)
      @coupon4 = @merchant2.coupons.create!(name: "Ten Dollars Off", unique_code: "10$OFF", amount_off: 10, discount: 0, status: 1)
      @coupon5 = @merchant2.coupons.create!(name: "Twelve Percent Off", unique_code: "12%OFF",amount_off: 12, discount: 1, status: 1)
      # @coupon = @merchant2.coupons.create!(name: "Twelve Percent Off", unique_code: "12%OFF",amount_off: 12, discount: 1, status: 1)
      visit merchant_coupons_path(@merchant2)

      click_link("Create New Coupon")
      fill_in "name", with: "Summer Sale"
      fill_in "unique_code", with: "SUMMER30"
      fill_in "amount_off", with: 30
      select "percent", from: "discount"
      click_button "Add Coupon"
# save_and_open_page
      expect(page).to have_content("Can only have 5 active coupons")
    end
  end

  describe "US6  Merchant Coupon Index Sorted" do
    it "I can see that my coupons are separated between active and inactive coupons" do
      visit merchant_coupons_path(@merchant1)
save_and_open_page
      expect(page).to have_content("Active Coupons")
      expect(page).to have_content("Coupon Name: #{@coupon1.name}")
      expect(page).to have_content("Coupon Name: #{@coupon2.name}")
      expect(page).to have_content("Coupon Name: #{@coupon3.name}")
    end
  end
end

# 6. Merchant Coupon Index Sorted

# As a merchant
# When I visit my coupon index page
# I can see that my coupons are separated between active and inactive coupons. 

# # 2. Merchant Coupon Create 

# As a merchant
# When I visit my coupon index page 
# I see a link to create a new coupon.
# When I click that link 
# I am taken to a new page where I see a form to add a new coupon.
# When I fill in that form with a name, unique code, an amount, and whether that amount is a percent or a dollar amount
# And click the Submit button
# I'm taken back to the coupon index page 
# And I can see my new coupon listed.
# * Sad Paths to consider: 
# 1. This Merchant already has 5 active coupons
# 2. Coupon code entered is NOT unique