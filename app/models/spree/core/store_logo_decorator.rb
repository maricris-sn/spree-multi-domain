module Spree
  class StoreLogo < Asset
    validate :no_attachment_errors

    has_attached_file :attachment,
                      styles: { mini: '48x48>', small: '100x100>', large: '600x600>' },
                      convert_options: { all: '-strip -auto-orient -colorspace sRGB' },
                      s3_credentials: {
                        access_key_id:     ENV['S3_ACCESS_KEY'],
                        secret_access_key: ENV['S3_SECRET_KEY'],
                        bucket:            ENV['S3_BUCKET']
                      },
                      storage:        :s3,
                      s3_headers:     { "Cache-Control" => "max-age=31557600" },
                      s3_protocol:    "https",
                      bucket:         ENV['S3_BUCKET'],
                      url:            ":s3_domain_url",
                      path:           "/:class/:id/:style/:basename.:extension",
                      default_url:    "/:class/:id/:style/:basename.:extension"

    validates_attachment :attachment,
      :presence => true,
      :content_type => { :content_type => %w(image/jpeg image/jpg image/png image/gif) }

    # save the w,h of the original image (from which others can be calculated)
    # we need to look at the write-queue for images which have not been saved yet
    before_save :find_dimensions, if: :attachment_updated_at_changed?

    def find_dimensions
      temporary = attachment.queued_for_write[:original]
      filename = temporary.path unless temporary.nil?
      filename = attachment.path if filename.blank?
      geometry = Paperclip::Geometry.from_file(filename)
      self.attachment_width  = geometry.width
      self.attachment_height = geometry.height
    end

    # if there are errors from the plugin, then add a more meaningful message
    def no_attachment_errors
      unless attachment.errors.empty?
        # uncomment this to get rid of the less-than-useful interim messages
        # errors.clear
        errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
        false
      end
    end
  end
end
