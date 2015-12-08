namespace :movie do
  desc "動画ファイルを音声データに変換"
  task :get_voice, ["file_name"] => :environment do |task, args|
    file_path = Settings.movie_voice.file_path + args.file_name
    save_path = Settings.movie_voice.save_path + "test.wav"
    movie = FFMPEG::Movie.new(file_path)

    options = {audio_sample_rate: 16000, audio_channels: 1, audio_bitrate: 16}
    movie.transcode(save_path, options)    
  end
end