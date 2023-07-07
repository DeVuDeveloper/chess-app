class MidiController < ApplicationController
 before_action :set_midi_file, only: :play

  def create
    midi_file = params[:file]
    if midi_file
      File.open(Rails.root.join('uploads', midi_file.original_filename), 'wb') do |file|
        file.write(midi_file.read)
      end
      flash[:success] = 'MIDI fajl uspešno uploadovan!'
    else
      flash[:error] = 'Nije pronađen MIDI fajl.'
    end
    redirect_to midi_play_path
  end

  def play
    if request.post? && @midi_file
   
      # Konvertirajte MIDI datoteku u WAV koristeći Timidity++
      wav_file = "#{Rails.root.join('uploads', File.basename(@midi_file, '.*'))}.wav"
      system("timidity #{@midi_file} -Ow -o #{wav_file}")

      # Reproducirajte WAV datoteku
      system("aplay #{wav_file}")

      puts 'MIDI file has been successfully played!'
    else
      puts 'No MIDI file found for playback.'
    end
  end

  private

  def set_midi_file
    midi_files = Dir.glob(Rails.root.join('uploads', '*.midi'))
    @midi_file = midi_files.find { |file| File.extname(file) == '.midi' }
    puts "MIDI file path: #{@midi_file}"
  end
end















  