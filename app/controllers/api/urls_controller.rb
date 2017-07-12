# frozen_string_literal: true

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

    def unique_visitors_stat
      url = Url.find_by(url: params[:url])
      interval = params[:interval] || '1 hour'

      # the idea of this query
      # use generate_series to generate a series of time slots (start_time and end_time pair) based on interval
      # use time_table to left join unique_visits based on time slot
      if url
        @interval_results = UniqueVisit.stat_by_interval(url, params[:from], params[:to], interval)
      else
        render json: { error: 'url record not found' }, status: :not_found
      end
    end
  end
end
