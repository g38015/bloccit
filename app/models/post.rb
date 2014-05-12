class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :topic
  
  validates :title, presence: true

  default_scope {order('created_at DESC')}
end