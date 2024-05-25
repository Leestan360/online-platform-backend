# Online Platform Back-end

## Technologies used
1. Ruby on Rails - For the API
2. JWT based authentication
3. PostgreSQL - For the database

## Local Setup
1. Open your terminal and navigate to a directory of your choice
2. Clone the repository - `git clone git@github.com:Leestan360/online-platform-backend.git` or `git clone https://github.com/Leestan360/online-platform-backend.git`
3. Navigate to the project directory - `cd online-platform-backend`
4. Install dependencies - `bundle install`
5. Create a `.env file` to store secrets. In the `.env file`, Add `POSTGRES_USER (Your postgres username)` and `POSTGRES_PASSWORD (Your postgres password)` to the `.env file`
6. Ensure postgreSQL is installed locally. 
7. Create a database - `rails db:create` and the migrate the tables `rails db:migrate`
8. Start the server - `rails s`

