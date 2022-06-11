# verify-go

verify-go verifies a Go codebase. We can use this Github Action to ensure
a consistent go codebase.

## Usage

See [action.yml](https://github.com/gjkim42/verify-go/blob/main/action.yml)

```yaml
steps:
- uses: actions/checkout@v3
- uses: actions/setup-go@v3
  with:
    go-version: '^1'
- uses: gjkim42/verify-go@v1
```

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
