create table if not exists encode.istanceof(
topic_id int,
topicType_id int,
primary key(topic_id, topicType_id),
foreign key(topic_id) references encode.topics(id),
foreign key(topicType_id) references encode.topicTypes(id));