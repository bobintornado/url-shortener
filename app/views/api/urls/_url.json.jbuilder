# frozen_string_literal: true

json.short_url Base62.encode(url.id)
json.url url.url
json.visits url.visits
