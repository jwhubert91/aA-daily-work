PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body VARCHAR(255) NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    author_id INTEGER NOT NULL,
    body VARCHAR(255) NOT NULL,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    liked_by_user_id INTEGER,
    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (liked_by_user_id) REFERENCES users(id)
);

/*

        NOTE:

        You will probably also want to write some INSERT statements at the bottom 
        of your import_db.sql file, so that you have some data in each table to
        play with. We call this 'seeding the database'. 

*/

/* INSERT data into users table */
INSERT INTO
    users (fname, lname)
VALUES
    ('Santa', 'Claus'),
    ('Stewart','Butterfield'),
    ('Elizabeth','Holmes'),
    ('Sheryl','Sandberg');


/* INSERT data into questions table */
INSERT INTO
    questions (title,body,author_id)
VALUES
    ('Do we really have to learn flexbox despite CSS Grid"s superiority?','JW because I wanted to do front end',
    (SELECT id FROM users WHERE fname = 'Sheryl')),
    ('Do we use our final projects in the job search?',
    'I want to work at a chat app company so wanted to make sure I could do a relevant final project',
    (SELECT id FROM users WHERE fname = 'Stewart')),
    ('Re: Harvesting','Can I harvest the blood of my classmates for a startup I"m working on?',
    (SELECT id FROM users WHERE fname = 'Elizabeth')),
    ('Recursion','Is recursion really used frequently on the job?',
    (SELECT id FROM users WHERE fname = 'Sheryl'));


/* INSERT data into users table */
INSERT INTO
    question_follows(question_id,user_id)
VALUES
    ((SELECT id FROM questions WHERE id = 1), (SELECT id FROM users WHERE id = 4)),
    ((SELECT id FROM questions WHERE id = 2), (SELECT id FROM users WHERE id = 3)),
    ((SELECT id FROM questions WHERE id = 3), (SELECT id FROM users WHERE id = 2)),
    ((SELECT id FROM questions WHERE id = 4), (SELECT id FROM users WHERE id = 1)),
    ((SELECT id FROM questions WHERE id = 4), (SELECT id FROM users WHERE id = 2));


/* INSERT data into replies table */
INSERT INTO
    replies (question_id,parent_reply_id,author_id,body)
VALUES
    (3,
    (NULL),
    (SELECT id FROM users WHERE fname = 'Santa'),
    ('Ho ho ho! I wonder about this too.')),
    (4,
    (NULL),
    (SELECT id FROM users WHERE fname = 'Elizabeth'),
    ('Recursion is used regularly in prod for the creation of infinite loops.'));


/* INSERT replies to replies table */
INSERT INTO
    replies (question_id,parent_reply_id,author_id,body)
VALUES
    (3,
    1,
    (SELECT id FROM users WHERE fname = 'Stewart'),
    ('Sounds like a PR nightmare.'));



/* INSERT data into likes table */
INSERT INTO
    question_likes (question_id,liked_by_user_id)
VALUES
    ((SELECT id FROM questions WHERE id = 1),
    (1)),
    ((SELECT id FROM questions WHERE id = 2),
    (4)),
    ((SELECT id FROM questions WHERE id = 3),
    (2)),
    ((SELECT id FROM questions WHERE id = 4),
    (3));




