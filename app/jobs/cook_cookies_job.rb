class CookCookiesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    puts 'in cookiejob'

    cookies = args.first
    oven = args.last

    puts cookies

    sleep [1].sample.second

    cookies.each do |cookie|
      cookie.update_attributes!(ready: true)
    end

    puts 'cooked all cookies'
    ActionCable.server.broadcast 'ovens', message: 'COOKIES_READY', oven_id: oven.id
  end
end
