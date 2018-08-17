class Blog < ApplicationRecord
  before_save :urlify_slug

  if Rails.env.production?
    include PgSearch
    pg_search_scope :search_by_slug_and_body, :against => [:slug, :body]
  end

  def urlify_slug
    self.slug = self.slug.parameterize
  end

  def self.deparametrize(str)
    str.split("-").join(" ").humanize
  end

end
