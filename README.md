# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:
 `git clone https://github.com/deepakj98/event_management_api.git`
 `cd event_management_api`
 `bundle install`
 `rails db:migrate`
 `rails db:seed` to populate test data

 `docker-compose up --build`
 


API ENDPOINTS
1. users#signup  				`/users/signup` 			POST
	request:
	`{
	    "user": {
	        "email": "jhadeepak746@gmail.com",
	        "password": "password",
	        "password_confirmation": "password",
	        "role": 1
	    }
	}`

	response:
	`
	    "user": {
        	"id": 2,
        	"email": "jhadeepak746@gmail.com",
        	"created_at": "2025-01-14T14:59:46.749Z",
        	"updated_at": "2025-01-14T14:59:46.749Z",
        	"role": "attendee"
    	}
	}` 
2. users#login 					`/users/login` 				POST
	params =>
	`{
		"email": "jhadeepak746@gmail.com",
		"password": "password"
	}`

	response =>
	`{
	  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyfQ.JlhLkS4gZEsnwuGuAR8upDUVDuf9-DNHj_rRYWg4sqI"
	 }`
3. venues#index  				`/venues` 					GET
	`[
	    {
	        "id": 1,
	        "name": "Milan",
	        "location": "New Delhi",
	        "capacity": 100,
	        "created_at": "2025-01-14T15:24:28.772Z",
	        "updated_at": "2025-01-14T15:24:28.772Z"
	    }
	]`
4. venues#create 				`/venues` 					POST
	request:
	 `
	 {
	    "venue": {
	        "name": "Milan",
	        "location": "New Delhi",
	        "capacity": 100
	    }
	}`

	response:
	`{
	    "id": 2,
	    "name": "Milan",
	    "location": "New Delhi",
	    "capacity": 100,
	    "created_at": "2025-01-14T15:28:22.864Z",
	    "updated_at": "2025-01-14T15:28:22.864Z"
	}`
5. venues#update 				`/venues/:id`		 		PUT
	request:
	`{
		"venue": {
		    "name": "Grand Milan",
		    "location": "New Delhi",
		    "capacity": 200
		}
	}`

	response:
	`{
	    "id": 2,
	    "name": "Grand Milan",
	    "location": "New Delhi",
	    "capacity": 200,
	    "created_at": "2025-01-14T15:28:22.864Z",
	    "updated_at": "2025-01-14T15:28:22.864Z"
	}`
6. venues#destroy 				`/venues/:id`				DELETE
7. events#index					` /venues/:venue_id/events`	GET
	response:
	`[
	    {
	        "id": 4,
	        "title": "Tech Conference",
	        "description": "lorem ipsum",
	        "date": "2025-01-21T18:05:53.410Z",
	        "venue_id": 6,
	        "created_at": "2025-01-14T18:05:53.410Z",
	        "updated_at": "2025-01-14T18:05:53.410Z",
	        "price": 100
	    }
	]`
8. events#create				`venues/:venue_id/events`	POST
	request:
	`{
	    "event": {
	        "title": "Music Concert", 
	        "date": "25/02/2025",
	         "price": 50.00, 
	          "description": "lorem ipsum"
	    }
	}`

	response:
	`{
		"id": 5,
		"title": "Music Concert",
		"description": "lorem ipsum",
		"date": "2025-02-25T00:00:00.000Z",
		"venue_id": 6,
		"created_at": "2025-01-14T18:46:55.273Z",
		"updated_at": "2025-01-14T18:46:55.273Z",
		"price": 50
	}`
9. events#update				`/events/:id`				PUT
	request:
	`{
	    "event": {
	        "title": "Music Concert", 
	        "date": "25/02/2025",
	         "price": 100.00, 
	          "description": "lorem ipsum"
	    }
	}`

	response:
	`
	{
	    "title": "Music Concert",
	    "description": "lorem ipsum",
	    "date": "2025-02-25T00:00:00.000Z",
	    "price": 100,
	    "id": 5,
	    "venue_id": 6,
	    "created_at": "2025-01-14T18:46:55.273Z",
	    "updated_at": "2025-01-14T18:48:47.758Z"
	}`
10. events#destroy				`/events/:id`				DELETE
11. events#search				`/events/search`			GET
	params: [any one or multiple params can be passed to search]
	`{
		date: 20/01/2025,
		venue_id: 6,
		price: 100
	}`

	response:
	`[
		{
		    "id": 4,
		    "title": "Tech Conference",
		    "description": "lorem ipsum",
		    "date": "2025-01-21T18:05:53.410Z",
		    "venue_id": 6,
		    "created_at": "2025-01-14T18:05:53.410Z",
		    "updated_at": "2025-01-14T18:05:53.410Z",
		    "price": 100
		},
		{
		    "id": 5,
		    "title": "Music Concert",
		    "description": "lorem ipsum",
		    "date": "2025-02-25T00:00:00.000Z",
		    "venue_id": 6,
		    "created_at": "2025-01-14T18:46:55.273Z",
		    "updated_at": "2025-01-14T18:48:47.758Z",
		    "price": 100
		}
	]`

12. bookings#index 				`/bookings`					GET
	response:
	`[
		{
		    "id": 2,
		    "user_id": 9,
		    "event_id": 2,
		    "status": "pending",
		    "created_at": "2025-01-14T18:05:53.447Z",
		    "updated_at": "2025-01-14T18:05:53.447Z"
		}
	]`
13. bookings#create				`/events/:event_id/bookings` POST
	response:
	`{
	    "id": 5,
	    "user_id": 8,
	    "event_id": 2,
	    "status": "pending",
	    "created_at": "2025-01-14T19:02:57.026Z",
	    "updated_at": "2025-01-14T19:02:57.026Z"
	}`
14. bookings#approve			`/bookings/:id/approve`     PUT
	response:
	`{
		"status": "approved",
		"id": 5,
		"user_id": 8,
		"event_id": 2,
		"created_at": "2025-01-14T19:02:57.026Z",
		"updated_at": "2025-01-14T19:03:46.183Z"
	}`
15. bookings#reject				`/bookings/:id/reject` 		PUT
	response:
	`{
		"status": "rejected",
		"id": 5,
		"user_id": 8,
		"event_id": 2,
		"created_at": "2025-01-14T19:02:57.026Z",
		"updated_at": "2025-01-14T19:04:22.371Z"
	}`
16. bookings#destroy			`/bookings/:id`				DELETE


* ...
