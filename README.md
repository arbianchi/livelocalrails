[![Code Climate](https://codeclimate.com/github/TIY-LiveLocal/livelocalrails/badges/gpa.svg)](https://codeclimate.com/github/TIY-LiveLocal/livelocalrails)

### Authentication

## To create user

####POST `/sign_up`
**request**

body:

              {
                email: email,
                password: new_password,
                password_confirmation: new_password,
                current_password: current_password,
                first_name: first,
                last_name: last,
                zip_code: zipcode,
                username: username,
              }
              
**response**

              `status 200`
            

####POST `/sign_in`

body:

              {
                username: username,
                password: password,
              }
              
**response**

              `status 200`


####POST `/sign_out` - signs out the current user


### Business Search Results - returns businesses based on user preferences and survey answers.

## Routes

####GET `/businesses`

- A user's page is populated with local businesses

####GET `/find_business`

- A businesses searches for itself to claim itself — this endpoint expects a `location` parameter and a `term` parameter; a productive search might be `22 Friendly Ave, Durham, NC` for the location and `Moe's Diner` for the term. Notice the use of street name and restaurant name.

- If a business has already been claimed, then a 401 status code and error message are sent back.

####GET `/yelp`

- Make a request for a businesses' yelp info; pass the business id (id from our db), and we'll pass back the yelp listing.

####POST `/surveys`, data: checkbox survey results

- Submit a new user or business survey.

####GET `/surveys`

- Get survey results for current user.

####GET `/surveys/matches`

- Returns list of businesses whose survey matches the current user survey on at least one criterion along with a list of survey questions answered 'true'.Response is of the form:
{ business1 => [lgbt, pets, livWage], business2 => [hiring, glutFree, sustain] }

####POST `/questions`, data: `{ business_id: integer, question_text: "question" }`
- Submit a question on the Q&A board of a business.

####GET `/questions`, data: `{ business_id: integer }`

- Returns a list of questions for a particular business.

####POST `/answers`, data: `{ question_id: integer, answer_text: "answer" }`

- Submit an answer to a question on the Q&A board of a business.

####GET `/answers`, data: `{ question_id: integer }`

- Returns a list of answers for a particular question.

####Get `/questions/all`, data: `{ business_id: integer }`

- Returns a hash fo all questions posted to a given business of the form:
{ Question 1 => [Answer1, Answer2]
  Question 2 => [Answer1] }

