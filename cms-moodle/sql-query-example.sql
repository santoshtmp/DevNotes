-- http://mahakala.lesc.uec.ac.jp/mahoodle/moodle/docs/33/en/Main_Page/Managing_a_Moodle_site/Site-wide_reports/ad-hoc_contributed_reports.html
-- https://moodleschema.zoola.io/tables/quiz.html

-- https://docs.moodle.org/311/en/ad-hoc_contributed_reports 

-- define('CONTEXT_SYSTEM', 10);
-- define('CONTEXT_USER', 30);
-- define('CONTEXT_COURSECAT', 40);
-- define('CONTEXT_COURSE', 50);
-- define('CONTEXT_MODULE', 70);
-- define('CONTEXT_BLOCK', 80);



-- Quiz-Total-By-Subject
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Grade Course',
	COUNT(q.id) AS 'TOTAL-Quiz'
FROM prefix_course_modules cm
JOIN prefix_course c ON c.id=cm.course
JOIN prefix_quiz q ON q.id=cm.instance 
WHERE cm.deletioninprogress=0 AND cm.module=18 AND q.name<>'' AND c.id<>12 AND c.id<>108
GROUP BY c.id
ORDER BY COUNT(c.id) DESC

-- Quiz-Total-By-Grade
 SELECT
    cc.name AS 'Grade Name',
    COUNT(q.id) AS 'TOTAL-Quiz'
FROM prefix_course_modules cm
JOIN prefix_course c ON c.id=cm.course
JOIN prefix_course_categories cc ON cc.id=c.category
JOIN prefix_quiz q ON q.id=cm.instance 
WHERE cm.deletioninprogress=0 AND cm.module=18 AND q.name<>''  AND c.id<>12 AND cc.id<>16
GROUP BY cc.id
ORDER BY COUNT(cc.id) DESC

-- h5p-total-by-subject
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Grade Course',
	COUNT(hvp.id) AS 'TOTAL-hvp'
FROM prefix_course_modules cm
JOIN prefix_course c ON c.id=cm.course
JOIN prefix_hvp hvp ON hvp.id=cm.instance 
WHERE cm.deletioninprogress=0 AND cm.module=26 AND hvp.name<>'' AND c.id<>12 AND c.id<>108
GROUP BY c.id
ORDER BY COUNT(c.id) DESC

-- h5p-total-by-Grade
SELECT
     cc.name AS 'Grade Name',
	COUNT(hvp.id) AS 'TOTAL-hvp'
FROM prefix_course_modules cm
JOIN prefix_course c ON c.id=cm.course
JOIN prefix_course_categories cc ON cc.id=c.category
JOIN prefix_hvp hvp ON hvp.id=cm.instance 
WHERE cm.deletioninprogress=0 AND cm.module=26 AND hvp.name<>'' AND c.id<>12 AND cc.id<>16
GROUP BY cc.id
ORDER BY COUNT(cc.id) DESC

-- Game-Total-By-Subjects
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Grade Course',
	COUNT(r.id) AS 'TOTAL-Games'
FROM prefix_course_modules cm
JOIN prefix_course c ON c.id=cm.course
JOIN prefix_resource r ON r.id=cm.instance 
WHERE cm.deletioninprogress=0 AND cm.module=19 AND r.name<>'' AND c.id<>12
GROUP BY c.id
ORDER BY COUNT(c.id) DESC

-- Game-Total-By-Grade
SELECT
    cc.name AS 'Grade Name',
    COUNT(r.id) AS 'TOTAL-Games'
FROM prefix_course_modules cm
JOIN prefix_course c ON c.id=cm.course
JOIN prefix_course_categories cc ON cc.id=c.category
JOIN prefix_resource r ON r.id=cm.instance 
WHERE cm.deletioninprogress=0 AND cm.module=19 AND r.name<>''  AND c.id<>12
GROUP BY cc.id
ORDER BY COUNT(cc.id) DESC

-- Blogs/Articles-Total-By-Grade publish
SELECT
    cc.name AS 'Grade Name',
    COUNT(ps.id) AS 'TOTAL-Articles'
FROM prefix_post ps
JOIN prefix_course c ON c.id=ps.courseid
JOIN prefix_course_categories cc ON cc.id=c.category
WHERE c.id<>12 AND cc.id<>16
GROUP BY cc.id
ORDER BY COUNT(cc.id) DESC

-- Blogs/Articles-Total-By-subject publish
SELECT
   concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Grade Course',
    COUNT(ps.id) AS 'TOTAL-Articles'
FROM prefix_post ps
JOIN prefix_course c ON c.id=ps.courseid
WHERE c.id<>12 AND c.id<>108
GROUP BY c.id
ORDER BY COUNT(c.id) DESC

-- Blogs/Articles name, course-grade, user, publish, tag 

SELECT
	concat('<a target="_new" href="%%WWWROOT%%/blog/index.php?entryid=',ps.id,'">',ps.subject,'</a>') AS 'Article-Name',
   	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Grade-Course',
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',us.id,'">',us.username,'</a>') AS "By-User-Name",
	ps.publishstate AS "State",
	tg.name AS 'Article-Tag'
FROM prefix_post ps
JOIN prefix_course c ON c.id=ps.courseid
JOIN prefix_user us ON us.id=ps.userid
JOIN prefix_tag_instance ti ON ti.itemid=ps.id AND ti.itemtype='post'
JOIN prefix_tag tg ON tg.id=ti.tagid
WHERE c.id<>12 AND c.id<>108
UNION
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/blog/index.php?entryid=',ps.id,'">',ps.subject,'</a>') AS 'Article-Name',
   	'chimpvine site level' AS 'Grade-Course',
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',us.id,'">',us.username,'</a>') AS "By-User-Name",
	ps.publishstate AS "State",
	tg.name AS 'Article-Tag'
FROM prefix_post ps
JOIN prefix_user us ON us.id=ps.userid
JOIN prefix_tag_instance ti ON ti.itemid=ps.id AND ti.itemtype='post'
JOIN prefix_tag tg ON tg.id=ti.tagid
WHERE ps.courseid = 0 
UNION
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/blog/index.php?entryid=',ps.id,'">',ps.subject,'</a>') AS 'Article-Name',
   	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Grade-Course',
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',us.id,'">',us.username,'</a>') AS "By-User-Name",
	ps.publishstate AS "State",
	"------" AS 'Article-Tag'
FROM prefix_post ps
JOIN prefix_course c ON c.id=ps.courseid
JOIN prefix_user us ON us.id=ps.userid
WHERE ps.id NOT IN(
	SELECT
		ps.id as "id"
	FROM prefix_post ps
	JOIN prefix_course c ON c.id=ps.courseid
	JOIN prefix_user us ON us.id=ps.userid
	JOIN prefix_tag_instance ti ON ti.itemid=ps.id AND ti.itemtype='post'
	JOIN prefix_tag tg ON tg.id=ti.tagid
	WHERE c.id<>12 AND c.id<>108
)
UNION
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/blog/index.php?entryid=',ps.id,'">',ps.subject,'</a>') AS 'Article-Name',
   	'chimpvine site level' AS 'Grade-Course',
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',us.id,'">',us.username,'</a>') AS "By-User-Name",
	ps.publishstate AS "State",
	'-----' AS 'Article-Tag'
FROM prefix_post ps
JOIN prefix_user us ON us.id=ps.userid
WHERE ps.courseid = 0  AND ps.id NOT IN(
	SELECT
		ps.id as "id"
	FROM prefix_post ps
	JOIN prefix_user us ON us.id=ps.userid
	JOIN prefix_tag_instance ti ON ti.itemid=ps.id AND ti.itemtype='post'
	JOIN prefix_tag tg ON tg.id=ti.tagid
	WHERE ps.courseid = 0 
)
ORDER BY 'Grade-Course'



$2y$10$S8.YRH8quhBxGjasuWqZru5OBoJNFVfR3GJJWUf85o.ZdsYFz82xq


-- h5p role users
SELECT CONCAT(u.firstname , ' ' , u.lastname) AS 'Full Name',
	u.username 'username',
	u.email 'email'
FROM prefix_user u
JOIN prefix_role_assignments ra ON ra.userid = u.id
WHERE ra.roleid = 20 AND u.suspended = 0 AND u.deleted = 0

-- user company course and grades 
SELECT
	u.username 'username',
	u.email 'email',
	u.department 'school',
	c.fullname 'course',
	gg.finalgrade 'grades'
FROM prefix_user u
JOIN prefix_role_assignments ra ON ra.userid = u.id
JOIN prefix_context ctx ON ctx.id = ra.contextid
JOIN prefix_course c ON ctx.instanceid = c.id
JOIN prefix_grade_items gi ON gi.courseid = c.id
JOIN prefix_grade_grades gg ON gi.id = gg.itemid 
WHERE gi.itemtype='course' AND u.suspended = 0 AND u.deleted = 0 AND u.department='Ama Dablam Academy' AND ctx.contextlevel='50' AND gg.userid=u.id

-- --------------------------------------------------------------


SELECT CONCAT(ls.id,'-',u.id,'-',ls.timecreated) AS new_id,
					u.id AS user_id,
                    u.lastname AS lastname,
                    u.firstname AS firstname,
                    u.email AS email,
                    ls.action As ls_action,
                    ls.other AS ls_other,
                    ls.timecreated AS ls_timecreated,
                    ls.courseid AS ls_courseid,
                    ls.target AS ls_target
            FROM mdl_logstore_standard_log ls
            JOIN mdl_user u ON u.id=ls.userid
            WHERE u.deleted = 0 AND u.suspended = 0 AND ls.courseid<>1 AND (ls.target ='course' OR ls.target='user') AND EXISTS(
            	SELECT ra.userid FROM mdl_role_assignments ra WHERE ra.userid=u.id AND ra.roleid=5)
            ORDER BY ls.timecreated DESC;



-- ---------------------quiz in all subject with teacher and is it graded or not---------------------------------
 SELECT
	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Course Name',
    q.name AS 'Quiz-Name',
	"Yes" AS "Quiz Graded",
	u.email AS 'teacher email',
	concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',u.id,'">',u.firstname,' ',u.lastname,'</a>') AS "Teacher Name"	
FROM prefix_course_modules cm
JOIN prefix_course c ON c.id=cm.course
JOIN prefix_quiz q ON q.id=cm.instance 
JOIN prefix_context ctx ON ctx.instanceid=c.id AND ctx.contextlevel=50
JOIN prefix_role_assignments ra ON ra.contextid=ctx.id 
JOIN prefix_user u ON u.id=ra.userid
WHERE cm.deletioninprogress=0 AND cm.module=18 AND q.name<>'' AND (ra.roleid=3 OR ra.roleid=4) AND 
	EXISTS(
		SELECT qg.id FROM prefix_quiz_grades qg WHERE qg.quiz=q.id 
	)
UNION
 SELECT
	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Course Name',
    q.name AS 'Quiz-Name',
	"No" AS "Quiz Graded",
	u.email AS 'teacher email',
	concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',u.id,'">',u.firstname,' ',u.lastname,'</a>') AS "Teacher Name"	
FROM prefix_course_modules cm
JOIN prefix_course c ON c.id=cm.course
JOIN prefix_quiz q ON q.id=cm.instance 
JOIN prefix_context ctx ON ctx.instanceid=c.id AND ctx.contextlevel=50
JOIN prefix_role_assignments ra ON ra.contextid=ctx.id 
JOIN prefix_user u ON u.id=ra.userid
WHERE cm.deletioninprogress=0 AND cm.module=18 AND q.name<>'' AND (ra.roleid=3 OR ra.roleid=4) AND 
	NOT EXISTS(
		SELECT qg.id FROM prefix_quiz_grades qg WHERE qg.quiz=q.id 
	)


--  -------------------- all blog article list -----------------
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/blog/index.php?entryid=',ps.id,'">',ps.subject,'</a>') AS 'Article-Name',
   	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Grade-Course',
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',us.id,'">',us.username,'</a>') AS "By-User-Name",
	ps.publishstate AS "State",
	tg.name AS 'Article-Tag'
FROM prefix_post ps
JOIN prefix_course c ON c.id=ps.courseid
JOIN prefix_user us ON us.id=ps.userid
JOIN prefix_tag_instance ti ON ti.itemid=ps.id AND ti.itemtype='post'
JOIN prefix_tag tg ON tg.id=ti.tagid
WHERE c.id<>12 AND c.id<>108
UNION
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/blog/index.php?entryid=',ps.id,'">',ps.subject,'</a>') AS 'Article-Name',
   	'chimpvine site ' AS 'Grade-Course',
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',us.id,'">',us.username,'</a>') AS "By-User-Name",
	ps.publishstate AS "State",
	tg.name AS 'Article-Tag'
FROM prefix_post ps
JOIN prefix_user us ON us.id=ps.userid
JOIN prefix_tag_instance ti ON ti.itemid=ps.id AND ti.itemtype='post'
JOIN prefix_tag tg ON tg.id=ti.tagid
WHERE ps.courseid = 0 
UNION
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/blog/index.php?entryid=',ps.id,'">',ps.subject,'</a>') AS 'Article-Name',
   	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Grade-Course',
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',us.id,'">',us.username,'</a>') AS "By-User-Name",
	ps.publishstate AS "State",
	"------" AS 'Article-Tag'
FROM prefix_post ps
JOIN prefix_course c ON c.id=ps.courseid
JOIN prefix_user us ON us.id=ps.userid
WHERE ps.id NOT IN(
	SELECT
		ps.id as "id"
	FROM prefix_post ps
	JOIN prefix_course c ON c.id=ps.courseid
	JOIN prefix_user us ON us.id=ps.userid
	JOIN prefix_tag_instance ti ON ti.itemid=ps.id AND ti.itemtype='post'
	JOIN prefix_tag tg ON tg.id=ti.tagid
	WHERE c.id<>12 AND c.id<>108
)
UNION
SELECT
	concat('<a target="_new" href="%%WWWROOT%%/blog/index.php?entryid=',ps.id,'">',ps.subject,'</a>') AS 'Article-Name',
   	'chimpvine site' AS 'Grade-Course',
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',us.id,'">',us.username,'</a>') AS "By-User-Name",
	ps.publishstate AS "State",
	'-----' AS 'Article-Tag'
FROM prefix_post ps
JOIN prefix_user us ON us.id=ps.userid
WHERE ps.courseid = 0  AND ps.id NOT IN(
	SELECT
		ps.id as "id"
	FROM prefix_post ps
	JOIN prefix_user us ON us.id=ps.userid
	JOIN prefix_tag_instance ti ON ti.itemid=ps.id AND ti.itemtype='post'
	JOIN prefix_tag tg ON tg.id=ti.tagid
	WHERE ps.courseid = 0 
)
ORDER BY 'Grade-Course'
-- -------------------------------------------------------------------

SELECT 
    concat('<a target="_new" href="%%WWWROOT%%/user/profile.php?id=',u.id,'">',u.username,'</a>') AS "Username",
	u.email 'Email',
	concat('<a target="_new" href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Course Name',
	concat('<a target="_new" href="%%WWWROOT%%/mod/quiz/view.php?id=',cm.id,'">',quz.name,'</a>') AS 'Quiz Name',
	MAX(qa.attempt) as "Num of Attempt",
	u.department "School Name"
FROM prefix_user u
JOIN prefix_quiz_attempts qa ON qa.userid = u.id
JOIN prefix_quiz quz ON quz.id = qa.quiz
JOIN prefix_course_modules cm ON cm.course = quz.course AND cm.module=18 AND cm.instance=quz.id
JOIN prefix_course c ON c.id = cm.course
WHERE u.suspended = 0 AND u.deleted = 0 AND u.department = 'Shikhar school'
GROUP BY quz.id


-- student and enrolled courses ---
SELECT 
    CONCAT('<a href="%%WWWROOT%%/course/view.php?id=',c.id,'">',c.fullname,'</a>') AS 'Course Name',
    CONCAT('<a href="%%WWWROOT%%/user/profile.php?id=',u.id,'">',u.firstname, ' ', u.lastname,'</a>') AS 'User Name',
    u.email AS 'Email',
    u.phone1 AS 'Phone Number',
    u.address AS 'User Address'
FROM {user_enrolments} ue
JOIN {enrol} e ON ue.enrolid = e.id
JOIN {course} c ON e.courseid = c.id
JOIN {user} u ON ue.userid = u.id
JOIN {role_assignments} ra ON ra.userid = u.id
JOIN {context} ctx ON ctx.id = ra.contextid AND ctx.contextlevel = 50
JOIN {role} r ON r.id = ra.roleid AND r.shortname = 'student' 
WHERE ue.status = 0
%%FILTER_COURSES:c.id%% 
%%FILTER_SEARCHTEXT_search:u.email:~%%
GROUP BY c.id, u.id
ORDER BY c.fullname ASC