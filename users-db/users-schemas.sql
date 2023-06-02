CREATE TABLE IF NOT EXISTS "users" (
	"id"	INTEGER NOT NULL,
	"username"	TEXT NOT NULL UNIQUE,
	"password"	TEXT NOT NULL,
	"admin"	INTEGER NOT NULL CHECK("admin" IN (0, 1)),
	PRIMARY KEY("id")
);

