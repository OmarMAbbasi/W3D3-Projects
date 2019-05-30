class ShortenedUrl < ApplicationRecord

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true

  def self.random_code(user_id, long_url)

    belongs_to :submitter,
      primary_key: :id,
      foreign_key: :user_id,
      class_name: :User


    short = "https://μrl.com/#{SecureRandom::urlsafe_base64(8, true)}"
    url = ShortenedUrl.new({short_url: short, long_url: long_url, user_id: user_id})
    until url.save
      short =  "https://μrl.com/ #{SecureRandom::urlsafe_base64(8, true)}"
      url = ShortenedUrl.new({short_url: short, long_url: long_url, user_id: user_id})
    end
    url
  end
end
