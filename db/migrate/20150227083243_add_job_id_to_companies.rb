class AddJobIdToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :job_id, :integer
  end
end
