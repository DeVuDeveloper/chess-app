class GamesChannel < ApplicationCable::Channel
  def subscribed
    stream_for "games"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
