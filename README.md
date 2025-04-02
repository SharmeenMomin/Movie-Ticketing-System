# Movie Ticketing System Documentation

## Author:
Sharmeen Momin (smomin@ncsu.edu)

---

### Introduction
Welcome to the Movie Ticketing System documentation! This system is designed for multiplex chains, allowing users to browse available movies, purchase tickets, and view showtimes, while also providing admin functionalities to manage users, movies, shows, and tickets.

---

### System Overview
The Movie Ticketing System is a web application that simplifies the process of browsing movies and purchasing tickets. Below is an overview of the key components of the system:

---
## Installation

1. Clone the repo: 
```
git clone https://github.com/SharmeenMomin/Movie-Ticketing-System.git
```

2. Install dependencides
```
cd Movie Ticketing System
bundle install
```

3.	Set up the database:
```
rails  db:migrate
```
-----

## **User Roles**  

### **Admin**  
The admin has full control over the system and can perform CRUD operations on movies, shows, users, and tickets.  

#### **Admin Login Details**  

        email id: admin@example.com
        password: SecurePass123

#### **Functions**  
- Manage movies, shows, users, and tickets.  
- Perform CRUD operations on movies, shows, users, and tickets.  
- View all registered users and bookings.  

### **User**  
Users can browse available movies, view their booking history, and purchase tickets for available shows.  

#### **Functions**  
- Browse available movies and view details.  
- Purchase tickets and manage bookings.  
- View and cancel booked tickets.  
- Edit profile details.  


---

## **Features**  

### **Movie & Show Management**  
- **View Movies**: Browse all available movies with details (title, genre, duration, language, rating, release date).  
- **View Shows**: Check showtimes for movies, including date, time, available seats, and ticket price.  

### **Ticket Booking**  
- **Book Tickets**: Select a movie, choose a showtime, and purchase tickets. Total cost is calculated dynamically.  
- **Cancel Tickets**: Users can cancel booked tickets, and seat availability updates accordingly.  
- **View Booking History**: Users can track their bookings.  

### **User Management**  
- **User Registration & Login**: Secure sign-up and login using session management.  
- **Edit Profile**: Users can update their personal information .  
- **Delete Account**: Users can delete their account, which removes all associated tickets.  

### **Admin Privileges**  
- **Admin Dashboard**: Manage users, movies, shows, and tickets.  
- **User Management**: Create, view, edit, and delete users.  
- **Movie Management**: Add, edit, and delete movies (deleting a movie removes all its associated shows).  
- **Show Management**: Create, edit, and delete show schedules.  
- **Ticket Management**: View all user bookings.  

----

## **Usage Guide**  

### **User Actions**  
- **Sign Up:** Register for an account on the homepage.  
- **Login:** Enter credentials on the login page.  
- **Browse Movies:** Click **"Movies"** to see available films.  
- **View Shows:** Select a movie to view its showtimes.  
- **Book Tickets:** Choose a show and number of seats, then confirm payment.  
- **Cancel Tickets:** Go to **"My Bookings"** and select **"Cancel"** next to a ticket.  

### **Admin Actions**  
- **Manage Users:** Go to **"Admin Dashboard" → "Users"** to add, edit, or delete users.  
- **Manage Movies:** Go to **"Movies"** to add, edit, or delete movie entries.  
- **Manage Shows:** Go to **"Shows"** to schedule, edit, or delete shows.  
- **Manage Tickets:** Go to **"Tickets"** to view all bookings.

----

### **Bonus Features**  
- **Search for Users Who Booked a Movie:** Admins can enter a movie title in the search bar to find users who booked tickets.  
- **Multiple Screens per Movie:** Each movie can have multiple screens with different showtimes.
 
-----
## RSpec

Model covered: Movie

Controller covered: Movie

To set up:

1) After cloning the repo:
```
rails db:migrate
```
2) Install the gems
```
bundle install
```
3) Set up the test environment:
```
rails db:migrate RAILS_ENV=test
rails db:test:prepare
```
4) Run the test cases:
   
   For Movies model:
```
rspec spec/models/movie_spec.rb
```
   For Movies controller:
```
rspec spec/controllers/movies_controller_spec.rb
```

