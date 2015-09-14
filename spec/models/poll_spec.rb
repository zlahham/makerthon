require 'spec_helper'

describe Poll, type: :model do
  it{ is_expected.to belong_to :user}
end
