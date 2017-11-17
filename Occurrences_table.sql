create table if not exists encode.occurrences(
occurrence_id int not null auto_increment,
topic_id int,
data_value int,
scope_id int,
name varchar(20),
data_reference varchar(50),
primary key (occurrence_id, topic_id),
foreign key(topic_id) references encode.topics(topic_id),
foreign key(scope_id) references encode.scopes(scope_id));
