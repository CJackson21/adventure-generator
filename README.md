# 🌄 Adventure App

A mobile Flutter app that finds random nearby adventures based on your current GPS location. Powered by Supabase, geolocation, and clean architecture.

---

## 📦 Features (Current)

- 🔍 Gets user location via [`geolocator`](https://pub.dev/packages/geolocator)
- 📍 Fetches nearby adventures from Supabase using the Haversine formula
- 🎲 Returns one random activity within a configurable radius
- 🧱 Modular service layer for activities, location, and Supabase setup
- ✅ Ready for expansion: authentication, favorites, submissions, and maps

---

## 🧪 Tech Stack

| Layer     | Technology                    |
| --------- | ----------------------------- |
| Frontend  | Flutter                       |
| Backend   | Supabase (PostgreSQL + Auth)  |
| Location  | `geolocator` Flutter plugin   |
| Structure | Modular service-based folders |

---

## 📁 Project Structure (Currently)

```
lib/
├── main.dart                     # App entry, calls initSupabase()
├── app.dart                      # Root MaterialApp widget
├── screens/
│   └── home_screen.dart          # Adventure UI screen
├── widgets/
│   └── adventure_display.dart    # Adventure display + refresh UI
├── logic/
│   └── adventure_loader.dart     # Combines location and activity logic
├── services/
│   ├── activity_service.dart     # Logic to fetch/filter activities
│   ├── location_service.dart     # Location + permission handling
│   └── supabase_initializer.dart # Supabase + dotenv init
```

---

## 🔧 Environment Setup

1. Create a `.env` file in your project root with:

   ```env
   SUPABASE_URL=https://your-project.supabase.co
   SUPABASE_ANON_KEY=your-anon-key
   ```

2. Load your environment variables before running the app:

   ```dart
   await dotenv.load(fileName: ".env");
   ```

3. Ensure your Supabase table structure is:

| Column        | Type      | Notes                                     |
| ------------- | --------- | ----------------------------------------- |
| `id`          | UUID      | Primary key, default `uuid_generate_v4()` |
| `title`       | Text      | Required                                  |
| `description` | Text      | Optional                                  |
| `category`    | Text      | Optional                                  |
| `latitude`    | Numeric   | Required                                  |
| `longitude`   | Numeric   | Required                                  |
| `created_at`  | Timestamp | Default: `now()`                          |
| `created_by`  | UUID      | Foreign key (references `auth.users`)     |

---

## 🚀 Run the App

```bash
flutter run
```

Make sure a connected device or emulator is running. Accept location permissions when prompted.

---

## 🗺️ Roadmap

### 🚧 Core Features (In Progress)

- [ ] **Populate DB with POIs based on user location (cache-aware)**  
       - Check if POIs for the current region already exist in Supabase  
       - Only call external API if location is new or data is stale  
       - Store fetched POIs in DB for reuse
- [ ] **Add loading and error states** for smoother UX
- [ ] **Display distance** from user to each adventure
- [ ] **Create “Add Adventure” form** with GPS autofill
- [ ] **Enable authentication** using Supabase Auth (email/password or magic link)
- [ ] **Track user favorites** in a dedicated `favorites` table

---

### 🧭 Navigation & Discovery (Future)

- [ ] **Display list of nearby adventures**, not just one
- [ ] **Add category filtering** (e.g. nature, food, museums)
- [ ] **Integrate map view** using `google_maps_flutter` or `flutter_map`
- [ ] **Show pins** for each nearby adventure on the map

---

### 🧪 Admin & Debug

- [ ] **Create admin-only view** to list, edit, or delete all activities
- [ ] **Add test mode** with fake location input
- [ ] **Add logs or analytics** for activity views and refreshes

---

### ✨ Polish & UX

- [ ] **Add custom icons or emojis** for categories
- [ ] **Improve UI layout** with better theming and spacing
- [ ] **Add animations** or transitions between adventures

---

## 📜 License

MIT License © 2025 Caleb

---

## 💬 Feedback

Pull requests and feature suggestions are welcome.  
Built for learning, exploring, and local discovery.

---

Let me know if you'd like a version with:

- **Shields.io badges** (Flutter, Supabase, License, etc.)
- **Images/screenshots**
- **Links to Supabase dashboard or deployment steps**
