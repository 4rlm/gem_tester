class AddAddressToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :street, :string
    add_column :articles, :city, :string
    add_column :articles, :state, :string
    add_column :articles, :zip, :string
    add_column :articles, :full_address, :string
    add_column :articles, :phone, :string
    add_column :articles, :email, :string
    add_column :articles, :url, :string
  end
end
