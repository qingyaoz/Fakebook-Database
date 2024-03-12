-- Drop Tags Table
DROP TABLE Tags;

-- Remove the foreign key constraint first if it's not automatically dropped with the table
ALTER TABLE Albums DROP CONSTRAINT fk_albums_cover_photo_id;
ALTER TABLE Photos DROP CONSTRAINT fk_photos_album_id;

-- Drop Photos Table
DROP TABLE Photos;

-- Drop Albums Table
DROP TABLE Albums;

-- Drop Participants Table
DROP TABLE Participants;

-- Drop User_Events Table
DROP TABLE User_Events;

-- Drop Education Table
DROP TABLE Education;

-- Drop Programs Related
DROP TRIGGER Create_Prog_Id;
DROP SEQUENCE Seq_Prog_Id;
DROP TABLE Programs;

-- Drop Messages Table
DROP TABLE Messages;

-- Drop User_Hometown_Cities Table
DROP TABLE User_Hometown_Cities;

-- Drop User_Current_Cities Table
DROP TABLE User_Current_Cities;

-- Drop Cities Related
DROP TRIGGER Create_City_Id;
DROP SEQUENCE Seq_City_Id;
DROP TABLE Cities;

-- Drop Friends Table
-- Remove the trigger first if it's not automatically dropped with the table
DROP TRIGGER Order_Friend_Pairs;
DROP TABLE Friends;

-- Drop Users Table
DROP TABLE Users;
