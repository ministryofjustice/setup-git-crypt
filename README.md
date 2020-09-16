# setup-kd

This actions sets up your GitHub Actions environment by building and installing [AGWA/git-crypt](https://github.com/AGWA/git-crypt) into a `bin` folder in the current workspace

# Usage

See [action.yml](action.yml)

Basic:
```yaml
steps:
  - uses: actions/checkout@v2
  - uses: ministryofjustice/setup-git-crypt@main
  - run: bin/git-crypt unlock
```