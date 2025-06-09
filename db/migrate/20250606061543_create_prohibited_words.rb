class CreateProhibitedWords < ActiveRecord::Migration[7.2]
  def change
    create_table :prohibited_words do |t|
      t.string :word

      t.timestamps
    end
  end
end
