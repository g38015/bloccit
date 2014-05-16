class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  validates :name, presence: true

  scope :visible_to, ->(user) { user ? all : where(public: true)}
end