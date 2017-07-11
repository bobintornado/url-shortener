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
        sql = "WITH time_table AS (
                SELECT start_time, lead(start_time) OVER (ORDER BY start_time) AS end_time
                FROM generate_series('#{params[:from]}'::timestamp,
                                     '#{params[:to]}'::timestamp,
                                     interval '#{interval}') AS start_time
                )
              SELECT start_time, count(unique_visits.visitor_uuid) AS unique_visits_count
              FROM time_table
                LEFT JOIN (select * from unique_visits where url_id = #{url.id}) as unique_visits
                ON unique_visits.created_at >= time_table.start_time
                  AND unique_visits.created_at <=  time_table.end_time
              GROUP  BY start_time
              ORDER  BY start_time"
        @interval_results = ActiveRecord::Base.connection.exec_query(sql)
      else
        render json: { error: 'url record not found' }, status: :not_found
      end
    end
  end
end
