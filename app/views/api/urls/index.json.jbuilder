# frozen_string_literal: true

json.array! @urls do |url|
  json.partial! 'url', url: url
end
