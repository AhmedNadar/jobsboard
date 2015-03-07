class AddSlugToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :slug, :string, null: false, default: ""
    add_index  :companies, :slug, unique: true
  end
end
