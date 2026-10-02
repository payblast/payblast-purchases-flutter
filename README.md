# payblast-purchases-flutter

Payblast Flutter purchases SDK

This repository does not vendor RevenueCat source. The public API shape is studied from [https://github.com/RevenueCat/purchases-flutter](https://github.com/RevenueCat/purchases-flutter) and reimplemented against Payblast.

## Contract

```text
configure(apiKey, appUserId)
logIn(appUserId) / logOut()
getOfferings()
purchase(package)
restore()
getCustomerInfo()
presentPaywall(offering?)
```

```bash
dart test
```

The Dart package is the shared contract. iOS and Android purchases stay in the native Payblast SDKs.

`getCustomerInfo` exposes `entitlements[lookupKey].isActive`. Packages carry the store product identifier for this SDK's platform. Purchases of digital goods inside the native app go through that store. Web purchases use Stripe Checkout on the app maker's connected account.

## Reference

- https://github.com/RevenueCat/purchases-flutter
