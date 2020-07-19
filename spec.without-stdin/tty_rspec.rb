module SpecMixin
  def ask(input)
    answer :ask, with: input
  end

  def yes?(input)
    answer :yes?, with: input
  end

  def select(input)
    answer :select, with: input
  end

  def answer(method, with:)
    expect(subject.prompt).to receive(method.to_sym).and_return(with)
  end
end

RSpec.configure do |rspec|
  # Include the helper when tagged with :tty or type: :tty
  rspec.include SpecMixin, tty: true
  rspec.include SpecMixin, type: :tty
end
