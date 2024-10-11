 # StyleFlux 
![5d820786-5345-4b40-9da8-fde6344ca0f6 (1) (1)](https://github.com/user-attachments/assets/095e5a2b-468a-4f92-bdb0-19d3489cea0f)


**StyleFlux**  is a iOS shopping app that gives users a smooth online shopping experience. It uses Firebase for user login, browsing products, and managing the shopping cart. The app is built with reusable SwiftUI components and designed to scale easily. While it's a learning project, it also functions as a real shopping app. Firebase helps manage real-time data and store product images, making it a strong base for future updates and features.

## Table of Contents
- [Demo](#demo)
- [Screenshots](#screenshots)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Contributing](#Contributing)
- [License](#License)


## Demo

<div align="center">



https://github.com/user-attachments/assets/1ff54a78-4af5-4c5f-8e37-c9717131f3c8



</div>

## Screenshots

<div align="center">
  <!-- Row 1 -->
  <img src="https://github.com/user-attachments/assets/aa37bb01-e5c1-44b5-bc35-ea63eef1fbc9" alt="iPhone 16 Pro - Natural Titanium 1" width="30%">
  <img src="https://github.com/user-attachments/assets/15b5efcf-f7d3-4551-99f8-3409fa9d133c" alt="iPhone 16 Pro - Natural Titanium 2" width="30%">
  <img src="https://github.com/user-attachments/assets/385f831a-de42-49e6-bf9b-1dc63e5220d6" alt="iPhone 16 Pro - Natural Titanium 3" width="30%">

  <!-- Row 2 -->

  <img src="https://github.com/user-attachments/assets/ec08bec2-d8a6-44a0-bb04-04260b6186d1" alt="iPhone 16 Pro - Natural Titanium 6" width="30%">
  <img src="https://github.com/user-attachments/assets/0e49c23c-83fa-45fd-ada1-6049f4bfd270" alt="iPhone 16 Pro - Natural Titanium 5" width="30%">
  <img src="https://github.com/user-attachments/assets/dd47a6e0-ea3e-4c3c-abfe-7c889a998b17" alt="iPhone 16 Pro - Natural Titanium 4" width="30%">

  <!-- Row 3 -->

  <img src="https://github.com/user-attachments/assets/aeb3ae1a-b7cf-48d6-8ff6-eb8368211644" alt="iPhone 16 Pro - Natural Titanium 9" width="30%">
  <img src="https://github.com/user-attachments/assets/4e0011cf-b07b-4b87-a7d5-c5f85ec89da9" alt="iPhone 16 Pro - Natural Titanium 8" width="30%">
  <img src="https://github.com/user-attachments/assets/a3822d66-3182-4b7c-a058-526158568eae" alt="iPhone 16 Pro - Natural Titanium 7" width="30%">

</div>





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

## Contributing
Contributions from developers and mobile app enthusiasts are welcome. If you have ideas for new features or improvements, feel free to fork the repository, make changes, and submit a pull request. Let’s collaborate to expand StyleFlux together.

## License
This project is licensed under the MIT License, allowing you to modify, distribute, and use the code with proper attribution to the original creators.






