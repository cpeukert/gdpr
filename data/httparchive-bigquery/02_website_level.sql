/* --- Website-level data ---*/

#standardSQL
CREATE TABLE myhttparchive.requests3 AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, l.host, COUNT(DISTINCT NET.REG_DOMAIN(r.url)) as requests
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
GROUP BY date, host;

#standardSQL
CREATE TABLE myhttparchive.cookies3 AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, l.host, COUNT(DISTINCT NET.REG_DOMAIN(r.url)) as requests
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
AND r.pageid = l.pageid AND NET.REG_DOMAIN(r.url)!=NET.REG_DOMAIN(l.host) AND respCookieLen>0 AND (status=200 OR status=302)
GROUP BY date, host;


#standardSQL
CREATE TABLE myhttparchive.language1 AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, l.host, COUNT(DISTINCT r.requestid) as requests, resp_content_language as lang
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
AND r.pageid = l.pageid AND NET.REG_DOMAIN(r.url)=NET.REG_DOMAIN(l.host)
GROUP BY date, host, lang;

/*------Google-----------*/
/*--- data on Google trackers comes from https://github.com/timlib/webXray_Domain_Owner_List ---*/

#standardSQL
CREATE TABLE myhttparchive.requests3_google AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, l.host, g.google
FROM `httparchive.summary_requests.*` r, `myhttparchive.common_hosts_balanced` l, `myhttparchive.google_trackers` g
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
AND r.pageid = l.pageid AND NET.REG_DOMAIN(r.url)!=NET.REG_DOMAIN(l.host) AND (status=200 OR status=302) AND NET.REG_DOMAIN(r.url)=g.tracker
GROUP BY date, host, google;


#standardSQL
CREATE TABLE myhttparchive.requests3_notgoogle AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, l.host
FROM `httparchive.summary_requests.*` r, `myhttparchive.common_hosts_balanced` l, `myhttparchive.google_trackers` g
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
AND r.pageid = l.pageid AND NET.REG_DOMAIN(r.url)!=NET.REG_DOMAIN(l.host) AND (status=200 OR status=302) AND NET.REG_DOMAIN(r.url)!=g.tracker
GROUP BY date, host;


/*------Facebook-----------*/
/*--- data on Google trackers comes from https://github.com/timlib/webXray_Domain_Owner_List ---*/

#standardSQL
CREATE TABLE myhttparchive.dfb AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, l.host, COUNT(DISTINCT NET.REG_DOMAIN(r.url)) as requests
FROM `httparchive.summary_requests.*` r, `myhttparchive.common_hosts_balanced` l, `myhttparchive.facebook_trackers` f
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
AND r.pageid = l.pageid AND NET.REG_DOMAIN(r.url)!=NET.REG_DOMAIN(l.host) AND (status=200 OR status=302) AND NET.REG_DOMAIN(r.url)=f.tracker
GROUP BY date, host;

#standardSQL
CREATE TABLE myhttparchive.dnonfb AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, l.host, COUNT(DISTINCT NET.REG_DOMAIN(r.url)) as requests
FROM `httparchive.summary_requests.*` r, `myhttparchive.common_hosts_balanced` l, `myhttparchive.facebook_trackers` f
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
AND NET.REG_DOMAIN(r.url)!=f.tracker
GROUP BY date, host;

#standardSQL
CREATE TABLE myhttparchive.cookies3_facebook AS
SELECT SUBSTR(_TABLE_SUFFIX, 0, 10) AS date, l.host, COUNT(DISTINCT NET.REG_DOMAIN(r.url)) as requests
FROM `httparchive.summary_requests.*` r, `myhttparchive.common_hosts_balanced` l, `myhttparchive.facebook_trackers` f
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
AND r.pageid = l.pageid AND NET.REG_DOMAIN(r.url)!=NET.REG_DOMAIN(l.host) AND respCookieLen>0 AND (status=200 OR status=302) AND NET.REG_DOMAIN(r.url)=f.tracker
GROUP BY date, host;

