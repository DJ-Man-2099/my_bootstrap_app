class BlogPost < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  # This allows calling BlogPost.draft, BlogPost.published, BlogPost.scheduled
  scope :sorted, -> { order(arel_table[:published_at].desc.nulls_last).order(updated_at: :desc) }
  # Ex:- scope :active, -> {where(:active => true)}
  scope :draft, -> { where(published_at: nil).order(updated_at: :desc) }
  scope :published, -> { where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :scheduled, -> { where("published_at > ?", Time.current).order(published_at: :desc) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  # Ex:- scope :active, -> {where(:active => true)}

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
