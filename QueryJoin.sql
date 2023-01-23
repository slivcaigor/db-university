-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT students.* 
FROM students 
JOIN degrees 
ON students.degree_id = degrees.id 
WHERE degrees.name 
LIKE 'Corso di Laurea in Economia';

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT *
FROM departments
JOIN degrees 
ON departments.id = degrees.department_id
WHERE departments.name 
LIKE 'Dipartimento di Neuroscienze' 
AND degrees.level 
LIKE 'magistrale'

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT courses.name
FROM teachers
JOIN course_teacher 
ON teachers.id = course_teacher.teacher_id
JOIN courses 
ON course_teacher.course_id = courses.id
WHERE teachers.id = 44

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT students.surname, students.name, degrees.name, departments.name
FROM students
JOIN degrees 
ON students.degree_id = degrees.id
JOIN departments 
ON degrees.department_id = departments.id
ORDER BY students.surname, students.name

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT degrees.name, courses.name, teachers.name, teachers.surname
FROM degrees
JOIN courses 
ON degrees.id = courses.degree_id
JOIN course_teacher 
ON courses.id = course_teacher.course_id
JOIN teachers 
ON course_teacher.teacher_id = teachers.id

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT 
DISTINCT teachers.name, teachers.surname
FROM teachers
JOIN course_teacher ON teachers.id = course_teacher.teacher_id
JOIN courses ON course_teacher.course_id = courses.id
JOIN degrees ON courses.degree_id = degrees.id
JOIN departments ON degrees.department_id = departments.id
WHERE departments.name LIKE 'Dipartimento di Matematica'

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami

SELECT students.name, courses.name, COUNT(DISTINCT exams.id)
FROM students
JOIN exam_student ON students.id = exam_student.student_id
JOIN exams ON exam_student.exam_id = exams.id
JOIN courses ON exams.course_id = courses.id
GROUP BY students.name, courses.name
HAVING MAX(exam_student.vote) >= 18
