require 'tty-prompt'

class App
  def prompt
    @prompt ||= TTY::Prompt.new
  end

  def run
    "#{name} #{destiny}"
  end

  def name
    prompt.ask "Name:"
  end

  def destiny
    prompt.select("Destiny:", %w(Scorpion Kano Jax))
  end
end

