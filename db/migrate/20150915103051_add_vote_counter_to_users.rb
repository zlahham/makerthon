class AddVoteCounterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :vote_total, :integer, default: 0
  end
end
