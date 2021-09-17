class CookCookiesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    cookies = args.first

    sleep [2, 3, 4].sample.minutes

    cookies.each do |cookie|
      cookie.update_attributes!(ready: true)
    end
  end
end
