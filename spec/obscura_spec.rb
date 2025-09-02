# frozen_string_literal: true

RSpec.describe Obscura do
  before(:all) do
    # Delete old data and enter new data
    User.destroy_all
    User.create(name: "User 15", email: "email15@test.com", phone_number: "+6211111115")
    
    @user = User.first
  end

  it "has a version number" do
    expect(Obscura::VERSION).not_to be nil
  end

  it "show column values ​​without masking" do
    expect(@user.email).to eq "email15@test.com"
    expect(@user.phone_number).to eq "+6211111115"
  end

  it "disguise column values ​​with full masking" do
    expect(@user.masked_email).to eq "****************"
    expect(@user.masked_phone_number).to eq "***********"
  end

  it "disguise column values ​​with half full masking" do
    expect(@user.half_masked_email).to eq "email15@********"
    expect(@user.half_masked_phone_number).to eq "+6211******"
  end
end
