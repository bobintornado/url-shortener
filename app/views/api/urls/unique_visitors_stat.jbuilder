# frozen_string_literal: true

json.data @interval_results.rows
json.meta do
  json.columns @interval_results.columns
end
