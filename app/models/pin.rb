class Pin < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_attached_file :image, styles: {medium: '300x300>', large: '600x600>'}


  validates :title, :description, presence: true, length: {minimum: 5}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :image, on: :create
end
