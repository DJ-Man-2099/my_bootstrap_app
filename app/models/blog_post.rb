class BlogPost < ApplicationRecord
  validates :title, presence: true
  # validates :body, presence: true, length: { minimum: 10 }
  has_rich_text :content
  validate :content_validation

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
        content: "This is a blog post about Rails.",
      },
      {
        title: "Hello again, Rails!",
        content: "This is a second blog post about Rails.",
      },
    ].each do |attributes|
      self.new(attributes).save
    end
  end

  private

  def content_validation
    if content.body.blank?
      errors.add(:content, "Content cannot be blank")
    elsif content.body.to_plain_text.strip.length < 10
      errors.add(:content, "Content must be a min of 10 chars")
    end
  end
end
