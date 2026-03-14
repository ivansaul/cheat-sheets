---
title: Guidelines
icon: lucide/users
---

# Contributing

Contributions are essential to keeping Cheat Sheets a comprehensive and accurate reference tool. Whether fixing a typo or building a new feature, follow this workflow to ensure your changes integrate smoothly into the project.

## Workflow

1. Discuss your proposed changes in the [Issue Tracker] before writing code.
2. Fork the repository and create a descriptive branch (e.g., `feature/awesome-feature`).
3. Implement your changes locally.
4. Push to your fork and submit a Pull Request.

  [Issue Tracker]: https://github.com/ivansaul/cheat-sheets/issues

## Code Standards

Before submitting a Pull Request, verify your changes adhere to the project's core guidelines:

- **Format your code.** Always run `dart format .` before committing.
- **Isolate logic.** Cheat Sheets employs a clean, layered architecture. Keep UI separated from business logic.
- **Localize.** Hardcoded text is discouraged. Use the [i18n translation system][Translations] for all visible labels.

  [Translations]: ./translations.md

## Git Commit Style

We strictly follow the [Conventional Commits] specification. This enables automated and transparent changelog generation.

### Commit Format

A standard commit message should look like this:

`<type>[optional scope]: <description>`

### Commit Types

When committing, prefix your message with one of the following types:

| Type       | Purpose                                                    |
| :--------- | :--------------------------------------------------------- |
| `feat`     | A new feature                                              |
| `fix`      | A bug fix                                                  |
| `docs`     | Documentation only changes                                 |
| `refactor` | A code change that neither fixes a bug nor adds a feature  |
| `chore`    | Routine tasks, dependency updates, etc.                    |

=== "Example 1"

    ```bash
    git commit -m "feat(i18n): add french localization"
    ```

=== "Example 2"

    ```bash
    git commit -m "fix(coupons): resolve sale price parsing error"
    ```

  [Conventional Commits]: https://www.conventionalcommits.org/
