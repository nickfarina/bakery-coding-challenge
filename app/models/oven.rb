class Oven < ActiveRecord::Base
  belongs_to :user
  has_many :cookies, as: :storage, dependent: :destroy, class_name: 'Cookie'

  validates :user, presence: true

  def cookies_ready?
    cookies.all? { |cookie| cookie.ready? }
  end
end
