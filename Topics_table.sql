create table if not exists encode.topics(
topic_id int,
topicMap_id int,
name varchar(20),
subjectLocator varchar(50),
subjectIdentifier varchar(50),
scope_id int,
occurrence_id int,
primary key(topic_id, topicMap_id),
foreign key(scope_id) references encode.scopes(scope_id),
foreign key(occurrence_id) references encode.occurrences(occurrence_id));