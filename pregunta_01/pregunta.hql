/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Compute la cantidad de registros por cada letra de la columna 1.
Escriba el resultado ordenado por letra. 

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/
DROP TABLE IF EXISTS DATOS;
CREATE TABLE DATOS (LETRA STRING,
FECHA STRING,
NUMERO INT)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';  

LOAD DATA LOCAL INPATH './data.tsv' OVERWRITE INTO TABLE DATOS;


CREATE TABLE WORDCOUNT AS 
SELECT LETRA, COUNT(1) AS  COUNT FROM
(SELECT EXPLODE (split(LETRA, '\\s')) AS LETRA FROM DATOS) L
GROUP BY LETRA
ORDER BY LETRA DESC
LIMIT 5;

CREATE TABLE RESULT AS
SELECT * FROM WORDCOUNT
ORDER BY LETRA;

INSERT OVERWRITE DIRECTORY 'output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * FROM RESULT;
