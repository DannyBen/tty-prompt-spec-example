require 'spec_helper'

# Tag the spec with :tty or type: :tty in order to include the spec helpers
describe App, :tty do

  # Ensure subject responds to #prompt properly and ensure 100% test coverage
  # since prompt will be stubbed from this point onward
  describe '#prompt' do
    it "is a TTY::Prompt" do
      expect(subject.prompt).to be_a TTY::Prompt    
    end
  end

  describe '#run' do
    context "without arguments" do
      it "asks for a name and favorite language" do
        ask "Matz"      # answer prompt.ask with 'Matz'
        select "Ruby"   # answer prompt.select with 'Ruby'

        expect(subject.run).to eq "Matz likes Ruby"
      end
    end

    context "with --confirm" do
      it "also asks if I am sure" do
        ask "Matz"
        select "Ruby"
        yes? true

        expect(subject.run %w[--confirm]).to eq "Matz likes Ruby"
      end
    end

    context "with --print" do
      it "prints the output" do
        ask "Matz"
        select "Ruby"

        expect { subject.run %w[--print] }
          .to output("==> Matz likes Ruby\n").to_stdout
      end
    end
  end

  # Demonstrate the use of alternative syntax - longer but perhaps clearer
  context "alternate (verbose) spec syntax" do
    describe '#run' do
      it "works" do
        answer :ask, with: "Piotr"    # instead of:  ask "Piotr"
        answer :select, with: "Ruby"  # instead of:  select "Ruby"
        answer :yes?, with: false     # instead of:  yes false

        expect(subject.run %w[--confirm]).to eq "Piotr likes Ruby"
      end
    end

  end
end
