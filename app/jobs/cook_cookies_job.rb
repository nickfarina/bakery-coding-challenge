class CookCookiesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    cookies = args.first
    oven = args.last

    sleep [2, 3, 4].sample.seconds

    cookies.each do |cookie|
      cookie.update_attributes!(ready: true)
    end

    ActionCable.server.broadcast 'ovens', message: 'COOKIES_READY', oven_id: oven.id
  end
end
