require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions
  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates_format_of :email, :with => /[a-z\d_+.\-]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+/i, :message => 'Введите email'
  validates_format_of :username, :with =>  /[a-z\d_]+/i, :message =>'Неверный формат юзернейма. Только латинские буквы, цифры и знак'
  validates_length_of :username, :maximum => 40, :too_long => 'Имя должно быть не более 40 символов'

  attr_accessor :password
  validates_presence_of :password, on: :create
  validates_confirmation_of :password
  before_save :encrypt_password

  before_validation(on: :create) do
    self.username = username.downcase
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST)
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end
end