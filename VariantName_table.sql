create table if not exists encode.variantname(
variantname_id int not null auto_increment,
topic_id int,
variantname varchar(20),
primary key(variantname_id),
foreign key (topic_id) references encode.topics(topic_id));
