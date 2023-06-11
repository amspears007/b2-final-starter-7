require "rails_helper"

RSpec.describe "invoices show" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @merchant2 = Merchant.create!(name: "Jewelry")

    @coupon1 = @merchant1.coupons.create!(name: "Ten Percent Off", unique_code: "10%OFF", amount_off: 10, discount: 1, status: 1)
    @coupon2 = @merchant1.coupons.create!(name: "Five Percent Off", unique_code: "5%OFF", amount_off: 5, discount: 1, status: 1)
    @coupon3 = @merchant1.coupons.create!(name: "Fifteen Percent Off", unique_code: "15%OFF", amount_off: 15, discount: 1, status: 1)
    @coupon4 = @merchant1.coupons.create!(name: "Fifteen Dollars Off", unique_code: "15$OFF", amount_off: 15, discount: 0, status: 1)
    @coupon5 = @merchant1.coupons.create!(name: "Twelve Percent Off", unique_code: "12%OFF",amount_off: 12, discount: 1, status: 0)

    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
    @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
    @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
    @item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

    @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
    @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

    @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
    @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
    @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
    @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
    @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
    @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

    @invoice_1 = @coupon1.invoices.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @invoice_2 = @coupon2.invoices.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
    @invoice_3 = @coupon4.invoices.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = @coupon1.invoices.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 =@coupon3.invoices.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 =@coupon3.invoices.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)

    @invoice_8 = @coupon1.invoices.create!(customer_id: @customer_6.id, status: 1)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_5.id, quantity: 1, unit_price: 1, status: 1)
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 6, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 0, invoice_id: @invoice_6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)
    @transaction8 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_8.id)
  end

  it "shows the invoice information" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %-d, %Y"))
  end

  it "shows the customer information" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
    expect(page).to_not have_content(@customer_2.last_name)
  end

  it "shows the item information" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@ii_1.quantity)
    expect(page).to have_content(@ii_1.unit_price)
    expect(page).to_not have_content(@ii_4.unit_price)

  end

  it "shows the total revenue for this invoice" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    expect(page).to have_content(@invoice_1.total_revenue)
  end

  it "shows a select field to update the invoice status" do
    visit merchant_invoice_path(@merchant1, @invoice_1)

    within("#the-status-#{@ii_1.id}") do
      page.select("cancelled")
      click_button "Update Invoice"

      expect(page).to have_content("cancelled")
    end

    within("#current-invoice-status") do
      expect(page).to_not have_content("in progress")
    end
  end

describe "US7 Merchant Invoice Show Page: Subtotal and Grand Total Revenues" do
  it "I see the subtotal for my merchant from this invoice (that is, the total that does not include coupon discounts) And I see the grand total revenue after the discount was applied
  And I see the name and code of the coupon used as a link to that coupon's show page." do
  visit merchant_invoice_path(@merchant1, @invoice_1)
  # save_and_open_page
  within("#center-invoice-info") do
    expect(page).to have_content("#{@coupon1.name}")
    expect(page).to have_content("#{@coupon1.unique_code}")
    expect(page).to have_content(@invoice_1.total_revenue)
    expect(page).to have_content(@invoice_1.coupon_applied)
  end
end

  it "I see that no coupon is applied to my grandtotal for my merchant from an invoice that does not have a coupon" do
  visit merchant_invoice_path(@merchant1, @invoice_7)
  save_and_open_page
    within("#center-invoice-info") do
      expect(page).to have_content("No Coupon Applied")
      expect(page).to have_content("Grand Total:")
      expect(page).to have_content(@invoice_7.total_revenue)
      end
    end 
  end
end

# 7. Merchant Invoice Show Page: Subtotal and Grand Total Revenues

# As a merchant
# When I visit one of my merchant invoice show pages
# I see the subtotal for my merchant from this invoice (that is, the total that does not include coupon discounts)
# And I see the grand total revenue after the discount was applied
# And I see the name and code of the coupon used as a link to that coupon's show page.

