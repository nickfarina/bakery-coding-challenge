class AddReadyToCookies < ActiveRecord::Migration[5.1]
  def change
    add_column :cookies, :ready, :boolean, default: false, nil: false
  end
end
