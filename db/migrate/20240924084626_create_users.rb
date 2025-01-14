class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.integer :role
      t.string :token
      t.timestamps
    end
  end
end
