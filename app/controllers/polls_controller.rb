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

  def poll_params
    params.require(:poll).permit(:name)
  end

end
