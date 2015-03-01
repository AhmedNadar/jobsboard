class RemoveJobIdFromCompanies < ActiveRecord::Migration
  def change
    remove_column :companies, :job_id, :integer
  end
end
