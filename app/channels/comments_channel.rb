class CommentsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "comment_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
