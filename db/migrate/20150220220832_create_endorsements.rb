class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.belongs_to :review, index: true

      t.timestamps null: false
    end
    add_foreign_key :endorsements, :reviews
  end
end
