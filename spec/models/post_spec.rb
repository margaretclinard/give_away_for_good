require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of :category }
  it { should validate_presence_of :description}
  it { should validate_presence_of :date_posted }
  it { should validate_presence_of :deadline }
end