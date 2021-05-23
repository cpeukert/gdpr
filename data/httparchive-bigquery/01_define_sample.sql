/* --- Define the sample ---*/

#standardSQL
CREATE TABLE myhttparchive.common_hosts_balanced AS
SELECT p.pageid, NET.HOST(p.url) as host
FROM `httparchive.summary_pages.*` p,
(
WITH dlist AS
(
SELECT DISTINCT host, date
FROM
(
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, NET.HOST(p.url) as host
FROM `httparchive.summary_pages.*` p, 
(
SELECT NET.HOST(t1.url) as host
	FROM `httparchive.summary_pages.2018_06_01_desktop` t1
	INNER JOIN `httparchive.summary_pages.2018_07_01_desktop` t2
	ON NET.HOST(t1.url)=NET.HOST(t2.url)
) l
WHERE  _TABLE_SUFFIX like '%desktop' AND (_TABLE_SUFFIX like '%2017_05%'
        OR _TABLE_SUFFIX like '%2017_06%'
        OR _TABLE_SUFFIX like '%2017_07%'
        OR _TABLE_SUFFIX like '%2017_08%'
        OR _TABLE_SUFFIX like '%2017_09%'
        OR _TABLE_SUFFIX like '%2017_10%'
        OR _TABLE_SUFFIX like '%2017_11%'
        OR _TABLE_SUFFIX like '%2017_12%'
        OR _TABLE_SUFFIX like '%2018%'
	AND _TABLE_SUFFIX NOT like '%2018_12%' )
AND NET.HOST(p.url)=l.host
)
),
times AS
(
SELECT host, COUNT(date) AS nooc FROM dlist
GROUP BY host
),
max AS
(
SELECT MAX(nooc) AS maxnooc FROM times 
)
SELECT times.host
FROM times, max 
WHERE times.nooc=max.maxnooc
) l
WHERE  _TABLE_SUFFIX like '%desktop' AND (_TABLE_SUFFIX like '%2017_05%'
        OR _TABLE_SUFFIX like '%2017_06%'
        OR _TABLE_SUFFIX like '%2017_07%'
        OR _TABLE_SUFFIX like '%2017_08%'
        OR _TABLE_SUFFIX like '%2017_09%'
        OR _TABLE_SUFFIX like '%2017_10%'
        OR _TABLE_SUFFIX like '%2017_11%'
        OR _TABLE_SUFFIX like '%2017_12%'
        OR _TABLE_SUFFIX like '%2018%'
	AND _TABLE_SUFFIX NOT like '%2018_12%')
AND NET.HOST(p.url)=l.host;

#standardSQL
CREATE TABLE myhttparchive.common_hosts_balanced_meta AS
SELECT NET.HOST(p.url) as host, NET.PUBLIC_SUFFIX(p.url) AS tld,  NET.REG_DOMAIN(p.url) AS domain
FROM `httparchive.summary_pages.*` p, `myhttparchive.common_hosts_balanced` l
WHERE  _TABLE_SUFFIX like '%desktop' AND (_TABLE_SUFFIX like '%2017_05%'
        OR _TABLE_SUFFIX like '%2017_06%'
        OR _TABLE_SUFFIX like '%2017_07%'
        OR _TABLE_SUFFIX like '%2017_08%'
        OR _TABLE_SUFFIX like '%2017_09%'
        OR _TABLE_SUFFIX like '%2017_10%'
        OR _TABLE_SUFFIX like '%2017_11%'
        OR _TABLE_SUFFIX like '%2017_12%'
        OR _TABLE_SUFFIX like '%2018%'
	AND _TABLE_SUFFIX NOT like '%2018_12%' )
AND NET.HOST(p.url)=l.host
GROUP BY host, tld, domain;

