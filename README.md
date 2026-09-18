# Ghost Riders — Bike Accessories & Helmets Shop

A responsive Flutter Web storefront for **Ghost Riders**, built with:
- **MVC-style architecture** (Models / Services (data layer) / Providers (controllers) / Views)
- **Provider** for state management
- **Firebase** (Auth + Firestore + Storage) as the backend
- A **hidden admin panel** — there is no visible "Login" button anywhere for customers
- **WhatsApp "Buy Now"** flow — tapping Buy opens WhatsApp with the product name, price, category, description & photo link pre-filled, sent to your business number

---

## 1. Project structure (MVC)

```
lib/
  core/                 # constants, colors, theme (shop info, brand colors)
  models/               # Model layer -> product_model.dart
  services/              # Data/Model layer -> Firebase Auth, Firestore, Storage
  providers/              # Controller layer -> AuthProvider, ProductProvider (Provider state mgmt)
  utils/                 # helpers -> WhatsApp deep link, external links, responsive breakpoints
  views/
    screens/             # View layer -> Home, Product Detail, Admin Login, Admin Dashboard, Add/Edit Product
    widgets/              # View layer -> Navbar, Hero, SearchFilterBar, ProductCard/Grid, Footer
  main.dart               # App entry, Firebase init, routes, MultiProvider
  firebase_options.dart    # PLACEHOLDER — regenerate with flutterfire configure (see step 3)
```

- **Model**: `models/product_model.dart` — plain product data object + Firestore (de)serialization.
- **Service (Data access)**: `services/` — talks directly to Firebase (Auth/Firestore/Storage). Nothing else in the app touches Firebase directly.
- **Controller**: `providers/` — `AuthProvider` and `ProductProvider` hold app state, call services, and notify the UI via `ChangeNotifier`/`Provider`.
- **View**: `views/` — pure UI, reads state from providers via `context.watch/read`, never calls Firebase directly.

---

## 2. Prerequisites

- Flutter SDK (3.24+ recommended) — https://docs.flutter.dev/get-started/install
- A free Firebase account — https://console.firebase.google.com
- Node.js (only needed for the Firebase CLI)

---

## 3. Firebase setup (do this once)

1. **Create a Firebase project**
   Go to https://console.firebase.google.com → *Add project* → name it e.g. `ghost-riders-shop`.

2. **Enable the services this app needs**
   In the Firebase Console, inside your new project:
   - **Authentication** → *Get started* → *Sign-in method* → enable **Email/Password**.
   - **Firestore Database** → *Create database* → start in *production mode*.
   - **Storage** → *Get started* (default bucket is fine).

3. **Create the ONE admin account**
   Still in **Authentication → Users**, click **Add user** and create an email/password for yourself (the shop owner). This is the *only* account that can log in — there is intentionally no sign-up screen in the app.

4. **Connect the Flutter app to your Firebase project**
   From inside this project folder, run:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   - Pick your Firebase project.
   - Select **web** (and any other platforms you want, e.g. android/ios).
   - This overwrites `lib/firebase_options.dart` with your real project keys — that's expected and required.

5. **Deploy the security rules** (already written for you in `firestore.rules` and `storage.rules`):
   ```bash
   npm install -g firebase-tools
   firebase login
   firebase init   # select Firestore + Storage, point to the SAME project, keep existing rules files
   firebase deploy --only firestore:rules,storage
   ```

   Configure Storage CORS for Flutter Web image loading:
   ```bash
   gsutil cors set storage.cors.json gs://gostrider-f27d7.firebasestorage.app
   ```

   The CORS policy is kept in `storage.cors.json` because Storage Rules control authorization, not browser response headers.

   These rules mean: **anyone can view products** (no login needed to browse the shop), but **only the logged-in admin can add/edit/delete products or upload photos**.

---

## 4. Install packages & run locally

```bash
flutter pub get
flutter run -d chrome
```

The storefront opens directly — no login screen, no admin link, exactly like a normal shop.

---

## 5. How the hidden admin login works

Nothing on the public site says "Admin" or "Login". To reach it, the shop owner can either:

- **Long-press the logo** in the top-left of the navbar, **or**
- **Tap the logo 5 times quickly**, **or**
- Type the URL directly in the browser: `https://yourdomain.com/#/admin-login`

All three open the admin login screen. After logging in with the email/password you created in Firebase Console → Authentication, you land on the **Admin Dashboard**, where you can:
- **Add Product** — upload a photo, enter name, description, price, and pick a category
- **Edit / Delete** any existing product
- Changes appear on the live storefront instantly (Firestore real-time stream)

If someone who isn't logged in tries to visit `/#/admin-dashboard` directly, they're automatically redirected back to the login screen (`_AdminGate` in `main.dart`).

> Want a stronger hidden trigger (e.g. a secret keyboard shortcut, or a completely different URL path) or a proper "forgot password" flow? Both are easy to add on top of this — just ask.

---

## 6. Search & filters

- The search bar (`views/widgets/search_filter_bar.dart`) filters live by product name/description.
- The category chips filter by the categories defined in `core/app_constants.dart` (`Helmets`, `Riding Jackets`, `Gloves`, `Riding Boots`, `Bike Accessories`, `Bike Parts`, `Protective Gear`, `Others`) — edit that list to match your real catalog.
- Both combine (e.g. search "helmet" within "Helmets" category).

---

## 7. "Buy Now" → WhatsApp flow

Every product's detail page has a **Buy Now via WhatsApp** button (`utils/whatsapp_helper.dart`). Tapping it opens WhatsApp (web or app) already addressed to your business number **+91 80868 16139**, with a pre-filled message containing:

```
🏍️ Product name
📂 Category
💰 Price
📝 Description
🖼️ Photo link
```

> Technical note: WhatsApp's `wa.me` links can only pre-fill **text**, not attach an image file automatically — that's a WhatsApp platform limitation, not something the app can work around. The image link is included in the text so you can open it instantly, and the customer has already seen the photo on the product page.

There's also a general **"WhatsApp Us"** floating button on the home page for non-product questions.

---

## 8. Social links & contact

All wired up in `core/app_constants.dart` and used by `utils/link_launcher.dart`:
- Instagram: https://www.instagram.com/ghostriders._
- YouTube: https://youtube.com/@ghostridersaccessories
- Location (Google Maps): https://maps.app.goo.gl/22aA3zZ986NMmrC96
- Phone / WhatsApp: +91 80868 16139

They appear in the navbar (desktop), footer (all screens), and the tel: link for "Call Us".

---

## 9. Responsive design

`utils/responsive.dart` defines breakpoints (mobile < 650px, tablet 650–1100px, desktop ≥ 1100px) used throughout to adjust:
- Product grid columns (1 → 5 depending on width)
- Navbar layout (icons collapse on mobile)
- Page padding and the product detail page (image beside text on desktop, stacked on mobile)

---

## 10. Deploying the website (Firebase Hosting — free)

```bash
flutter build web --release
firebase init hosting   # public directory: build/web, configure as single-page app: Yes
firebase deploy --only hosting
```

You'll get a live URL like `https://ghost-riders-shop.web.app`.

---

## 11. Adding your logo / branding assets

Your uploaded logo is already placed at `assets/images/logo.jpeg` and registered in `pubspec.yaml`. To replace it later, just overwrite that file (keep the same name) or update the path in `core/app_constants.dart` → `logoAssetPath`.

---

## 12. Notes on scope

This project ships as a **Flutter Web-focused** app (this is what was asked for — "create a responsive webpage"). The same codebase also runs on Android/iOS/desktop with Firebase — if you want native app builds too, run `flutter create .` in this folder to generate the platform folders, then re-run `flutterfire configure` to add those platforms.
"# gostriders_user_admin" 
