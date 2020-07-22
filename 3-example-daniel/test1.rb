require 'tty-prompt'

module TTY
  module StringIOExtensions
    def wait_readable(*)
      true
    end

    def ioctl(*)
      80
    end
  end

  def Prompt.test_mode!
    mod = Module.new do
      def initialize(**options)
        input  = StringIO.new
        input.extend(StringIOExtensions)
        output = StringIO.new

        super(**options.merge(input: input, output: output))
      end

      def input=(string)
        input << string
        input.rewind
      end

      def output
        @output.string
      end
    end

    prepend mod
  end
end

# in spec_helper.rb
TTY::Prompt.test_mode!

RSpec.describe "console app" do
  let(:prompt) { TTY::Prompt.new } # No TTY::Prompt::Test

  subject do
    name = prompt.ask("Name?")
    if prompt.yes?("Greetings?")
      prompt.say "Hello, #{name}!"
    end
  end

  specify do
    prompt.input = "Danny\nY\n"
    subject
    expect(prompt.output).to end_with("Hello, Danny!\n")
  end
end
