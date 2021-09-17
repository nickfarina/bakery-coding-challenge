class OvensChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'ovens'

    puts 'subscribed oven???'
  end
end
