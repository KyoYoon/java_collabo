DROP TABLE uriLog;
 
CREATE TABLE uriLog(
   urilogno INT NOT NULL AUTO_INCREMENT, -- 일련 번호
   id          VARCHAR(50) DEFAULT 'guest' NOT NULL, -- 아이디
   ip          VARCHAR(15)                 NOT NULL, -- 123.456.789.012
   uri         VARCHAR(100)                 NOT NULL, -- URI 주소
   uridate    VARCHAR(19)                 NOT NULL, -- 접속 날짜
   PRIMARY KEY(urilogno)
);
 
INSERT INTO uriLog(id, ip, uri, uridate)
VALUES('user1', '10.0.0.1','/bbs/create_form.jsp', now());
 
INSERT INTO uriLog(id, ip, uri, uridate)
VALUES('user1', '10.0.0.1','/bbs/create_form.jsp', now());
 
INSERT INTO uriLog(id, ip, uri, uridate)
VALUES('user1', '10.0.0.1','/bbs/create_form.jsp', now());
 
 
SELECT urilogno, id, ip, uri, uridate 
FROM uriLog
ORDER BY urilogno DESC;
 
 urilogno id    ip       uri                  uridate
 -------- ----- -------- -------------------- -------------------
        3 user1 10.0.0.1 /bbs/create_form.jsp 2017-03-09 16:14:16
        2 user1 10.0.0.1 /bbs/create_form.jsp 2017-03-09 16:14:15
        1 user1 10.0.0.1 /bbs/create_form.jsp 2017-03-09 16:14:14