# frozen_string_literal: true

class AppController < ApplicationController
  include ::ActionController::Cookies

  RECORDED_ATTRIBUTES = %w[HTTP_VERSION HTTP_USER_AGENT HTTP_ACCEPT_LANGUAGE REMOTE_ADDR SERVER_NAME].freeze

  def redirect
    id = Base62.decode(params[:short_url])
    @url = Url.find(id)

    record_visit
    record_unique_visitor
    redirect_to @url.url
  end

  def record_visit
    http_info = request.env.slice(*RECORDED_ATTRIBUTES)
    args = http_info.merge(url: @url)

    Visit.create(args)
  end

  def record_unique_visitor
    visitor_uuid = cookies.signed[:visitor_uuid]
    if visitor_uuid
      UniqueVisit.where(visitor_uuid: visitor_uuid, url: @url).first_or_create
    else # new `visitor`
      unique_visit = UniqueVisit.create(url: @url).reload
      cookies.permanent.signed[:visitor_uuid] = unique_visit.visitor_uuid
    end
  end
end
