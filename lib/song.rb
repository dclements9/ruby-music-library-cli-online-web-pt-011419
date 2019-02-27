require 'pry'

class Song
    attr_accessor :name, :artist, :genre
    @@all = []

  extend Concerns::Findable

  def initialize(name, artist=nil, genre=nil)
    @name = name
    if artist
      #@artist = artist
      self.artist=(artist)
    end
    if genre
      self.genre=(genre)
    end
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
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  def genre=(genre)
    @genre = genre
    genre.add_song(self)
  end
  def self.find_by_name(name)
    all.detect{|song| song.name == name}
  end
  def self.find_or_create_by_name(name)
    find_by_name(name) || create(name)
  end
  def create(name)
    self.new(name).save
    song
  end
  def self.new_from_filename(file_name)
    song = self.new(file_name.split(" - ")[1])
    artist_name = file_name.split(" - ")[0]
    genre_name = file_name.split(" - ")[2].gsub(".mp3", "")
    #binding.pry
    genre = Genre.find_or_create_by_name(genre_name)
    artist = Artist.find_or_create_by_name(artist_name)
    song.artist = artist
    song.genre = genre
    song
  end
  def self.create_from_filename(file_name)
    new_from_filename(file_name).tap{|song| song.save}
  end
end
