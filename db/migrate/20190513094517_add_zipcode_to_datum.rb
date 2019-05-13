class AddZipcodeToDatum < ActiveRecord::Migration[6.0]
  def change
    add_column :data, :zipcode, :string
  end
end
