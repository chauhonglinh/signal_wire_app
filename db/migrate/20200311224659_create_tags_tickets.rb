class CreateTagsTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tags_tickets do |t|
      t.references :tag, null: false, foreign_key: true
      t.references :ticket, null: false, foreign_key: true

      t.timestamps
    end
  end
end
