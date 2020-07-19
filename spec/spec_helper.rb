require './app'
require "tty/prompt/test"

RSpec.shared_context "TTY Prompt" do
  let(:prompt) { TTY::Prompt::Test.new }
  
  before do
    prompt.on :keypress do |e|
      prompt.trigger :keyup   if e.value == "k"
      prompt.trigger :keydown if e.value == "j"
    end
    
    allow(subject).to receive(:prompt).and_return prompt
  end
end

RSpec.configure do |rspec|
  rspec.include_context "TTY Prompt", cli: true
end
