 # StyleFlux <img src="https://imgur.com/Jd49KgF.png" width="50">

**StyleFlux** is a full-featured SwiftUI shopping app designed to provide users with a seamless online shopping experience. It incorporates user authentication, product browsing, and cart management using Firebase services. The app demonstrates clean, reusable SwiftUI components and integrates with Firebase for product data, user authentication, and image storage.

## Table of Contents
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Screenshots](#screenshots)
- [Future Improvements](#future-improvements)
- [Contributing](#contributing)
- [License](#license)

## Features

- **User Authentication**: Users can sign up and log in using their email through Firebase Authentication. The app supports persistent user sessions.
- **Product Browsing**: Products are dynamically fetched from Firebase, with detailed product pages displaying product images and details.
- **Cart Management**: Users can add products to their cart, and cart contents are saved to Firebase. When users log in, their cart items are automatically restored. 
- **Firebase Integration**:
  - **Firebase Authentication** for secure user login and sign-up.
  - **Firestore Database** for storing product data and syncing cart data in real-time.
  - **Product and Image Upload Feature**: Easily upload products and their images into Firebase using a custom method that integrates Firestore and Firebase Storage. Product images are stored in Firebase Storage, while product details, including the image URL, are saved in Firestore. This feature ensures smooth product management within the app.
  - **Real-Time Cart Sync**: Cart items are saved to Firebase, enabling users to access their cart across devices.
- **MVVM Architecture**: Follows the MVVM (Model-View-ViewModel) architecture to separate logic from the user interface.
- **Cart Calculations**: The cart calculates the total value of selected products, factoring in taxes to give users an accurate total.

## Technologies Used

- **SwiftUI**: For building the user interface and managing layouts.
- **Firebase Authentication**: To handle secure user login, sign-up, and session management.
- **Firebase Firestore**: For storing product details and syncing cart data in real-time.
- **Firebase Storage**: For uploading and managing product images.
- **JSON Decoding**: To load and parse product data from local files.

## Screenshots





