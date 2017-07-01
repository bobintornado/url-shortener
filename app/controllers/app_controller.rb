class AppController < ApplicationController
  RECORDED_ATTRIBUTES = %w[HTTP_VERSION HTTP_USER_AGENT HTTP_ACCEPT_LANGUAGE REMOTE_ADDR SERVER_NAME].freeze

  def redirect
    id = Base62.decode(params[:short_url])
    @url = Url.find(id)

    record_visit
    redirect_to @url.url
  end

  def record_visit
    http_info = request.env.slice(*RECORDED_ATTRIBUTES)
    args = http_info.merge(url: @url)

    Visit.create(args)
  end
end
