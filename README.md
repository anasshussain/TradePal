# My Trade Pal

A trade market place to find easy trades or your next job.

A Flutter application targeting mobile and web, backed by Supabase (auth,
database) with Firebase Cloud Messaging for push notifications and Stripe for
payments.

## Getting Started

This project runs on the Flutter _stable_ channel.

```sh
flutter pub get
flutter run
```

To build for web:

```sh
flutter build web --release
```

## Project layout

| Path          | Contents                                                        |
| ------------- | --------------------------------------------------------------- |
| `lib/theme`   | `AppTheme` — colours, typography and design tokens               |
| `lib/widgets` | Shared UI widgets (`AppButton`, `AppIconButton`, `AppDropDown`…) |
| `lib/core`    | Models, utilities, uploads, custom functions                     |
| `lib/nav`     | `AppRoute` and router configuration                              |
| `lib/backend` | Supabase, Firebase and API request layers                        |

### Theming note

`AppTheme.of(context)` returns text styles directly rather than exposing them
through `ThemeData.textTheme`. This is deliberate: it keeps `ThemeData.localize()`
from applying the `englishLike2021` geometry (which would override `letterSpacing`)
to these styles. Moving the `TextTheme` into `ThemeData` would silently change
type across the app.
