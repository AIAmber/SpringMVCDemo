-- Create table blog_user
create table blog_user
(
  id        number(11) not null,
  username  varchar2(45) not null,
  password  varchar2(45) not null,
  firstname varchar2(45),
  lastname  varchar2(45),
  CONSTRAINT pk_blog_user primary key(id) -- PK
);

-- Create table blog_content
Create table blog_content
(
  id		number(11) not null,
  title		varchar2(45) not null,
  content 	varchar2(255),
  user_id	number(11) not null,
  pub_date	date not null,
  CONSTRAINT pk_blog_content primary key(id) --PK
);

-- FK
alter table blog_content
  add CONSTRAINT fk_bc_user_id FOREIGN KEY(user_id) REFERENCES blog_user(id);

-- bloguser_id_seq
create sequence bloguser_id_seq
	increment by 1	--everytime, add 1
	start with 1	--count ++ from 1
	nomaxvalue		--no max
	nocycle			--add all time  
	nocache			--no cache
;
/

-- bloguser_id_seq
create sequence blogcontent_id_seq    
	increment by 1	--everytime, add 1  
	start with 1	--count ++ from 1  
	nomaxvalue		--no max  
	nocycle			--add all time  
	nocache			--no cache
;
/

-- trigger, bloguser_id_trigger 
-- CREATE OR REPLACE TRIGGER bloguser_trigger
CREATE TRIGGER bloguser_trigger
	BEFORE INSERT ON blog_user  
	FOR EACH ROW  
	WHEN (new.ID is null)	--Only when tid = null, start the trigger and create tid
begin  
	select bloguser_id_seq.nextval into :new.ID from sys.dual;
end;
/

-- trigger, blogcontent_trigger  
CREATE OR REPLACE TRIGGER blogcontent_id_trigger  
	BEFORE INSERT ON blog_content  
	FOR EACH ROW  
	WHEN (new.ID is null)	--Only when tid = null, start the trigger and create tid
begin  
	select bloguser_id_seq.nextval into :new.ID from sys.dual;  
end;
/

-- ADD DATA
INSERT into blog_user(username, password) values ('sparknet', 'Abcd1234');

commit;