class Post < ApplicationRecord
  validates :title, presence: true, length: {minimum:3, maximum:50}

  def format_date
    self.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
  
end
