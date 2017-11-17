create table if not exists encode.scopes(
scope_id int,
name varchar(20),
effort_id int,
description varchar(50),
variantName_id int,
primary key(scope_id),
foreign key(effort_id) references encode.efforts(effort_id),
foreign key(variantName_id) references encode.variantname(variantName_id));