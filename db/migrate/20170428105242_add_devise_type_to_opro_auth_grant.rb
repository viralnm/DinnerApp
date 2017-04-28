class AddDeviseTypeToOproAuthGrant < ActiveRecord::Migration
  def change
  	add_column :opro_auth_grants, :devise_token, :string
  	add_column :opro_auth_grants, :devise_type, :integer
  end
end
