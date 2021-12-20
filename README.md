# go-license-check-action

Usage example 
```yaml
license-check:
    runs-on: ubuntu-latest
    name: License Check
    steps:
      - uses: actions/checkout@v2
      - uses: yaronius/go-license-check-action@main
        with:
          ignored_authors: 'yaronius'
          allowed_licenses: 'MIT,Apache-2.0,BSD-2-Clause,BSD-3-Clause'
```