# TTY::Prompt Testing Method

This repository demonstrates several approaches for a testing `TTY::Prompt` CLI
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

