# Implementation Details

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
