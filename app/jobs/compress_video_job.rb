class CompressVideoJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    return unless post.video.attached?

    retries = 3

    begin
      # Download video
      io = post.video.download

      # Prepare input file
      input_file = Tempfile.new([ "original_video", File.extname(post.video.filename.to_s) ], binmode: true)
      input_file.write(io)
      input_file.flush
      input_file.rewind

      # Prepare output file
      output_file = Tempfile.new([ "compressed_video", ".mp4" ], binmode: true)

      # Compress video
      movie = FFMPEG::Movie.new(input_file.path)
      options = { resolution: "640x480", video_bitrate: 500, audio_bitrate: 64 }
      movie.transcode(output_file.path, options)

      # Attach compressed video
      post.video.attach(
        io: File.open(output_file.path),
        filename: post.video.filename.to_s,
        content_type: post.video.content_type
      )

      Rails.logger.info("FFMPEG processed successfully")

    rescue FFMPEG::Error, StandardError => e
      Rails.logger.error("FFMPEG processing failed: #{e.message}")
      if (retries -= 1) > 0
        sleep 1
        retry
      else
        Rails.logger.error("All attempts failed")
        raise
      end
    ensure
      # Clean up temporary files
      input_file.close!
      output_file.close!
    end
  end
end
