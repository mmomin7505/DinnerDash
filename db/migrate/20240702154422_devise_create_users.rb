class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email, null: false, unique: true
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ##Confirmation
       t.string :confirmation_token
       t.datetime :confirmed_at
       t.datetime :confirmation_sent_at
       t.string :unconfirmed_email
     

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Additional fields
      t.string :full_name, null: false
      t.string :display_name, null: false
      t.string :role, default: 'customer'

      t.timestamps null: false
    end

  end
end
