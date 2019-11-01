class CreateCats < ActiveRecord::Migration[6.0]

  def change
    create_table :cats do |t|
      t.date :birth_date, null: false
      t.string :color
      t.string :name, null: false
      t.string :sex, null: false
      t.string :description

      t.timestamps
    end
    add_index :cats, :name
    add_index :cats, :birth_date
  end

end
