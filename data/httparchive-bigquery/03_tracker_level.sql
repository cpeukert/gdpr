/* --- Tracker-level data ---*/

#standardSQL
CREATE TABLE myhttparchive.trackers AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, NET.REG_DOMAIN(r.url) as tracker, COUNT(r.requestid) as requests, COUNT(DISTINCT NET.REG_DOMAIN(l.host)) as websites
FROM `httparchive.summary_requests.*` r, `myhttparchive.common_hosts_balanced` l
WHERE  _TABLE_SUFFIX like '%desktop%' AND 
(_TABLE_SUFFIX like '%2017_05%'
	OR _TABLE_SUFFIX like '%2017_06%'
	OR _TABLE_SUFFIX like '%2017_07%'
        OR _TABLE_SUFFIX like '%2017_08%'
        OR _TABLE_SUFFIX like '%2017_09%'
        OR _TABLE_SUFFIX like '%2017_10%'
        OR _TABLE_SUFFIX like '%2017_11%'
        OR _TABLE_SUFFIX like '%2017_12%'
        OR _TABLE_SUFFIX like '%2018%'
	AND _TABLE_SUFFIX NOT like '%2018_12%' )
AND r.pageid = l.pageid AND NET.REG_DOMAIN(r.url)!=NET.REG_DOMAIN(l.host) AND (status=200 OR status=302)
GROUP BY date, tracker;

/* --- Data on squares of the GDPR applicability matrix (see paper) is proprietary ---*/
/* ---- Firm location is measured with data from Crunchbase (company website domain) ----*/
/* ---- Website location is measured with data from whoisxmlapi.com ----*/

#standardSQL
CREATE TABLE myhttparchive.trackers_square AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, NET.REG_DOMAIN(r.url) as tracker, COUNT(r.requestid) as requests, square.square as square, COUNT(DISTINCT NET.REG_DOMAIN(l.host)) as websites
FROM `httparchive.summary_requests.*` r, `myhttparchive.common_hosts_balanced` l, `myhttparchive.common_hosts_balanced_meta_square` square
WHERE  _TABLE_SUFFIX like '%desktop%' AND 
(_TABLE_SUFFIX like '%2017_05%'
	OR _TABLE_SUFFIX like '%2017_06%'
	OR _TABLE_SUFFIX like '%2017_07%'
        OR _TABLE_SUFFIX like '%2017_08%'
        OR _TABLE_SUFFIX like '%2017_09%'
        OR _TABLE_SUFFIX like '%2017_10%'
        OR _TABLE_SUFFIX like '%2017_11%'
        OR _TABLE_SUFFIX like '%2017_12%'
        OR _TABLE_SUFFIX like '%2018%'
	AND _TABLE_SUFFIX NOT like '%2018_12%' )
AND r.pageid = l.pageid AND NET.REG_DOMAIN(r.url)!=NET.REG_DOMAIN(l.host) AND (status=200 OR status=302) AND l.host=square.host
GROUP BY date, square, tracker;