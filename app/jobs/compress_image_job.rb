class CompressImageJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    return unless post.image.attached?

    retries = 3

    begin
      io = post.image.download

      image = MiniMagick::Image.read(io)
      image.format("jpeg")
      image.resize "720x720"
      image.quality(50)

      processed_io = StringIO.new(image.to_blob)

      # post.image.purge

      post.image.attach(io: processed_io, filename: post.image.filename.to_s, content_type: post.image.content_type)

      Rails.logger.info("MiniMagick processed successfully")

    rescue MiniMagick::Error => e
      Rails.logger.error("MiniMagick processing failed: #{e.message}")
      if (retries -= 1) > 0
        sleep 1
        retry
      else
        Rails.logger.error("All attempts failed")
        raise
      end
    end
  end
end
