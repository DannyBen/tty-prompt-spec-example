require 'spec_helper'

describe App, :cli do
  it "works" do
    prompt.input << "Danny" << "\n" << "j" << "\n"
    prompt.input.rewind
    expect(subject.run).to eq "Danny Kano"
  end

  it "works for sure" do
    prompt.input << "Danny" << "\n" << "j" << "j" << "\n"
    prompt.input.rewind
    expect(subject.run).to eq "Danny Jax"
  end
end
