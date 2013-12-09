Use the `merges` directory just like you would in a vanilla Cordova project.

Example structure:
`<your app dir>/merges/android/index.html`
`<your app dir>/merges/ios/index.html`

This will generate `dist/index.android.html` (android) and `dist/index.html` (ios) files during Steroids `make`.
Read more about the `.android.` extension here: http://guides.appgyver.com/steroids/guides/android/android-extension/

Merge files will overwrite existing files when building to the `dist` directory.

For example: `www/index.html` would be overwritten by `merges/ios/index.html` and `www/index.android.html` would be overwritten by `merges/android/index.html`.