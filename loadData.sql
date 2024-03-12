-- Insert Users
INSERT INTO Users (user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender)
SELECT DISTINCT user_id, first_name, last_name, year_of_birth, month_of_birth, day_of_birth, gender
-- Since user_id is unique, different id + same attr will also be unique.
-- this allow attr to be the same for different user
FROM project1.Public_User_Information;


-- Insert Friends
INSERT INTO Friends (user1_id, user2_id)
SELECT DISTINCT LEAST(user1_id, user2_id), GREATEST(user1_id, user2_id)
FROM project1.Public_Are_Friends;


-- Insert Cities
INSERT INTO Cities (city_name, state_name, country_name)
SELECT DISTINCT city_name, state_name, country_name
FROM (
    SELECT current_city AS city_name, current_state AS state_name, current_country AS country_name
    FROM project1.Public_User_Information
    UNION
    SELECT hometown_city AS city_name, hometown_state AS state_name, hometown_country AS country_name
    FROM project1.Public_User_Information
);


-- Insert User_Current_Cities
INSERT INTO User_Current_Cities (user_id, current_city_id)
SELECT DISTINCT user_id, city_id
FROM project1.Public_User_Information
JOIN Cities ON (Public_User_Information.current_city = Cities.city_name AND 
                Public_User_Information.current_state = Cities.state_name AND
                Public_User_Information.current_country = Cities.country_name);


-- Insert User_Hometown_Cities
INSERT INTO User_Hometown_Cities (user_id, hometown_city_id)
SELECT DISTINCT user_id, city_id
FROM project1.Public_User_Information
JOIN Cities ON (Public_User_Information.hometown_city = Cities.city_name AND 
                Public_User_Information.hometown_state = Cities.state_name AND
                Public_User_Information.hometown_country = Cities.country_name);


-- Insert Programs
INSERT INTO Programs (institution, concentration, degree)
SELECT DISTINCT institution_name, program_concentration, program_degree
FROM project1.Public_User_Information
WHERE institution_name IS NOT NULL;
-- Since all 3 attr will not be NULL if one of them are not NULL


-- Insert Education
INSERT INTO Education (user_id, program_id, program_year)
SELECT DISTINCT user_id, program_id, program_year
FROM project1.Public_User_Information
JOIN Programs ON (Public_User_Information.institution_name = Programs.institution AND 
                Public_User_Information.program_concentration = Programs.concentration AND
                Public_User_Information.program_degree = Programs.degree);


-- Insert User_Events
INSERT INTO User_Events (
    event_id, 
    event_creator_id, 
    event_name, 
    event_tagline, 
    event_description, 
    event_host, 
    event_type, 
    event_subtype, 
    event_address, 
    event_city_id, 
    event_start_time, 
    event_end_time
)
SELECT DISTINCT 
    event_id, 
    event_creator_id, 
    event_name, 
    event_tagline, 
    event_description, 
    event_host, 
    event_type, 
    event_subtype, 
    event_address, 
    city_id, 
    event_start_time, 
    event_end_time
FROM 
    project1.Public_Event_Information
JOIN 
    Cities ON (
        Public_Event_Information.event_city = Cities.city_name AND 
        Public_Event_Information.event_state = Cities.state_name AND
        Public_Event_Information.event_country = Cities.country_name);


-- Turn Off Autocommit for Circular Dependencies
SET AUTOCOMMIT OFF;

-- Insert Albums
INSERT INTO Albums (
    album_id,
    album_owner_id,
    album_name,
    album_created_time,
    album_modified_time,
    album_link,
    album_visibility,
    cover_photo_id
)
SELECT DISTINCT
    album_id,
    owner_id AS album_owner_id,
    album_name,
    album_created_time,
    album_modified_time,
    album_link,
    /* CASE 
        WHEN album_visibility = 'Everyone' THEN 'Everyone'
        WHEN album_visibility = 'Friends' THEN 'Friends'
        WHEN album_visibility = 'Friends_Of_Friends' THEN 'Friends_Of_Friends'
        WHEN album_visibility = 'Myself' THEN 'Myself'
        ELSE NULL
    END AS album_visibility, */
    album_visibility,
    cover_photo_id
FROM project1.Public_Photo_Information;

-- Insert Photos
INSERT INTO Photos (photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link)
SELECT DISTINCT photo_id, album_id, photo_caption, photo_created_time, photo_modified_time, photo_link
FROM project1.Public_Photo_Information;

-- Turn On Autocommit
COMMIT;
SET AUTOCOMMIT ON;


-- Tags
INSERT INTO Tags (
    tag_photo_id,
    tag_subject_id,
    tag_created_time,
    tag_x,
    tag_y)
SELECT DISTINCT 
    photo_id AS tag_photo_id,
    tag_subject_id,
    tag_created_time, 
    tag_x_coordinate AS tag_x,
    tag_y_coordinate AS tag_y
FROM
    project1.Public_Tag_Information;