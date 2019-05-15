class AddIndexesToDatum < ActiveRecord::Migration[6.0]
  def change
    add_index(:data, :skin_type)
    add_index(:data, :prefered_color)
    add_index(:data, :prefered_brand)
    add_index(:data, :age_group)
    add_index(:data, :zipcode)
  end
end
