create table if not exists encode.mapping(
user_id int,
topicMap_id int,
creationDate TimeStamp(4),
lastModifyDate TimeStamp(4)
primary key(user_id, topicMap_id),
foreign key(user_id) references encode.users(user_id),
foreign key(topicMap_id) references encode.topicmaps(topicMap_id));