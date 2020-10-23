## Contributing

Before adding any contribution, we highly recommend reading this
quick guide to ensure your PR can be reviewed and approved as quickly as possible.

### Required Checks

Before pushing your code and opening a PR, we recommend you run the following checks to avoid
our GitHub Actions Workflow to block your contribution.

```bash
# Run unit tests and check code coverage
$ bundle exec rspec

# Run Rubocop and check code style
$ bundle exec rubocop
```

### New Features

Avoid new features in this gem. It's done.

It was extracted from [faraday_middleware](https://github.com/lostisland/faraday_middleware).