--Tablo olusturma--
CREATE TABLE student
(
id CHAR(4),
name VARCHAR(20),
age NUMBER

);

--Veri Girisi--

INSERT INTO student VALUES('1001', 'MEHMET ALA',25);
INSERT INTO student VALUES('1002','AYSE',12);

SELECT * FROM STUDENT s 

--Tablo Silme--

DROP TABLE STUDENT;

--Parcali Veri Girisi--

INSERT INTO STUDENT (id,NAME) VALUES ('1003','FATMA');

--Veri Tabaninizda Urunler Adinda Bi Tablo Olusturun--

CREATE TABLE URUNLER
(

urun_id char (4),
urun_adi VARCHAR(50),
fiyat NUMBER
);

INSERT INTO urunler VALUES ('100','CIPS',5);
INSERT INTO urunler VALUES ('200','KOLA',6);

SELECT * FROM URUNLER s 