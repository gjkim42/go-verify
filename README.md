# verify-go

verify-go verifies a Go codebase. We can use this Github Action to ensure
a consistent go codebase.

The verifications includes
- gofmt
- goimports
- go mod tidy

## Usage

See [action.yml](https://github.com/gjkim42/verify-go/blob/main/action.yml)

```yaml
steps:
- uses: actions/checkout@v3
- uses: actions/setup-go@v3
  with:
    go-version: '^1' # Caveat: You must specify go-version until
                     # https://github.com/actions/setup-go/issues/49 is resolved.
- uses: gjkim42/verify-go@v1
```

### `.verifygoignore`

Specifies intentionally untracked files that verify-go should ignore. Each line
in a `.verifygoignore` file specifies a pattern.

### If the codebase does not use the go module
```yaml
steps:
- uses: actions/checkout@v3
- uses: actions/setup-go@v3
  with:
    go-version: '^1'
- uses: gjkim42/verify-go@v1
  with:
    go_mod: false
```
