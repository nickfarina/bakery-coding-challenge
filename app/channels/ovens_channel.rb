class OvensChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'ovens'
  end
end
