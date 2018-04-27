
CREATE TABLESPACE "SIREH_DAT" DATAFILE '+GRUPO_PSIREH/psireh/datafile/sirehdat01' SIZE 10000M; 
ALTER TABLESPACE "NOMINAQ_DAT" ADD DATAFILE '+GRUPO_DATA/nominaq/datafile/nominaqdat02' SIZE 10000M; 

ALTER USER ACSEL QUOTA UNLIMITED ON ACSEL_AUDIT


CREATE SMALLFILE TABLESPACE "EDR_BI_INT_IND" DATAFILE
'+DATA/parabi/datafile/edr_bi_int_ind_01.dbf' SIZE 2000M;
'+DATA/parabi/datafile/edr_bi_int_ind_01.dbf' SIZE 2000M;
'+DATA/parabi/datafile/edr_bi_int_ind_01.dbf' SIZE 2000M;

--CONSULTA TABLESPACE

Select SUBSTR(d.file_name,1,80) "Fichero de datos", t.tablespace_name "Tablespace", 
ROUND(MAX(d.bytes)/1024/1024,2) "MB Tamaño", ROUND((MAX(d.bytes)/1024/1024) - (SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024),2) "MB Usados",
ROUND(SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024,2) "MB Libres",
ROUND(ROUND((MAX(d.bytes)/1024/1024) - (SUM(decode(f.bytes, NULL,0, f.bytes))/1024/1024),2) * 100 / ROUND(MAX(d.bytes)/1024/1024,2),2) "%USO"
FROM DBA_FREE_SPACE f, DBA_DATA_FILES d, DBA_TABLESPACES t
WHERE t.tablespace_name = d.tablespace_name AND
f.tablespace_name(+) = d.tablespace_name
AND f.file_id(+) = d.file_id GROUP BY t.tablespace_name,
d.file_name, t.pct_increase, t.status ORDER BY 1,3 DESC;

select 'ALTER INDEX "'||owner||'".'||index_name||' REBUILD TABLESPACE PARBUTQ_IND;'
from dba_indexes where tablespace_name = 'PARBUTQ_DAT'

select 'alter table '||owner||'.'||table_name||' move '||chr(10)|| 'LOB ('||column_name||') store as '||'(tablespace PARBUTQ_IND);'
from dba_lobs 
where owner ='PARBUTUS';
