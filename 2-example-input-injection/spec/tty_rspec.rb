class StringIO
  # Not sure if wait_readable is needed
  # def wait_readable(*)
  #   true
  # end

  # ioctl is needed
  def ioctl(*)
    80
  end
end

RSpec.shared_context "TTY Prompt" do
  SPECIAL_KEYS = {
    down: 'J',
    up: 'K',
    right: 'H',
    left: 'L',
    enter: "\n",
  }
  
  let(:tty_prompt) { TTY::Prompt::Test.new }
  
  before do
    tty_prompt.on :keypress do |e|
      SPECIAL_KEYS.each do |trigger, key|
        tty_prompt.trigger "key#{trigger}".to_sym if e.value == key
      end
    end

    allow(subject).to receive(:prompt).and_return tty_prompt
  end

  def tty_input(*keys)
    keys = keys.map { |key| key.is_a?(Symbol) ? SPECIAL_KEYS[key] : key } 
    keys.each { |key| tty_prompt.input << key }
    tty_prompt.input.rewind
  end

  def tty_output
    tty_prompt.output.string
  end
end

RSpec.configure do |rspec|
  # Include the helper in specs tagged as ':tty' or 'type: :tty'
  rspec.include_context "TTY Prompt", tty: true
  rspec.include_context "TTY Prompt", type: :tty
end
