# TTY::Prompt Testing Method

This repository demonstrates a testing approach for `TTY::Prompt` CLI
applications.

It was done as part of the discussion in
[this issue](https://github.com/piotrmurach/tty-prompt/issues/139)

## Objectives

- Keep specs clean and declerative, in the spirit of rspec.
- Avoid testing TTY prompt itself - we only care about our app.
- Avoid fragile hacks or complicated supporting code.
- Tests should not get "silently stuck" waiting for input when invalid input
  is provided.
- Use common and familiar rspec notions (exectations, stubs).

## Notable files

- [spec/app_spec.rb](spec/app_spec.rb) - spec example.
- [spec/tty_rspec.rb](spec/tty_rspec.rb) - TTY spec helper, included in
  [spec_helper.rb](spec/spec_helper.rb).
- [app.rb](app.rb) - the sample app under test.

## Implementation Details

The subject under test (the CLI app) must provide a public `prompt` method
that returns an instance of `TTY::Prompt`. It can be called anything, but
it must be public so it can be stubbed.

Now, we can do things like:

```ruby
expect(subject.prompt).to receive(:select).and_return("Some menu option")
```

Note that this "short circuits" any call to STDIN and STDOUT, which is what
we want to achieve. Handling input and output streams is the responsibility of
`TTY::Prompt`.

Finally, we can wrap the above expectation in convenience methods. So, actual
specs can look like this:

```ruby
it "works" do
  ask "Matz"    # expect(subject.prompt).to receive(:ask).and_return "Matz"
  select "Ruby" # expect(subject.prompt).to receive(:select).and_return "Ruby"

  expect(subject.run).to eq "Matz likes Ruby"
end
```

Or, in a more verbose syntax:

```ruby
it "works" do
  answer :ask, with: "Piotr"    # instead of:  ask "Piotr"
  answer :select, with: "Ruby"  # instead of:  select "Ruby"

  expect(subject.run).to eq "Piotr likes Ruby"
end
```
