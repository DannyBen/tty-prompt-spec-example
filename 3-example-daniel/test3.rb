require 'tty-prompt'
require 'tty/prompt/test'
require 'rspec_approvals'

# Patch

class TTY::Prompt::Test
  def input=(keys)
    keys.each { |key| input << key }
    input.rewind
  end
end

# Subject

class Subject
  def run
    name = prompt.ask "Name?"
    prompt.say "Hello, #{name}!" if prompt.yes? "Greetings?"
  end

  def prompt
    @prompt ||= TTY::Prompt.new
  end
end

# Specs

describe Subject do
  let(:prompt) { TTY::Prompt::Test.new }
  before { allow(subject).to receive(:prompt).and_return prompt }

  describe '#run' do
    it "works" do
      prompt.input = ["Danny", "\n", "Y", "\n"]
      subject.run
      expect(prompt.output.string).to match_approval('run')
    end
  end
end
