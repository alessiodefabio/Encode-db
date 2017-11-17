create table if not exists encode.topictypes(
topicType_id int not null auto_increment,
name varchar(15),
description varchar(50),
user_id int,
primary key(topicType_id),
foreign key(user_id) references encode.users(id));