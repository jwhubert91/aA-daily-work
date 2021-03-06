require 'sqlite3'
require 'singleton'
require 'byebug'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
    attr_accessor :id, :fname, :lname

    def self.find_by_id(id_num)
      user = QuestionsDatabase.instance.execute(<<-SQL, id_num)
        SELECT
            *
        FROM
            users
        WHERE
            id = ?
        SQL
        return nil unless user.length > 0

        User.new(user.first) # user is stored in an array
    end

    def self.find_by_name(fname,lname)
      user = QuestionsDatabase.instance.execute(<<-SQL, fname,lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND
        lname = ?
      SQL
      return nil unless user.length > 0

      User.new(user.first) # user is stored in an array
    end

    def self.all
      users = QuestionsDatabase.instance.execute(<<-SQL)
        SELECT
            *
        FROM
            users
        SQL

        all_users_arr = users.map do |user|
            User.new(user)
        end
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        user_id = self.id
        Question.find_by_author_id(user_id)
    end
end

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(id_num)
      question = QuestionsDatabase.instance.execute(<<-SQL, id_num)
        SELECT
            *
        FROM
            questions
        WHERE
            id = ?
        SQL
        return nil unless question.length > 0

        Question.new(question.first) # question is stored in an array
    end

    def self.find_by_author_id(author_id)
      question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT
            *
        FROM
            questions
        WHERE
            author_id = ?
        SQL
        return nil unless question.length > 0

        Question.new(question.first)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def self.all
      questions = QuestionsDatabase.instance.execute(<<-SQL)
        SELECT
            *
        FROM
            questions
        SQL

        all_questions_arr = questions.map do |question|
            Question.new(question)
        end
    end
    
end

class QuestionFollow
    attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id_num)
      follow = QuestionsDatabase.instance.execute(<<-SQL, id_num)
        SELECT
            *
        FROM
            question_follows
        WHERE
            id = ?
        SQL
        return nil unless follow.length > 0

        QuestionFollow.new(follow.first) # follow is stored in an array
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @user_id = options['user_id']
    end
end

class Reply
    attr_accessor :id, :question_id, :parent_reply_id, :author_id, :body

    def self.find_by_id(id_num)
      reply = QuestionsDatabase.instance.execute(<<-SQL, id_num)
        SELECT
            *
        FROM
            replies
        WHERE
            id = ?
        SQL
        return nil unless reply.length > 0

        Reply.new(reply.first) # reply is stored in an array
    end

    def self.find_by_user_id(user_id)
      reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
            *
        FROM
            replies
        WHERE
            author_id = ?
        SQL
        return nil unless reply.length > 0

        Reply.new(reply.first) # reply is stored in an array
    end

    # return all replies with a given question id
    def self.find_by_question_id(question_id)
      replies_by_question = QuestionsDatabase.instance.execute(<<-SQL,question_id)
        SELECT
            *
        FROM
            replies
        WHERE
            question_id = ?
        SQL
        p replies_by_question
        replies_by_question.map do |reply|
            Reply.new(reply)
        end
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @author_id = options['author_id']
        @body = options['body']
    end
end

class QuestionLike
    attr_accessor :id, :question_id, :liked_by_user_id

    def self.find_by_id(id_num)
      question_like = QuestionsDatabase.instance.execute(<<-SQL, id_num)
        SELECT
            *
        FROM
            question_likes
        WHERE
            id = ?
        SQL
        return nil unless question_like.length > 0

        QuestionLike.new(question_like.first) # like is stored in an array
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @liked_by_user_id = options['liked_by_user_id']
    end
end
