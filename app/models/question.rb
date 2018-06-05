class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true
  validates :text, :user, presence: true
  validates_length_of :text, :maximum => 255, :too_long => 'Текст не должен быть более 255 символов'
end