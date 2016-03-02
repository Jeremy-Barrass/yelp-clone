require 'rails_helper'

describe Review, type: :model do
  it {should belong_to(:restaurant).dependent(:destroy)}
end
