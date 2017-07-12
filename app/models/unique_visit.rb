# frozen_string_literal: true

class UniqueVisit < ApplicationRecord
  belongs_to :url

  def self.stat_by_interval(url, from, to, interval)
    sql = "WITH time_table AS (
            SELECT start_time, lead(start_time) OVER (ORDER BY start_time) AS end_time
            FROM generate_series('#{from}'::timestamp,
                                 '#{to}'::timestamp,
                                 interval '#{interval}') AS start_time
            )
          SELECT start_time, count(unique_visits.visitor_uuid) AS unique_visits_count
          FROM time_table
            LEFT JOIN (select * from unique_visits where url_id = #{url.id}) as unique_visits
            ON unique_visits.created_at >= time_table.start_time
              AND unique_visits.created_at <=  time_table.end_time
          GROUP  BY start_time
          ORDER  BY start_time"

    ActiveRecord::Base.connection.exec_query(sql)
  end
end
