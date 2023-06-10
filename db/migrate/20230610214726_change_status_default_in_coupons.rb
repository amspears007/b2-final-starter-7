class ChangeStatusDefaultInCoupons < ActiveRecord::Migration[7.0]
  def change
    change_column :coupons, :status, :integer, default: 1
  end
end
