module Api
  class UrlsController < ApplicationController
    def index
      @urls = Url.all
    end

    def show
      @url = Url.find Base62.decode(params[:id])
    end

    def create
      @url = Url.create(url: params[:url])
    rescue ActiveRecord::RecordNotUnique
      @url = Url.find_by(url: params[:url])
    end
  end
end
