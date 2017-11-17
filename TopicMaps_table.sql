create table if not exists encode.topicmaps(
topicmap_id int not null auto_increment,
title varchar(20),
description varchar(50),
version varchar(20),
primary key(topicmap_id));