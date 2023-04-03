# go-verify

go-verify verifies a Go codebase. We can use this Github Action to ensure
a consistent go codebase.

The verifications includes
- gofmt
- goimports
- go mod tidy

## Usage

See [action.yml](https://github.com/gjkim42/go-verify/blob/main/action.yml)

```yaml
steps:
- uses: actions/checkout@v3
- uses: actions/setup-go@v4
- uses: gjkim42/go-verify@v1
```

### `.goverifyignore`

Specifies intentionally untracked files that go-verify should ignore. Each line
in a `.goverifyignore` file specifies a pattern.

### If the codebase does not use the go module
```yaml
steps:
- uses: actions/checkout@v3
- uses: actions/setup-go@v4
- uses: gjkim42/go-verify@v1
  with:
    go_mod: false
```
