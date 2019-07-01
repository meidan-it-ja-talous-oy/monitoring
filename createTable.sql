create database monitoring;
create user monitor with encrypted password 'monitor';

CREATE TABLE IF NOT EXISTS monitoring_entry (
	id serial,
	timestamp timestamp,
	host text,
	url text,
	response numeric(9,2),
	loading_time numeric(9,2),
	keyword_found text,
	PRIMARY KEY( id )
);

grant all privileges on database monitoring to monitor;
