class Artist
    attr_accessor :name
    attr_reader :songs
    @@all = []

    extend Concerns::Findable

  def initialize(name)
    @name = name
    @songs = []
  end
  def self.all
    @@all
  end
  def self.destroy_all
    self.all.clear
  end
  def save
    @@all << self
    self
  end
  def self.create(name)
    song = self.new(name).save
    song
  end
  def add_song(song)
    unless song.artist
      song.artist = self
    end
    unless @songs.include?(song)
      @songs << song
    end
  end
  def genres
    songs.map {|song| song.genre}.uniq
  end
end
