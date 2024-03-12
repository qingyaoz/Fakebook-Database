-- Create View_User_Information
CREATE VIEW View_User_Information AS
SELECT
    Users.user_id AS user_id,
    Users.first_name AS first_name,
    Users.last_name AS last_name,
    Users.year_of_birth AS year_of_birth,
    Users.month_of_birth AS month_of_birth,
    Users.day_of_birth AS day_of_birth,
    Users.gender AS gender,
    currC.city_name AS current_city_name,
    currC.state_name AS current_state_name,
    currC.country_name AS current_country_name,
    homeC.city_name AS hometown_city_name,
    homeC.state_name AS hometown_state_name,
    homeC.country_name AS hometown_country_name,
    Programs.institution AS institution_name,
    Education.program_year AS program_year,
    Programs.concentration AS program_concentration	,
    Programs.degree AS program_degree
FROM
    Users
LEFT JOIN
    User_Current_Cities ON Users.user_id = User_Current_Cities.user_id
JOIN 
    Cities currC ON User_Current_Cities.current_city_id = currC.city_id
LEFT JOIN
    User_Hometown_Cities ON Users.user_id = User_Hometown_Cities.user_id
JOIN
    Cities homeC ON User_Hometown_Cities.hometown_city_id = homeC.city_id
LEFT JOIN
    Education ON Users.user_id = Education.user_id
LEFT JOIN
    Programs ON Education.program_id = Programs.program_id;


-- Create View_Are_Friends
CREATE VIEW View_Are_Friends AS
SELECT
    user1_id,
    user2_id
FROM
    Friends;

-- Create View_Photo_Information
CREATE VIEW View_Photo_Information AS
SELECT
    Albums.album_id,
    Albums.album_owner_id,
    Albums.cover_photo_id,
    Albums.album_name,
    Albums.album_created_time,
    Albums.album_modified_time,
    Albums.album_link,
    Albums.album_visibility,
    Photos.photo_id,
    Photos.photo_caption,
    Photos.photo_created_time,
    Photos.photo_modified_time,
    Photos.photo_link
FROM
    Photos
JOIN
    Albums ON Photos.album_id = Albums.album_id;


-- Create View_Event_Information
CREATE VIEW View_Event_Information AS
SELECT
    event_id,
    event_creator_id,
    event_name,
    event_tagline,
    event_description,
    event_host,
    event_type,
    event_subtype,
    event_address,
    Cities.city_name AS event_city,
    Cities.state_name AS event_state,
    Cities.country_name AS event_country,
    event_start_time,
    event_end_time
FROM
    User_Events
JOIN
    Cities ON User_Events.event_city_id = Cities.city_id;


-- Create View_Tag_Information
CREATE VIEW View_Tag_Information AS
SELECT
    tag_photo_id AS photo_id,
    tag_subject_id,
    tag_created_time,
    tag_x AS tag_x_coordinate,
    tag_y AS tag_y_coordinate
FROM
    Tags;