# Using SwiftUI-Ratings with Supabase and App Store Connect API

This guide explains how to create a Supabase Edge Function that fetches app ratings and reviews from the App Store Connect API and formats the data for use with SwiftUI-Ratings.

## Prerequisites

- A Supabase project (free tier works fine)
- App Store Connect API access
- An app published on the App Store

## Setting Up App Store Connect API Access

1. Log in to [App Store Connect](https://appstoreconnect.apple.com/)
2. Go to Users and Access > Keys
3. Create a new API Key with the "Customer Reviews" permission
4. Note down the Key ID, Issuer ID, and download the private key file

## Creating the Supabase Edge Function

1. Install Supabase CLI and log in to your account
2. Initialize edge functions in your project
3. Create a new edge function called `app_ratings`:

```typescript
// app_ratings.ts - Supabase Edge Function
import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import * as jose from 'https://deno.land/x/jose@v4.14.4/index.ts'

serve(async (req) => {
  try {
    // Parse the request body
    const { appId } = await req.json()
    
    if (!appId) {
      return new Response(JSON.stringify({ error: 'App ID is required' }), {
        headers: { 'Content-Type': 'application/json' },
        status: 400,
      })
    }
    
    // Get App Store Connect API credentials from environment variables
    const { APPSTORE_ISSUER_ID, APPSTORE_KEY_ID, APPSTORE_PRIVATE_KEY } = Deno.env.toObject()
    
    // Generate JWT token for App Store Connect API
    const privateKey = APPSTORE_PRIVATE_KEY.replace(/\\n/g, '\n')
    
    const jwt = await new jose.SignJWT({})
      .setProtectedHeader({ alg: 'ES256', kid: APPSTORE_KEY_ID, typ: 'JWT' })
      .setIssuedAt()
      .setIssuer(APPSTORE_ISSUER_ID)
      .setExpirationTime('1h')
      .setAudience('appstoreconnect-v1')
      .sign(await jose.importPKCS8(privateKey, 'ES256'))
    
    // Fetch ratings and reviews from App Store Connect API
    const url = `https://api.appstoreconnect.apple.com/v1/apps/${appId}/customerReviews`
    const response = await fetch(url, {
      headers: {
        Authorization: `Bearer ${jwt}`,
        'Content-Type': 'application/json',
      },
    })
    
    const appStoreData = await response.json()
    
    // Transform the data to match SwiftUI-Ratings's expected format
    const reviews = appStoreData.data.map(review => ({
      title: review.attributes.title,
      content: review.attributes.body,
      rating: review.attributes.rating,
      author: review.attributes.reviewerNickname || 'Anonymous',
      date: new Date(review.attributes.createdDate).toISOString()
    }))
    
    // Calculate average rating
    const totalRatings = reviews.length
    const averageRating = totalRatings > 0
      ? reviews.reduce((sum, review) => sum + review.rating, 0) / totalRatings
      : 0
    
    // Return the data in the format expected by SwiftUI-Ratings
    return new Response(JSON.stringify({
      averageRating,
      totalRatings,
      reviews
    }), {
      headers: { 'Content-Type': 'application/json' },
    })
  } catch (error) {
    console.error('Error fetching app ratings:', error)
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500,
    })
  }
})
```

## Setting Environment Variables

In your Supabase dashboard, set the following secrets:

- `APPSTORE_ISSUER_ID`: Your App Store Connect Issuer ID
- `APPSTORE_KEY_ID`: Your App Store Connect Key ID
- `APPSTORE_PRIVATE_KEY`: Your App Store Connect API private key (paste the entire contents)

## Deploy the Function

```bash
supabase functions deploy app_ratings
```

## Creating a Swift Provider for the Supabase Function

Now in your app, implement an `AppRatingProviding` class that uses the Supabase function:

```swift
struct SupabaseAppRatingProvider: AppRatingProviding {
    let supabaseUrl: URL
    let supabaseKey: String
    let appId: String
    
    init(supabaseUrl: URL, supabaseKey: String, appId: String) {
        self.supabaseUrl = supabaseUrl
        self.supabaseKey = supabaseKey
        self.appId = appId
    }
    
    func fetch() async throws -> AppRatingResponse {
        var request = URLRequest(url: URL(string: "\(supabaseUrl)/functions/v1/app_ratings")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(supabaseKey, forHTTPHeaderField: "Authorization")
        
        let payload = ["appId": appId]
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return try decoder.decode(AppRatingResponse.self, from: data)
    }
}
```

## Using the Supabase Provider with SwiftUI-Ratings

```swift
let provider = SupabaseAppRatingProvider(
    supabaseUrl: URL(string: "https://yourproject.supabase.co")!,
    supabaseKey: "your-supabase-anon-key",
    appId: "your-app-store-id"
)

RatingRequestScreen(
    appId: "your-app-store-id",
    appRatingProvider: provider
)
```

## Security Considerations

- The Supabase anon key is public, but the App Store Connect API credentials are securely stored as environment variables
- Consider adding rate limiting to your function
- For production use, you may want to cache responses to reduce API calls

## Troubleshooting

- If you receive a 401 error, check that your JWT is being generated correctly
- If you receive a 403 error, verify that your API key has the correct permissions
- Use Supabase logs to debug any issues with the function execution
