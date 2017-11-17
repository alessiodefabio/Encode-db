CREATE TABLE IF NOT EXIXTS encode.learningpath(
learningpath_id int NOT NULL AUTO_INCREMENT,
user_id int,
learningpath JSON,
PRIMARY KEY(learningpath_id),
FOREIGN KEY(user_id) REFERENCES encode.users(user_id));