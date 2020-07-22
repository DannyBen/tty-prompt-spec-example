require 'tty-prompt'
require 'tty/prompt/test'

class TTY::Prompt::Test
  def input=(keys)
    keys.each { |key| input << key }
    input.rewind
  end
end

RSpec.describe "console app" do
  let(:prompt) { TTY::Prompt::Test.new }

  subject do
    name = prompt.ask("Name?")
    if prompt.yes?("Greetings?")
      prompt.say "Hello, #{name}!"
    end
  end

  specify do
    prompt.input = ["Danny", "\n", "Y", "\n"]
    subject
    expect(prompt.output.string).to end_with("Hello, Danny!\n")
  end
end
