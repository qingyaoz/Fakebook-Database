-- User Table
CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY,
    first_name VARCHAR2(100) NOT NUll,
    last_name VARCHAR2(100) NOT NUll,
    year_of_birth INTEGER,
    month_of_birth INTEGER,
    day_of_birth INTEGER,
    gender VARCHAR2(100)
);


-- Friends Table
CREATE TABLE Friends (
    user1_id INTEGER NOT NULL,
    user2_id INTEGER NOT NULL,
    PRIMARY KEY (user1_id, user2_id),
    FOREIGN KEY (user1_id) REFERENCES Users(user_id),
    FOREIGN KEY (user2_id) REFERENCES Users(user_id)
);


-- Trigger for Friends
CREATE TRIGGER Order_Friend_Pairs
    BEFORE INSERT ON Friends
    FOR EACH ROW
        DECLARE temp INTEGER;
        BEGIN
            IF :NEW.user1_id > :NEW.user2_id THEN
                temp := :NEW.user2_id;
                :NEW.user2_id := :NEW.user1_id;
                :NEW.user1_id := temp;
            END IF;
        END;
/


-- Cities Table
CREATE TABLE Cities (
    city_id INTEGER PRIMARY KEY,
    city_name VARCHAR2(100) NOT NULL,
    state_name VARCHAR2(100) NOT NULL,
    country_name VARCHAR2(100) NOT NULL,
    UNIQUE (city_name, state_name, country_name)
);

CREATE SEQUENCE Seq_City_Id
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER Create_City_Id
    BEFORE INSERT ON Cities
    FOR EACH ROW
        BEGIN
            SELECT Seq_City_Id.NEXTVAL INTO :NEW.city_id FROM DUAL;
        END;
/


-- User_Current_Cities Table
CREATE TABLE User_Current_Cities (
    user_id INTEGER PRIMARY KEY,
    current_city_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (current_city_id) REFERENCES Cities(city_id)
);


-- User_Hometown_Cities Table
CREATE TABLE User_Hometown_Cities (
    user_id INTEGER PRIMARY KEY,
    hometown_city_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (hometown_city_id) REFERENCES Cities(city_id)
);


-- Messages Table
CREATE TABLE Messages (
    message_id INTEGER PRIMARY KEY,
    sender_id INTEGER NOT NULL,
    receiver_id INTEGER NOT NULL,
    message_content VARCHAR2(2000) NOT NULL,
    sent_time TIMESTAMP NOT NULL,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);


-- Programs Table
CREATE TABLE Programs (
    program_id INTEGER PRIMARY KEY,
    institution VARCHAR2(100) NOT NULL,
    concentration VARCHAR2(100) NOT NULL,
    degree VARCHAR2(100) NOT NULL,
    UNIQUE (institution, concentration, degree)
);

CREATE SEQUENCE Seq_Prog_Id
    START WITH 1
    INCREMENT BY 1;

CREATE TRIGGER Create_Prog_Id
    BEFORE INSERT ON Programs
    FOR EACH ROW
        BEGIN
            SELECT Seq_Prog_Id.NEXTVAL INTO :NEW.program_id FROM DUAL;
        END;
/


-- Education Table
CREATE TABLE Education (
    user_id INTEGER NOT NULL,
    program_id INTEGER NOT NULL,
    program_year INTEGER NOT NULL,
    PRIMARY KEY (user_id, program_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (program_id) REFERENCES Programs(program_id)
);


-- User_Events Table
CREATE TABLE User_Events (
    event_id INTEGER PRIMARY KEY,
    event_creator_id INTEGER NOT NULL,
    FOREIGN KEY (event_creator_id) REFERENCES Users(user_id),
    event_name VARCHAR2(100) NOT NULL,
    event_tagline VARCHAR2(100),
    event_description VARCHAR2(100),
    event_host VARCHAR2(100),
    event_type VARCHAR2(100),
    event_subtype VARCHAR2(100),
    event_address VARCHAR2(2000),
    event_city_id INTEGER NOT NULL,
    FOREIGN KEY (event_city_id) REFERENCES Cities(city_id),
    event_start_time TIMESTAMP,
    event_end_time TIMESTAMP
);


-- Participants Table
CREATE TABLE Participants (
    event_id INTEGER NOT NULL,
    FOREIGN KEY (event_id) REFERENCES User_Events(event_id),
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    PRIMARY KEY (event_id, user_id),
    -- Not Sure
    confirmation VARCHAR2(100) CHECK (confirmation IN ('Attending', 'Unsure', 'Declines', 'Not_Replied')) NOT NULL
);


-- Albums Table
CREATE TABLE Albums (
    album_id INTEGER PRIMARY KEY,
    album_owner_id INTEGER NOT NULL,
    FOREIGN KEY (album_owner_id) REFERENCES Users(user_id),
    album_name VARCHAR2(100) NOT NULL,
    album_created_time TIMESTAMP NOT NULL,
    album_modified_time TIMESTAMP,
    album_link VARCHAR2(2000) NOT NULL,
    album_visibility VARCHAR2(100) CHECK (album_visibility IN ('Everyone', 'Friends', 'Friends_Of_Friends', 'Myself')) NOT NULL,
    cover_photo_id INTEGER NOT NULL
    -- MARK: circular dep
);


-- Photos Table
CREATE TABLE Photos (
    photo_id INTEGER PRIMARY KEY,
    album_id INTEGER NOT NULL,
    -- MARK: circular dep
    photo_caption VARCHAR2(2000),
    photo_created_time TIMESTAMP NOT NULL,
    photo_modified_time TIMESTAMP,
    photo_link VARCHAR2(2000) NOT NULL
);


-- Add foreign key constraint to Photos table
ALTER TABLE Photos
ADD CONSTRAINT fk_photos_album_id
FOREIGN KEY (album_id) REFERENCES Albums(album_id)
INITIALLY DEFERRED DEFERRABLE;

-- Add foreign key constraint to Albums table
ALTER TABLE Albums
ADD CONSTRAINT fk_albums_cover_photo_id
FOREIGN KEY (cover_photo_id) REFERENCES Photos(photo_id)
INITIALLY DEFERRED DEFERRABLE;


-- Tags Table
CREATE TABLE Tags (
    tag_photo_id INTEGER NOT NULL,
    FOREIGN KEY (tag_photo_id) REFERENCES Photos(photo_id),
    tag_subject_id INTEGER NOT NULL,
    FOREIGN KEY (tag_subject_id) REFERENCES Users(user_id),
    PRIMARY KEY (tag_photo_id, tag_subject_id),
    tag_created_time TIMESTAMP NOT NULL,
    tag_x NUMBER NOT NULL,
    tag_y NUMBER NOT NULL
);
