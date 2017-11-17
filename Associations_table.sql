create table if not exists encode.associations(
association_id int,
name varchar(20),
description varchar(50),
scope_id int,
primary key(association_id),
foreign key(scope_id) references encode.scopes(scope_id));