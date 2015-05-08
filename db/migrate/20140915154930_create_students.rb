class CreateStudents < ActiveRecord::Migration
  def self.up
    execute("create table student_courses(
      id serial primary key,
      name varchar not null unique
      );"
    )
    execute("insert into student_courses(name) values('1');")
    execute("insert into student_courses(name) values('2');")
    execute("insert into student_courses(name) values('3');")
    execute("insert into student_courses(name) values('4');")
    execute("insert into student_courses(name) values('5');")
    execute("insert into student_courses(name) values('6');")

    execute("create table student_roles(
      id serial primary key,
      name varchar not null unique
      );"
    )

    execute("insert into student_roles(name) values('Староста');")

     execute("create table student_groups(
      id serial primary key,
      name varchar not null unique,
      course_id integer not null references student_courses(id)
      );")

      execute("create table students(
id bigserial primary key,
first_name varchar not null,
last_name varchar not null,
middle_name varchar,
created_at timestamp with time zone,
updated_at timestamp with time zone,
ticket_num varchar,
login varchar unique,
password varchar,
group_id integer references student_groups(id),
phone varchar,
email varchar,
role_id integer[]
);")

    execute("create table student_uploaded_documents(
id bigserial primary key,
name varchar not null,
filename varchar not null,
data bytea,
created_at timestamp with time zone,
updated_at timestamp with time zone,
student_id bigint not null references students(id)
);")

  end

  def self.down
    drop_table "student_uploaded_documents"
    drop_table "students"
    drop_table "student_groups"
    drop_table "student_roles"
    drop_table "student_courses"
  end
end
