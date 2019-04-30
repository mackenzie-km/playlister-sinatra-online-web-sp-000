class SongGenre < ActiveRecord::Base
  self.table_name = "songs_genres"
  belongs_to :song
  belongs_to :genre
end
