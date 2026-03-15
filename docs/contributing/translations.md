---
title: Translations
icon: lucide/languages
---

# Translations

Cheat Sheets uses [`slang`][slang] to provide type-safe localization. Translation strings are managed internally via JSON files located in `lib/src/i18n/`.

  [slang]: https://pub.dev/packages/slang


!!! quote "Acknowledgments"

    Special thanks to **[Weblate](https://weblate.org/)** for providing a professional localization platform for this open-source project. 

    There's no need to open pull requests for each time you want to push forward an addition or change. You can do it through [Weblate portal](https://hosted.weblate.org/projects/cheatsheets/).

    <a href="https://hosted.weblate.org/engage/cheatsheets/">
      <img src="https://hosted.weblate.org/widget/cheatsheets/multi-auto.svg" alt="Translation status" />
    </a>  

## Add a New Language

Adding a new language consists of copying the base configuration, translating the strings, and registering the new support in the project structure.

### Translation File

Create a duplicate of the base `en.i18n.json` file inside the `lib/src/i18n/` directory.

```bash
cd lib/src/i18n/
cp en.i18n.json es.i18n.json # (1)!
```

1. Name the new file targeting the respective ISO 639-1 code (e.g., `es` for Spanish).

Open the new file and translate **only the values**. Keys must remain identical so the Dart generators can bridge the configuration correctly.

=== "`en` Original"

    ```json
    {
      "navigation": {
        "sheets": "Cheatsheets",
        "coupons": "Coupons",
        "settings": "Settings"
      }
    }
    ```

=== "`es` Translation"

    ```json
    {
      "navigation": {
        "sheets": "Cheatsheets",
        "coupons": "Cupones",
        "settings": "Configuración"
      }
    }
    ```

!!! tip "UI Constraints"
    Some languages use significantly more characters than others. Use concise translations to prevent buttons or labels from breaking layout constraints on small screens.

### Register for iOS

To make the new language visible to the iOS operating system, it must be explicitly declared. Add the new language code to `CFBundleLocalizations` inside `ios/Runner/Info.plist`.

```xml
<key>CFBundleLocalizations</key>
<array>
    <string>en</string>
    <string>es</string>
</array>
```

### Generate Code

Update the Dart representation of the JSON files by running.

```bash
dart run slang
```

Commit your changes properly (e.g., `feat(i18n): add spanish support`) and submit a Pull Request.

## Update Existing Translations

If you notice a typo in an existing translation file:

1. Locate the file in `lib/src/i18n/`.
2. Update the target value directly.
3. Apply the changes and submit a Pull Request.
