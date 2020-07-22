require 'spec_helper'

describe App, :tty do
  context "without arguments" do
    it "asks for a name and favorite language" do
      tty_input "Matz", :enter, :down, :enter
      expect(subject.run).to eq "Matz likes Ruby"
    end
  end

  context "with --confirm" do
    it "also asks if I am sure" do
      tty_input "Matz", :enter, :down, :enter, 'y'
      expect(subject.run %w[--confirm]).to eq "Matz likes Ruby"
    end
  end

  context "with --print" do
    it "prints the output" do
      tty_input "Matz", :enter, :down, :enter
      expect { subject.run %w[--print] }
        .to output("==> Matz likes Ruby\n").to_stdout
    end
  end
end
