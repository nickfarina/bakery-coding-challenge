class CookCookiesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    cookies = args.first
    oven = args.last

    sleep [1].sample.second

    cookies.each do |cookie|
      cookie.update_attributes!(ready: true)
    end

    puts 'cooked all cookies'
    ActionCable.server.broadcast 'ovens', message: 'COOKIES_READY', oven_id: oven.id
  end
end
