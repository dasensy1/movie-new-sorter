# API Configuration

## TMDB API Key Setup

### Step 1: Register on TMDB
1. Go to https://www.themoviedb.org
2. Click "Join TMDB" and create an account
3. Verify your email address

### Step 2: Request API Key
1. Log in to your TMDB account
2. Go to **Settings** → **API** → **Create** (or visit: https://www.themoviedb.org/settings/api)
3. Click "Developer" to create a developer account
4. Fill in the application details:
   - **Application Name**: `Via Films`
   - **Application URL**: `http://localhost`
   - **Application Summary**: `Mobile application for browsing and sorting movies`

### Step 3: Get Your API Key
1. After approval (usually instant), you'll see your API key
2. Copy the **API Key (v3 auth)** value
3. Open `lib/config/api_config.dart`
4. Replace `YOUR_TMDB_API_KEY_HERE` with your actual API key

### Example:
```dart
static const String tmdbApiKey = 'a1b2c3d4e5f6g7h8i9j0k1l2m3n4o5p6';
```

### Step 4: Run the App
```bash
flutter run -d windows
```

## Notes
- The app has fallback data, so it works without an API key
- Keep your API key private - don't commit it to public repositories
- Free tier allows 500 requests per day
