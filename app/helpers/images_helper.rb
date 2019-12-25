module ImagesHelper
  class ImageDeletingService
    def self.delete_old_pics
      Image.where('created_at <= ?', Time.now - 15.minutes).destroy_all
    end
  end
end
