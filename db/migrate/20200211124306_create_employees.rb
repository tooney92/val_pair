class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :sex
      t.string :department
      t.integer :paired_with

      t.timestamps
    end
  end
end
