# Quoteworthy Frontend

# Quoteworthy Frontend

Quoteworthy is a progressive web app for collecting and discovering excellent quotes. The app allows users to create accounts, log in, and add new quotes to the public quote feed. Once a quote is created they can edit or delete it later if they change their mind about it.

This repository is for the back end of the application, the front end repository is [available here](https://github.com/LucasLombardo/quoteworthy-frontend). The front end is hosted at [https://quoteworthy.netlify.com/](https://quoteworthy.netlify.com/).

The back end API is [available here](https://quoteworthy-backend.herokuapp.com/) (note you will need to access available endpoints rather than the root, for example /quotes).

## Technologies Used

Technologies used were JavaScript, Ruby on Rails, React, GatsbyJS, and styled components.

The web app was build using the JAMstack architechture, or JavaScript, APIs, and Prebuilt Markup. One of the key benefits of JAMstack apps and websites is that they are very fast since most of the content is served as prebuilt markup.

The front end of the app is built with GatsbyJS, a static site generation framework for React. When the site is being built or generated, Gatsby uses GraphQL to query all of the current quotes from the backend API (rails) and generate static HTML markup with the data. 

When a user loads the website, they are served the static data while clientside JavaScript sends AJAX requests and compares the static data with the latest data in Rails, adjusting the current quotes on the page once the query is complete. All non GET requests are run on the client side, allowing users to sign in/up and interact with the quotes.

The back end API was built using Ruby on Rails with a starter template from General Assembly that provided user authentication. The API allows for users to CREATE, READ, UPDATE, and DESTROY quotes in a RESTful fashion. The database used is PostgreSQL,

When users create, update, or delete quotes, the Rails API sends a webhook to the front end triggering the website to rebuild, a process which takes about a minute and a half. This results in static data being available for most of the content, and recently changed content to be adjusted at runtime. 

## Unsolved Problems

Problems I'm still working on are:
-   When quotes load, the quote the user is currently reading will move since new quotes get added above it. Ideally they should stay in the same place on the page similar to how twitter loads new tweets. 
-   Overfetching data on client requests, currently clientside AJAX calls get all quotes, it would be much more effecient to only serve quotes that have changed in the last hour.
-   Would be nice to have categories, quote lists, authors, and be able to view a user's page with all of their posted quotes/quote lists displayed.

## Planning Process / Problem Solving

I mainly used Trello for planning, and my strategy was to first aim for MVP or the minimum viable product to pass project requirements, and then do reach goals.

I used a baseline wireframe and drawings when planning and used diagrams for planning the entity relationships and project architechture. 

My approach for problem solving and avoidance was to deploy early and often. By checking the application on both local and production environments every step of the way, when I inevitably encountered errors it was easier to identify which areas of my code were causing the issues. By isolating the problem areas of my code it made it easier to find answers online or ask questions.

## ERD

The app is still in progress, below is the current ERD of the API and the expected ERD of the next version.
![ERD](https://imagizer.imageshack.com/img923/7421/g2kJdA.png "ERD")