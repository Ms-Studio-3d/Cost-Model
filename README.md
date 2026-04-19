# Cost Model

Mobile app for architecture cost modeling and pricing.

## Included modules
- Buildings
- Master Plan
- Combined
- Results dashboard

## Tech
- Flutter
- GitHub Actions

## Build flow
This repository uses GitHub Actions to:
1. create a temporary Flutter Android project
2. copy the source code from the repo
3. run analyze
4. build a release APK
5. upload the APK as an artifact

## Run locally
```bash
flutter pub get
flutter run
