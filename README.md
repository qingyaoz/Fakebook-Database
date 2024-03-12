# Fakebook-Database
I designed a relational database to store information for the fictional social media platform "Fakebook".

## Objective
The objective is to practice creating ER diagrams and a series of SQL scripts to create, load and delete objects.

## Rules of the Fakebook
### Users
Fakebook’s Users feature is its most robust feature currently available to the public. When a Fakebook user signs up for the platform, they are assigned a unique user ID. Their profile also consists of a first name, last name, day, month, year of birth, and a non-binary gender. Additionally, users may (but are not required to) list a hometown city and/or a current city on their profile, and these cities can be changed at any time, though they can only have 1 hometown and 1 current city at any given time. Each city has a unique city ID, a city name, a state name, and a country name. The combination of city name, state name and country name is unique (you may not need to reflect this property in your ER Diagram).

In addition to its users’ personal information, Fakebook maintains educational history on each user, which consists of programs and graduation year. Besides a unique program ID, each program also has a trio of fields: the institution (e.g. “University of Michigan”), the concentration (e.g. “Computer Science”) and the degree (e.g. “B.S.”); this trio must be unique for every such program. Users may list any number of programs (including 0) in their educational history; and a program may or may not be listed in the educational history of any number of users. Fakebook allows different users to register for the same program with the same or different graduation years; however, a user cannot list the same program multiple times with different graduation years.

The last piece of the Users feature is friends. Two different Fakebook users can become friends through the platform, but a user cannot befriend him/herself (you may not need to reflect this property in your ER Diagram). Fakebook tracks the members of a friendship as “Requester” and “Requestee” (recall the concept of different roles in the same entity from lecture). There is no limit to the number of friends a Fakebook user can have. Also, a Fakebook user can have zero friends :/

### Messages
Fakebook allows messages to be sent between two users (including themselves). Each message is given a unique message ID. Fakebook records the message content and the message sent time. It also tracks the user who sends the message as “Sender” and the user who receives the message as “Receiver”. A Fakebook user can send or receive 0 or more messages, but a message can only be sent exactly once (i.e. it has exactly one sender and exactly one receiver). Group messages are currently not supported by Fakebook.

### Photos and Albums
Like any good social media platform, Fakebook allows its users to post photos. Once uploaded, photos are placed into albums and each photo must belong to exactly one album. Each photo is given a unique photo ID, and the metadata for photos consists of the photo uploaded time, last modified time of the photo, the photo’s link, and a caption. Fakebook does not directly track the owner/poster of a photo, but this information can be retrieved via the album in which the photo is contained.

Each Fakebook album has a unique album ID and is owned by exactly one Fakebook user. There is no limit to the number of albums a single user can own, and there is no limit to the number of photos that an album can contain. However, each album must contain at least one photo. Fakebook tracks metadata for albums: the album name, the time the album was created, the last modified time of the album, the album’s link, and a visibility level (e.g. ‘Myself’, ‘Everyone’). In addition, each album must have exactly one cover photo; however, that photo does not have to be one of the photos in the album. A single photo can be the cover photo of 0 or more albums.

In addition to creating albums and uploading photos to those albums, Fakebook users can be tagged in the photos. Fakebook tracks the tagged user (but not the user doing the tagging), the tagged time, and the x-coordinate and y-coordinate within the photo. A user can be tagged in any number of photos, but cannot be tagged in the same photo more than once. A single photo can contain tags of 0 or more users. The tagged time and x, y coordinates may be the same or different (e.g., two tags on one photo could share the same x, y coordinates).

### Events
The final feature of Fakebook is Events. An event itself is uniquely identified by an event ID and also contains a name, a tagline, and a description. Each event is created by a single Fakebook user (the “creator”); a Fakebook user can create 0 or more events. Other metadata for an event includes the host (not a Fakebook user but a simple string), the street address, the event’s type and subtype, the start and end time. Each event must be located in exactly one city; each city may have 0 or more events being held in.

The creator of an event does not have to participate in the event, which means that Fakebook events can have an unlimited number (including 0) of users participating. Each participant in an event has a confirmation status (e.g. ‘Attending’, ‘Declines’). Users can participate in any number of events, but no user can participate in the same event more than once, even with a different confirmation status.

## Desired Schema
Refer to https://eecs484db.github.io/wn24/p1-fakebook-db.
