# agent_dart_auth_example

A new Flutter project.

## Quick Start

1. git clone
2. Deploy II to local envioronment, see [IC_ENV](https://github.com/AstroxNetwork/ic_env)
3. Run bootstrap script

```bash
dart ./scripts/prepare.dart
```
for more help, you can pass `--help` to see detail

```bash
❯ dart ./scripts/bootstrap.dart --help
-h, --help               Displays this help information.
    --[no-]production    Whether to use development environment.
-d, --deploy             Would you like to deploy canister
                         (defaults to "./canister")
-i, --ii                 II canister
                         (defaults to "rwlgt-iiaaa-aaaaa-aaaaa-cai")
```

4. Run flutter, change endpoint from `localhost` to `10.0.2.2` in `lib.main` if you use android emulator

```bash
flutter run
```



