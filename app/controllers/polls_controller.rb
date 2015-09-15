require 'pusher'
class PollsController < ApplicationController

  def index
    @polls = Poll.all
  end

  def new
    @poll = Poll.new
  end

  def create
    @user = current_user
    @poll = @user.polls.create(poll_params)
    redirect_to '/'
  end

  def upvote
    @poll = Poll.find(params[:id])
    @poll.upvote_by current_user
    current_user.update(vote_total: current_user.vote_total + 1)
    pusher_send
    redirect_to :back
  end

  def downvote
    @poll = Poll.find(params[:id])
    @poll.downvote_by current_user
    current_user.update(vote_total: current_user.vote_total - 1)
    pusher_send
    redirect_to :back
  end

  def pusher_send
    @signed_in_users = User.where(updated_at: Time.now-300..Time.now)
    @users_upvoting = User.where(vote_total: 1).where(updated_at: Time.now-300..Time.now).sum(:vote_total)
    @users_downvoting = User.where(vote_total: -1).where(updated_at: Time.now-300..Time.now).sum(:vote_total)
    pusher = Pusher::Client.new app_id: Pusher.app_id, key: Pusher.key, secret: Pusher.secret
    pusher.trigger('voting', 'my_event', {
      upvote: @users_upvoting,
      downvote: @users_downvoting,
      total_voters: @signed_in_users
    })
  end

  def show
    @poll = Poll.find(params[:id])
  end


  private

  def poll_params
    params.require(:poll).permit(:name)
  end

end
