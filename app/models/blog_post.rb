class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  def self.seeds
    [
      {
        title: "Hello, Rails!",
        body: "This is a blog post about Rails.",
      },
      {
        title: "Hello again, Rails!",
        body: "This is a second blog post about Rails.",
      },
    ].each do |attributes|
      self.new(attributes).save
    end
  end
end
