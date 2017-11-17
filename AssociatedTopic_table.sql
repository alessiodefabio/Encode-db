create table if not exists encode.associatedtopic(
topic_id_in int,
topic_id_out int,
association_id int,
primary key(topic_id_id, topic_id_out, association_id),
foreign key(topic_id_id) references encode.topics(topic_id),
foreign key(association_id) references encode.associations(association_id));