class LargeCoverUploader <CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :aws
  process :resize_to_fill => [665,375]
end 