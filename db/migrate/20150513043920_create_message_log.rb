class CreateMessageLog < ActiveRecord::Migration
  def self.up
    execute("create schema logs;")
    execute("create table logs.message_types(id smallint primary key, name varchar unique not null);")
    execute("insert into logs.message_types values(1,'Email');")
    execute("create table logs.messages_log(
  id bigserial primary key,
  student_id bigint not null,
  batch_id bigint not null,
  type_id smallint not null,
  destination varchar not null,
  subject varchar,
  message varchar);")
    execute("ALTER TABLE public.versions set SCHEMA logs")

    execute("create table public.faculties(
    id smallserial primary key,
    name varchar unique not null,
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone
);

create table public.hostels(
    id smallserial primary key,
    name varchar unique not null,
    created_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone
);

alter table student_groups add faculty_id smallint references public.faculties(id);
alter table public.students add hostel_id smallint references public.hostels(id),
add hostel_room varchar,
add parents_address varchar,
add parents_phone varchar;

")


  end

  def self.down
    execute "alter table public.student_groups drop column faculty_id"
    drop_table "public.faculties"

    execute "alter table public.students
  drop column hostel_id,
  drop column hostel_room,
  drop column parents_phone,
  drop column parents_address
;"
    drop_table "public.hostels"

    execute("ALTER TABLE logs.versions set SCHEMA public")
    drop_table "logs.messages_log"
    drop_table "logs.message_types"
    execute "drop schema logs"

  end

end

