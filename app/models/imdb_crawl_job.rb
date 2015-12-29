class ImdbCrawlJob
  include ActiveModel::Model

  attr_accessor :imdb_id

  validates_presence_of :imdb_id

  def create
    if self.valid?
      MediamasterMovieCreationJob.perform_later(self.imdb_id, User.first.id)

      return true
    end

    return false
  end

end
