class ImdbCrawlJobsController < ApplicationController

  def new
    title << 'New Crawl Job'
    @imdb_crawl_job = ImdbCrawlJob.new
  end

  def create
    @imdb_crawl_job = ImdbCrawlJob.new(imdb_crawl_job_params)

    if @imdb_crawl_job.create
      redirect_to new_imdb_crawl_job_path
    else
      title << 'New Crawl Job'
      render action: 'new'
    end
  end

  private

  def imdb_crawl_job_params
    params.require(:imdb_crawl_job).permit(:imdb_id)
  end

end
