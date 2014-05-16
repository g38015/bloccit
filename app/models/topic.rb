class Topic < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  has_many :posts, dependent: :destroy
  validates :name, presence: true

  scope :visible_to, ->(user) { user ? all : where(public: true)}
end