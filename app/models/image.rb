class Image < ApplicationRecord
    has_one_attached :file
    has_secure_token :control_hash

    def to_param
        control_hash
    end
end
