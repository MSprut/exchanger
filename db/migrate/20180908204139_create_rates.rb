class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.date :rate_period
      t.decimal :rate_value, precision: 6, scale: 4, null: false, default: 0.00
      t.timestamps
    end

    add_index :rates, :rate_period
  end
end
