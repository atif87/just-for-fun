class CreateProducts < ActiveRecord::Migration
  def up
		create_table :users do |t|
			t.string :id
			t.string :name
			t.string :username
			t.string :location
			t.string :bio
			t.string :gender
			t.string :hometown
  end
	end
  def down
  end
end
