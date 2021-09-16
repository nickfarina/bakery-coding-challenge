class CookCookiesJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later

    puts 'in cookiejob'
    cookies = args.first
    puts cookies

    sleep [2, 3, 4].sample.minutes

    cookies.each do |cookie|
      cookie.update_attributes!(ready: true)
    end
  end
end
