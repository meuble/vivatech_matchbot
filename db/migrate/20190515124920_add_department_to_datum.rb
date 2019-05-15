class AddDepartmentToDatum < ActiveRecord::Migration[6.0]
  def change
    add_column :data, :department, :string
    add_index :data, :department
    Datum.find_each do |d|
      d.update_attributes(department: d.zipcode[0..1])
    end
  end
end
