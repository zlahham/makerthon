require 'pusher'
class PollsController < ApplicationController

  def index
    @polls = Poll.all
    @user_vote = vote_total(current_user) if current_user
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
    @myvote = Vote.where(user_id: current_user.id)[0]
    if !@myvote || @myvote.value <= 0
      @vote = Vote.where(poll_id: @poll.id).where(user_id: current_user.id).find_or_create_by(user_id: current_user.id, poll_id: @poll.id)
      @vote.update(value: @vote.value + 1)
      pusher_send(@poll)
    end
    redirect_to :back
  end

  def downvote
    @poll = Poll.find(params[:id])
    @myvote = Vote.where(user_id: current_user.id)[0]
    if !@myvote || @myvote.value >= 0
      @vote = Vote.where(poll_id: @poll.id).where(user_id: current_user.id).find_or_create_by(user_id: current_user.id, poll_id: @poll.id)
      @vote.update(value: @vote.value - 1)
      pusher_send(@poll)
    end
    redirect_to :back
  end

  def pusher_send poll
    @signed_in_users = User.where(updated_at: Time.now-300..Time.now).count
    @users_upvoting = Vote.where(poll_id: poll.id).where(value: 1).where(updated_at: Time.now-300..Time.now).count
    @users_downvoting = Vote.where(poll_id: poll.id).where(value: -1).where(updated_at: Time.now-300..Time.now).count
    pusher = Pusher::Client.new app_id: Pusher.app_id, key: Pusher.key, secret: Pusher.secret
    pusher.trigger('voting', 'my_event', {
      upvote: @users_upvoting,
      downvote: @users_downvoting,
      neutral: @signed_in_users - (@users_downvoting + @users_upvoting)
    })
  end

  def show
    @poll = Poll.find(params[:id])
  end

  def destroy
    @poll = Poll.find(params[:id])
    @poll.destroy
    redirect_to polls_path
  end

  private

  def poll_params
    params.require(:poll).permit(:name)
  end

  def vote_total user
    Vote.where(user_id: user.id).sum(:value)
  end


end
