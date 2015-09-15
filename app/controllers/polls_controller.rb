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
    # current_user.vote_total = 12932
    # current_user.vote_total_will_change!
    # current_user.save
    redirect_to :back
  end

  def downvote
    @poll = Poll.find(params[:id])
    @poll.downvote_by current_user
    current_user.update(vote_total: current_user.vote_total - 1)
    redirect_to :back
  end

  private

  def poll_params
    params.require(:poll).permit(:name)
  end

end
