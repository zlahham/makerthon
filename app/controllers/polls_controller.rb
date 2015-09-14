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
    p '---------------------------------'
    p params
    p '---------------------------------'
    @poll = Poll.find(params[:id])
    p '---------------------------------'
    p @poll
    p '---------------------------------'
    @poll.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @poll = Poll.find(params[:id])
    @poll.downvote_by current_user
    redirect_to :back
  end

  private

  def poll_params
    params.require(:poll).permit(:name)
  end

end
