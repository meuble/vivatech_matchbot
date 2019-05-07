class CreateData < ActiveRecord::Migration[6.0]
  def change
    create_table :data do |t|
      t.string :skin_type
      t.string :prefered_color
      t.string :prefered_scent
      t.string :age_group
      t.string :prefered_brand

      t.timestamps
    end
  end
end
