require 'tty-prompt'

class App
  def run(argv = [])
    result = "#{name} likes #{language}"
    confirm if argv.include? '--confirm'
    puts "==> #{result}" if argv.include? '--print'
    result
  end

  # We need this public, so we can stub it with `expect(subject.prompt).to...`
  def prompt
    @prompt ||= TTY::Prompt.new
  end

private

  def confirm
    prompt.yes? "Are You Sure?"
  end

  def name
    prompt.ask "Name:"
  end

  def language
    prompt.select "Favorite Language:", %w[Python Ruby Javascript]
  end
end

