class Url < ApplicationRecord
  belongs_to :user
  has_many :clicks, dependent: :destroy

  validates :original_url, presence: true, uniqueness: true,  format: URI.regexp(%w[http https])
  validates :name, presence: true

  before_create :generate_short_url

  def generate_short_url
    self.short_url = SecureRandom.alphanumeric(6) if short_url.blank?
  end

  def clicks_grouped_by_day(range)
    start_date = range.begin.beginning_of_day
    end_date = range.end.end_of_day

    clicks
      .where(created_at: start_date..end_date)
      .group(Arel.sql("DATE(created_at)"))
      .order(Arel.sql("DATE(created_at)"))
      .count
  end
end
