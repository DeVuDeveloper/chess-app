class SoundsController < ApplicationController
  before_action :set_sound, only: %i[ show edit update destroy ]

  def index
    @sounds = Sound.all
    @sound = Sound.new
  end

  def show
    @sound = Sound.find(params[:id])
  end

  def new
    @sound = Sound.new
  end

  def create
    @sound = Sound.new(sound_params)
    if @sound.save!
      respond_to do |format|
        format.html { redirect_to sound_path(@sound), notice: "Sound was successfully created." }
        format.turbo_stream
      end
    end
  end

  def destroy
    @sound.destroy
    respond_to do |format|
      format.html { redirect_to sounds_path, notice: "Sound was successfully destroyed." }
      format.turbo_stream
    end
  end

  def play
    if @sound
      midi_file_path = ActiveStorage::Blob.service.send(:path_for, @sound.file.key)
      wav_file_path = "#{Rails.root.join("public", "uploads", File.basename(midi_file_path, ".*"))}.wav"
      system("timidity #{midi_file_path} -Ow -o #{wav_file_path}")

      @wav_file_url = "/uploads/#{File.basename(wav_file_path)}"
      puts "MIDI file has been successfully converted to WAV."
    else
      puts "No MIDI file found for playback."
    end
  end

  private

  def set_sound
    @sound = Sound.find(params[:id])
  end

  def sound_params
    params.require(:sound).permit(:name, :file)
  end
end
