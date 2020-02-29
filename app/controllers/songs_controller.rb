class SongsController < ApplicationController
  before_action :find_song, only: [:show, :edit, :update, :destroy]

  def index
    @songs = Song.all
  end

  def show
  end

  def new
    @song = Song.new

    3.times do
      @song.notes.build
    end
  end

  def create
    artist = Artist.find_or_create_by(name: song_params[:artist_name])
    @song = artist.songs.build(song_params)

    if @song.save
      redirect_to songs_path
    else
      render :new
    end
  end

  def edit
  end

  def update

    if @song.update(song_params)
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song.destroy
    redirect_to songs_path
  end

  private

  def find_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:title, :artist_name, :genre_id, notes_attributes: [:content])
  end
end

