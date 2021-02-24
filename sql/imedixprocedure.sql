DELIMITER $$

DROP PROCEDURE IF EXISTS `sp_getrecord` $$
CREATE PROCEDURE `sp_getrecord`(patid VARCHAR(14), ondate VARCHAR(10))
BEGIN
  DECLARE fn varchar(20);
  DECLARE ff varchar(50);
  DECLARE done INT DEFAULT 0;

  DECLARE meta_field CURSOR FOR SELECT DISTINCT f.name, form_fields FROM forms f, listofforms l, form_summary s WHERE l.pat_id = patid  AND date(l.DATE) = ondate AND UPPER(TRIM(l.TYPE)) = UPPER(s.form_name) AND UPPER(f.name) = UPPER(s.form_name);
  DECLARE  CONTINUE HANDLER FOR NOT FOUND
  SET  done = 1;
  OPEN meta_field;
  fetch meta_field into fn, ff;

  if fn IS NOT NULL then

    REPEAT

      SET @stmt = concat('SELECT ' , ff , ' FROM ' , fn , ' WHERE pat_id = ''' , patid , ''' AND DATE(entrydate) = ''' , ondate , '''');
      PREPARE Exstmt FROM @stmt;
       EXECUTE Exstmt;
       fetch meta_field into fn, ff;

     UNTIL  done = 1
     END REPEAT;
     DEALLOCATE PREPARE Exstmt;
  END IF;

  CLOSE  meta_field;

END $$

DELIMITER ;


-- ----------------------------------------------------------------------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_oncostage` $$

CREATE PROCEDURE `sp_oncostage`(patid VARCHAR(14))
BEGIN
  DECLARE fn char(3);
  DECLARE stmt varchar(300);
  DECLARE done INT DEFAULT 0;

  DECLARE stage CURSOR FOR SELECT DISTINCT TYPE FROM listofforms WHERE pat_id = patid AND (TYPE LIKE 'c%' OR TYPE LIKE 'C%');
  DECLARE  CONTINUE HANDLER FOR NOT FOUND
  SET  done = 1;

  DROP TABLE IF EXISTS onto;
  CREATE TABLE onto (
    organ varchar(30),
    stage_t varchar(200),
    stage_n varchar(200),
    stage_m varchar(200),
    testdate datetime);

  OPEN stage;

  fetch stage into fn;
	if fn IS NOT NULL then
	REPEAT
	      CASE fn
		    WHEN 'c00' THEN SET @stmt = concat('SELECT ''Breast'', staging_T, staging_N, staging_M, testdate FROM c00 WHERE pat_id = ''' , patid , ''' ORDER BY testdate DESC');
	      WHEN 'c01' THEN SET @stmt = concat('SELECT ''Prostate'', staging_T, staging_N, staging_M, testdate FROM c01 WHERE pat_id = ''' , patid , ''' ORDER BY testdate DESC');
	      WHEN 'c02' THEN SET @stmt = concat('SELECT ''Laryngeal'', staging_T, staging_N, staging_M, testdate FROM c02 WHERE pat_id = ''' , patid , ''' ORDER BY testdate DESC');
				WHEN 'c03' THEN SET @stmt = concat('SELECT ''Lung'', staging_T, staging_N, staging_M, testdate FROM c03 WHERE pat_id = ''' , patid , ''' ORDER BY testdate DESC');
				WHEN 'c04' THEN SET @stmt = concat('SELECT ''Gastric'', staging_T, staging_N, staging_M, testdate FROM c04 WHERE pat_id = ''' , patid , ''' ORDER BY testdate DESC');
				WHEN 'c05' THEN SET @stmt = concat('SELECT ''Cervical'', staging_T, staging_N, staging_M, testdate FROM c05 WHERE pat_id = ''' , patid , ''' ORDER BY testdate DESC');
				WHEN 'c06' THEN SET @stmt = concat('SELECT ''Endometrial'', staging_T, staging_N, staging_M, testdate FROM c06 WHERE pat_id = ''' , patid , ''' ORDER BY testdate DESC');
				WHEN 'c08' THEN SET @stmt = concat('SELECT name, tbxstaging_t, tbxstaging_n, tbxstaging_m, testdate FROM c08 WHERE pat_id = ''' , patid , ''' ORDER BY testdate DESC');
	     END CASE;
	      SET @stmt = concat('INSERT INTO onto ' , @stmt);
	      PREPARE Exstmt FROM @stmt;
			  EXECUTE Exstmt;
	     fetch stage into fn;
	  UNTIL  done = 1
	  END REPEAT;
	END IF;
  CLOSE  stage;
  DEALLOCATE PREPARE Exstmt;
  SELECT * FROM onto ORDER BY organ ASC, testdate DESC;
	DROP TABLE onto;
END $$

DELIMITER ;

