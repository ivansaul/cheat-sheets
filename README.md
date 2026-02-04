<!-- markdownlint-disable MD033 MD036 MD041 MD045 MD046 -->

<div align="center">

![App Icon][app-icon]

<h1 style="border-bottom: none">
    <b><a href="#">Cheat Sheets</a></b>
</h1>

**`Cheat-Sheets`** Your go-to reference developer guide for learning `Python`, `Rust`, `Swift`, `JavaScript`, `Kotlin`, `Go`, `Git`, and more!

![Made-with-flutter](https://img.shields.io/badge/Made%20with-Flutter-orange)
[![Deploy | API](https://github.com/ivansaul/devstack-worker/actions/workflows/deploy.yaml/badge.svg)](https://github.com/ivansaul/devstack-worker/actions/workflows/deploy.yaml)
![GitHub repo size](https://img.shields.io/github/repo-size/ivansaul/cheat-sheets)
[![License: MIT](https://img.shields.io/badge/License-GPL-yellow.svg)](https://opensource.org/licenses/MIT)

<a href="https://play.google.com/store/apps/details?id=com.ivansaul.cheatsheets">
    <img alt="Google Play Badge" src="https://i.imgur.com/hWAyE3B.png" height="50px">
</a>
<a href="https://tinyurl.com/ivansaulAltstore">
    <img alt="Google Play Badge" src="https://i.imgur.com/8RQIaYh.png" height="50px">
</a>
<a href="https://github.com/ivansaul/cheat-sheets/releases/latest">
    <img alt="GitHub Badge" src="https://i.imgur.com/NKSbyj1.png" height="50px">
</a>
<br/>
<a href="https://discord.gg/tDvybtJ7y9">
    <img alt="Discord Server" height="50" src="https://cdn.jsdelivr.net/npm/@intergrav/devins-badges@3/assets/cozy/social/discord-plural_vector.svg">
</a>
</div>

---

![Banner][banner]

## Installation

### Android

You can install the app directly from:

- [**`Google Play`**][google-play]
- [**`GitHub Releases (.aab, .apk)`**][github-releases]

### iOS

On iOS, the app is distributed via **AltStore** (**no** jailbreak).

<details>

<summary>Click to expand</summary>

Please refer to the official AltStore installation guide:

- [macOS][altstore-doc-macos]
- [Windows][altstore-doc-windows]

Or follow a video guide:

- [macOS][altstore-video-macos]
- [Windows][altstore-video-windows]

Once AltStore is installed, you can install the app using one of the following methods:

- **AltStore Source**
- **Manual installation** by loading the `.ipa` file (recommended)

<a href="https://tinyurl.com/ivansaulAltstore">
    <img alt="Google Play Badge" src="https://i.imgur.com/8RQIaYh.png" height="50px">
</a>
<a href="https://github.com/ivansaul/cheat-sheets/releases/">
    <img alt="GitHub Badge" src="https://i.imgur.com/NKSbyj1.png" height="50px">
</a>

> **`[WARNING]`**
> 
> Opening the app via the **`OPEN`** button may cause it to not work correctly due to a deeplink issue.
> Please open it from the **home screen icon** instead.  
> This will be fixed in a future update.
>
> <img alt="Launch warning" width="70%" src="https://i.imgur.com/FpRolxK.png">

</details>

## Screenshots

![screenshot](https://imgur.com/lOKI2By.png)
![screenshot](https://imgur.com/1cch4Nj.png)

## Building from Source

```bash
git clone https://github.com/ivansaul/cheat-sheets.git
cd cheat-sheets
flutter pub get
dart run build_runner build
flutter run --release
```

> [!TIP]
> For full local setup, backend, and environment configuration, see [**`DEVELOPMENT GUIDE`**](./DEVELOPMENT.md).

## Road map

- [ ] Offline support
- [ ] Localization (i18n)
- [ ] Favorites, history & progress
  
## Development | Contributing

Contributions are welcome! Please refer to the [**`DEVELOPMENT GUIDE`**](./DEVELOPMENT.md) for more details.

## Facing any Issue?

Found a bug or have an idea? Open an [Issue][issue] :)

## Contact

If you want to contact me you can reach me at [Discord][discord].

## Acknowledgments

This project is based on [Fechin/reference][reference]. The main focus of this project is adding new features and make it accessible to everyone.

## License

This project uses GPLv3. See [LICENSE] for details.

[license]: ./LICENSE
[reference]: https://github.com/Fechin/reference
[discord]: https://discord.com/users/744755977684779038
[issue]: https://github.com/ivansaul/cheat-sheets/issues
[banner]: https://i.imgur.com/1OryIkl.png
[github-releases]: https://github.com/ivansaul/cheat-sheets/releases
[google-play]: https://play.google.com/store/apps/details?id=com.ivansaul.cheatsheets
[app-icon]: https://i.imgur.com/m2fO1J9.png
[altstore-doc-macos]: https://faq.altstore.io/altstore-classic/how-to-install-altstore-macos
[altstore-doc-windows]: https://faq.altstore.io/altstore-classic/how-to-install-altstore-windows
[altstore-video-macos]: https://www.youtube.com/watch?v=AtFcvxCBt-A
[altstore-video-windows]: https://www.youtube.com/watch?v=MY_2WqlzrHE