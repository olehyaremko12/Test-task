CREATE TABLE `schema_migrations` (`filename` varchar(255) NOT NULL PRIMARY KEY);
CREATE TABLE `messages` (`id` integer NOT NULL PRIMARY KEY AUTOINCREMENT, `text` varchar(255) NOT NULL, `safelink` varchar(255) NOT NULL, `destroy_after_1_visit` integer DEFAULT (2), `destroy_after_1_hour` integer DEFAULT (2), `destroy_after_hours` integer DEFAULT (1), `iv` varchar(255) NOT NULL, `password` varchar(255) NOT NULL, `created_at` timestamp NOT NULL, `updated_at` timestamp NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
