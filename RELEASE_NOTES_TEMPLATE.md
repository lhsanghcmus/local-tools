# Release Notes Template

Use this template when creating new releases for the local-tools project.

## [Version] - YYYY-MM-DD

### 🚀 New Features
- **Feature Name**: Brief description
  - Detailed explanation of what was added
  - Any configuration changes required
  - Port mappings or endpoint changes

### 🔧 Improvements
- **Improvement Name**: What was enhanced
  - Performance improvements
  - Better error handling
  - UI/UX enhancements

### 🐛 Bug Fixes
- **Issue**: What was fixed
  - Description of the problem
  - How it was resolved

### 🔄 Changes
- **Breaking Changes**: Any backwards-incompatible changes
  - Migration steps if required
  - Configuration updates needed

### 📦 Dependencies
- **Updated Dependencies**:
  - Service: old_version → new_version
  - Reason for update

### 🛡️ Security
- **Security Improvements**:
  - Security patches applied
  - New security features

### 📚 Documentation
- Updated README.md sections
- New examples or tutorials
- API documentation changes

### 🧪 Testing
- New test coverage
- Testing improvements

---

## Release Checklist

Before creating a release:

- [ ] Update version numbers in relevant files
- [ ] Update CHANGELOG.md with new changes
- [ ] Test all services start correctly
- [ ] Verify all web UIs are accessible
- [ ] Test connection examples in README
- [ ] Update documentation if needed
- [ ] Create git tag
- [ ] Push tag to repository

## Version Numbering

Follow semantic versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Breaking changes, major infrastructure changes
- **MINOR**: New features, new services, backwards-compatible changes
- **PATCH**: Bug fixes, small improvements, dependency updates

## Git Tag Commands

```bash
# Create annotated tag
git tag -a v1.0.1 -m "Release version 1.0.1"

# Push tag to remote
git push origin v1.0.1

# List all tags
git tag -l

# Delete tag (if needed)
git tag -d v1.0.1
git push origin --delete v1.0.1
``` 