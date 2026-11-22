# Class navigation and data flow

This overview shows how the main Flutter classes reach one another and which
values are passed between them.

## Application start

```text
main()
  -> Nursery()
  -> MyHomePage(title: "nursery")
  -> AuthGate(onAuthStateChanged: callback)
```

| From | To | Values passed |
|---|---|---|
| `main()` | `Nursery` | No constructor values |
| `Nursery` | `MyHomePage` | `title: "nursery"` |
| `MyHomePage` | `AuthGate` | `onAuthStateChanged: (bool value) { ... }` |

`MyHomePage` stores the current login state in `_isLoggedIn`. The callback from
`AuthGate` updates this value when the Supabase session changes.

## How to reach `Dashboard`

`Dashboard` is not opened with `Navigator.push`. It is selected by
`AuthGate` based on the current Supabase authentication session:

```text
MyHomePage
  -> AuthGate(onAuthStateChanged: callback)
  -> StreamBuilder<AuthState>
  -> Dashboard(onLogout: callback)       if a session exists
  -> LoginScreen(onLoginSuccess: callback) otherwise
```

The relevant values are:

| From | To | Values passed |
|---|---|---|
| `MyHomePage` | `AuthGate` | `onAuthStateChanged: ValueChanged<bool>` |
| `AuthGate` | `Dashboard` | `onLogout: () => onAuthStateChanged(false)` |
| `AuthGate` | `LoginScreen` | `onLoginSuccess: () => onAuthStateChanged(true)` |

The callbacks do not transport user data. They only communicate whether the
authentication state changed.

## Login flow

```text
LoginScreen
  -> Supabase Auth
  -> onLoginSuccess()
  -> AuthGate rebuilds
  -> Dashboard
```

`LoginScreen` has the following constructor value:

```dart
LoginScreen({
  required VoidCallback onLoginSuccess,
})
```

The email and password are kept locally in:

- `_usernameController`
- `_passwordController`

They are passed to `signInWithEmail(email, password)` and then to Supabase.

## Registration flow

```text
LoginScreen
  -> RegisterPage(onLoginSuccess: same callback)
  -> Supabase Auth and userData table
  -> onLoginSuccess()
  -> AuthGate rebuilds
  -> Dashboard
```

`RegisterPage` receives:

```dart
RegisterPage({
  required VoidCallback onLoginSuccess,
})
```

The registration values are collected locally and passed to:

```dart
signUpWithEmail(email, password, organization, name)
```

After registration, the organization is stored in the `userData` table.

## Dashboard to user menu

```text
Dashboard
  -> UserMenuPage(onLogout: widget.onLogout)
```

`Dashboard` opens `UserMenuPage` with:

```dart
UserMenuPage({
  required VoidCallback onLogout,
})
```

The callback is forwarded unchanged. When the user logs out, `UserMenuPage`
calls Supabase `signOut()`, then calls `onLogout()`. This causes
`AuthGate` to display `LoginScreen` again.

## Dashboard child widgets

The dashboard creates these reusable widgets and passes display data to them:

| Class | Important values |
|---|---|
| `DashboardInfoCard` | `icon`, `label`, `value`, optional `onTap` |
| `AlertCard` | `title`, `subtitle`, `description`, `color`, `data`, `onTap` |
| `Timeline` | optional `title`, `accentColor`, `children: List<TimelineItem>` |
| `TimelineItem` | `child`, optional `color`, `isFirst`, `isLast` |
| `UserButton` | no constructor values |
| `NotImplementedDialog` | no constructor values |

These widgets do not navigate to another screen themselves. Their callbacks
are defined by `Dashboard`.

## Main source files

- [`main.dart`](../lib/main.dart)
- [`auth_gate.dart`](../lib/core/auth_gate.dart)
- [`login_screen.dart`](../lib/screens/login/login_screen.dart)
- [`register_screen.dart`](../lib/screens/login/register_screen.dart)
- [`dashboard.dart`](../lib/screens/dashboard.dart)
- [`user_menu.dart`](../lib/screens/user_menu.dart)
