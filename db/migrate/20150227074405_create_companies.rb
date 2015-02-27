class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string   :name,           null: false, default: ""
      t.string   :url,            null: false, default: ""
      t.string   :location,       null: false, default: ""

      t.timestamps null: false
    end
    add_index :companies, :name
    add_index :companies, :location
  end
end
