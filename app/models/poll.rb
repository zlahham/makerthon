class Poll < ActiveRecord::Base
  belongs_to :user
  has_many :votes, dependent: :destroy

  def create_with_user(attributes = {}, user)
    attributes[:user] ||= user
    create!(attributes)
  end

  def create_vote params, user
    @poll = self.votes.create(value: params[:value], user_id: user.id)
  end

end
