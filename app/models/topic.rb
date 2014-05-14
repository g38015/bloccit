class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  validates :name, presence: true
end