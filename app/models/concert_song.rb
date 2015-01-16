class ConcertSong <ActiveRecord::Base
  belongs_to :song
  belongs_to :concert
end
