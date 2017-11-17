create table if not exists encode.users(
user_id int not null auto_increment,
username varchar(15),
email varchar(50),
password varchar(20),
role varchar(10),
regDate timestamp(4),
isActive tinyint(4),
usercol varchar(45)
primary key(user_id, username));