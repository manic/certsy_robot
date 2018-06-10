# Report

## How to use:

```
$ ./bin/certsy_robot {file_name}
```

## How to run unit tests

```
$ bundle
$ rspec spec/
```

## Test Fixtures

There are some test fixtures in `spec/fixtures`

```
$ ./bin/certsy_robot spec/fixtures/input1
$ ./bin/certsy_robot spec/fixtures/input2
$ ./bin/certsy_robot spec/fixtures/input3
```

## Some notes

- Tests are written in `rspec-given` style for better understanding.
- Rubocop is used for better ruby/rails style.
- In my opinion, it is better to avoid `DRY` style in tesing, because when we
  read the tests, we want to understand the code purpose quickly.
