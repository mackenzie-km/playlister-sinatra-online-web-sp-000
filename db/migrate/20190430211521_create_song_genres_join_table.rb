class CreateSongGenresJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :song_genres, id: false do |t|
      t.integer :song_id
      t.integer :genre_id
    end
  end
end
