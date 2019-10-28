# whiteboarding exercises


# questions 1
# two tables: employees, departments
# employees can belong to one department
# find all employees names that are in that department

def employees_of_dept(dept)
<<-SQL
    SELECT employees.name
    FROM employees
    JOIN departments ON employees.department_id = departments.id
    WHERE departments.name = ?
SQL
end

def too_cool_for_school
<<-SQL
    SELECT employees.name
    FROM employees
    WHERE employees.department_id IS NULL
SQL
end


# question 2

# == Schema Information
#
# Table name: physicians
#
#  id   :integer          not null, primary key
#  name :string           not null


# Table name: appointments
#
#  id   :integer           not null, primary key
#  physician_id :integer   not null
#  patient_id :integer     not null


# Table name: patients
#
#  id   :integer           not null, primary key
#  name :string            not null
#  primary_physician_id :integer

# has_many through: for general_patients, primary_patient_appointments

class Physician << ApplicationRecord

    has_many :appointments,
        class_name: :Appointment,
        primary_key: :id,
        foreign_key: :physician_id

    has_many :primary_patients,
        class_name: :Patient,
        primary_key: :id,
        foreign_key: :primary_physician_id

    has_many :primary_patient_appointments,
        through: :primary_patients,
        source: :appointments

    has_many :general_patients,
        through: :appointments,
        source: :patient

end

class Appointment << ApplicationRecord

    belongs_to :physician,
        class_name: :Physician,
        primary_key: :id,
        foreign_key: :physician_id

    belongs_to :patient,
        class_name: :Patient,
        primary_key: :id,
        foreign_key: :patient_id

end

class Patient << ApplicationRecord

    has_many :appointments,
        class_name: :Patient,
        primary_key: :id,
        foreign_key: :patient_id

    belongs_to :primary_physician,
        class_name: :Physician,
        primary_key: :id,
        foreign_key: :primary_physician_id

end

# 