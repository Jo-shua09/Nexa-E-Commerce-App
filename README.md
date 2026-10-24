# nexa

A new Flutter project.

## Firebase client configuration

Firebase app configuration is generated per project and is intentionally
ignored by Git. Install the FlutterFire CLI, then run:

```powershell
flutterfire configure --project=nexa-31f08
```

This generates `lib/firebase_options.dart`, `android/app/google-services.json`,
and `firebase.json`. Keep these files local. If using a different Firebase
project, substitute its project ID.

## Product catalog in Cloud Firestore

The product grid, search, and product details listen to the `products`
collection in Cloud Firestore. Each document ID is the product ID and each
document stores `title`, `description`, `price`, `category`, `images`,
`rating`, and `reviewsCount`.

To seed the mock catalog once, first export the existing mock list:

```powershell
dart run tool\export_dummy_products.dart tools\firestore-seed\products.json
```

Install the seeder's dependencies and configure Application Default
Credentials with a service account authorized to write Firestore data:

```powershell
npm install --prefix tools\firestore-seed
$env:GOOGLE_APPLICATION_CREDENTIALS = 'C:\path\to\service-account.json'
npm run seed --prefix tools\firestore-seed
```

The seeder targets project `nexa-31f08`, refuses to replace existing product
IDs by default, and supports `--overwrite` to intentionally replace matching
documents. Keep the service-account file outside the repository. The app's
Firestore rules allow signed-in users to read the catalog and prohibit
client-side writes; the Admin SDK seeder bypasses client rules.

## User data in Cloud Firestore

The cart, wishlist, and orders are stored beneath `users/{uid}`, where `uid` is
the authenticated Firebase user's ID:

- `users/{uid}/cart/{itemId}` stores the product snapshot, selected size, and
  quantity.
- `users/{uid}/wishlist/{productId}` stores the saved product snapshot.
- `users/{uid}/orders/{orderId}` stores the purchased product snapshot,
  quantity, size, status, and creation time. Placing an order transactionally
  removes the corresponding cart items.

Demo orders are not migrated; each account's order history starts empty. Before
testing these features, make sure the local `firebase.json` points at this
repository's `firestore.rules` and deploy the rules with
`firebase deploy --only firestore:rules`. The rules restrict user data to its
owner.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
