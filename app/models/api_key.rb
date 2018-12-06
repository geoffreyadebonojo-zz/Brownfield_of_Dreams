class ApiKey < ApplicationRecord
  
  validates_presence_of :key

  belongs_to :user

end