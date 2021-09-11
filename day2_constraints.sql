
/*======================= CONSTRAINTS - KISITLAMALAR ======================================
   
    NOT NULL - Bir Sütunun  NULL içermemesini garanti eder.
   
    UNIQUE - Bir sütundaki tüm deðerlerin BENZERSÝZ olmasýný garanti eder.
    
    PRIMARY KEY - Bir sütünün NULL içermemesini ve sütundaki verilerin
                  BENZERSÝZ olmasýný garanti eder.(NOT NULL ve UNIQUE birleþimi gibi)
   
    FOREIGN KEY - Baþka bir tablodaki Primary Key’i referans göstermek için kullanýlýr.
                   Böylelikle, tablolar arasýnda iliþki kurulmuþ olur.
   
    CHECK - Bir sutundaki tüm verilerin belirlenen özel bir þartý saðlamasýný garanti eder.
             soldan tablo silerken tablonun kapalý olmasý lazým
             */

    --Ornek 1-- NOT NULL
    --1) Ogrenciler tablosu olusturalim
    --2) id fields'i bos birakilamaz yapalim

CREATE TABLE ogrenciler (

id char(4) NOT NULL,
isim varchar(50),
not_ort number(4,2), --98,55
kayit_tarihi date



);


INSERT INTO ogrenciler VALUES ('1234','hasan',75.25,'14/01/20');
INSERT INTO ogrenciler VALUES ('1234','ayse',null,null);
INSERT INTO OGRENCILER (id,ISIM) VALUES ('3456','fatma');
INSERT INTO ogrenciler VALUES (null,'osman',45.25,'5-01-2020');

SELECT * FROM OGRENCILER o ;

--Ornek 2 unique
--tedarikciler olusturalim od unique olsun

CREATE TABLE tedarikciler (

id char(4) UNIQUE,
isim varchar(50),
adres varchar(100),
tarih DATE 




);

INSERT INTO tedarikciler VALUES ('1234','ayse','mehmet mah izmir','10-11-2020' );
INSERT INTO tedarikciler VALUES ('1234','fatma','veli mah istanbul','5-11-2020' );--ORA-00001: unique constraint (HR.SYS_C007481) violated
INSERT INTO tedarikciler VALUES (null,'cem','süvari mah denizli','5-11-1997' );
INSERT INTO tedarikciler VALUES (null,'can','zeki mah mus','5-11-1998' );
drop table tedarikciler;
  --unique constraint tekrara izin vermez ancak istediðiniz kadar null girebilirsiniz
  select * from tedarýkcýler;
 
 --ornek3 primary key
 
 CREATE TABLE personel ( 

 
 id char(5)PRIMARY KEY,
 isim varchar(50)UNIQUE ,
 maas NUMBER(5) NOT NULL,
 ise_baslama DATE 

 );

    INSERT INTO personel VALUES('10001', 'Ahmet Aslan',7000, '13-04-2018');
    INSERT INTO personel VALUES( '10001', 'Mehmet Yýlmaz' ,12000, '14-04-18'); --SQL Error [1] [23000]: ORA-00001: unique constraint (HR.SYS_C007007) violated
    INSERT INTO personel VALUES('10003', '', 5000, '14-04-18');
    INSERT INTO personel VALUES('10004', 'Veli Han', 5000, '14-04-18');
    INSERT INTO personel VALUES('10005', 'Ahmet Aslan', 5000, '14-04-18');--SQL Error [1] [23000]: ORA-00001: unique constraint (HR.SYS_C007008) violated
    INSERT INTO personel VALUES('NULL', 'Canan Yaþ', NULL, '12-04-19');-- null olmaz SQL Error [17439] [99999]: Geçersiz SQL türü: sqlKind = UNINITIALIZED


    SELECT * FROM PERSONEL;
    
   
   
   
   
  
 -------   -- ogrenciler3 tablosu olusturalim ve ogrenci_id 'yi PRIMARY KEY yapalim
    CREATE TABLE ogrenciler3
(
ogrenci_id char(4) PRIMARY KEY,
Isim_soyisim varchar2(50),
not_ort number(5,2), --100,00
kayit_tarihi date -- 14-01-2021
);
SELECT *FROM ogrenciler3;
INSERT INTO ogrenciler3 VALUES ('1234', 'hasan yaman',75.70,'14-01-2020');
INSERT INTO ogrenciler3 VALUES (null, 'veli yaman',85.70,'14-01-2020'); -- id null olamaz - SQL Error [1400] [23000]: ORA-01400: cannot insert NULL into ("HR"."OGRENCILER3"."OGRENCI_ID")
INSERT INTO ogrenciler3 VALUES ('1234', 'Ali Can',55.70,'14-06-2020'); -- id benzersiz olmalý, daha önceverilen id kullanýlamaz - SQL Error [1] [23000]: ORA-00001: unique constraint (HR.SYS_C007009) violated
INSERT INTO ogrenciler3 (isim_soyisim) VALUES ( 'Veli Cem'); -- id vermeden baþka þeyler vermeye geçemezsin, default null atar, buda primary ye uymaz - SQL Error [1400] [23000]: ORA-01400: cannot insert NULL into ("HR"."OGRENCILER3"."OGRENCI_ID")
INSERT INTO ogrenciler3 (ogrenci_id) VALUES ( '5687');

--Primary Key alternatif yontem
--bu yontemle kisitlamaya istedigimiz ismi verebiliriz

CREATE TABLE calisanlar (

id char(4),
isim varchar(50) UNIQUE,
maas NUMBER (5) NOT NULL,

CONSTRAINT id_primary PRIMARY KEY (id)
);


INSERT INTO calisanlar VALUES('1001', 'Ahmet Aslan',7000);
INSERT INTO calisanlar VALUES( '1002', 'Mehmet Yýlmaz' ,12000);
INSERT INTO calisanlar VALUES('1003', 'CAN', 5000);

SELECT * FROM calisanlar;
--bir tabloya veri eklerken constraint'lere dikkat edilmelidir.


 --ornek4 foreign key

CREATE TABLE adresler (


adres_id char(4),  --FOREIGN KEY'i yazmanin tek yolu var - CONSTRAINT id_foreign FOREIGN  KEY (adres_id)
sokak varchar(30),
cadde varchar(30),
sehir varchar(15),

CONSTRAINT id_foreign FOREIGN  KEY (adres_id) REFERENCES CALISANLAR (id)



);

 INSERT INTO adresler VALUES('1001','Mutlu Sok', '40.Cad.','IST');
    INSERT INTO adresler VALUES('1001','Can Sok', '50.Cad.','Ankara');
    INSERT INTO adresler VALUES('1002','Aða Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','Aða Sok', '30.Cad.','Antep');
    INSERT INTO adresler VALUES('','Aða Sok', '30.Cad.','Antep');
  --INSERT INTO adresler VALUES('10004','Gel Sok', '60.Cad.','Van'); -- babada(parent) olmayan bir id giremeyiz


SELECT * FROM adresler;

                       --Child silinmeden parent silinmez
DROP TABLE calisanlar; --SQL Error [2449] [72000]: ORA-02449: unique/primary keys in table referenced by foreign keys
DROP TABLE adresler;


-- Ogrenciler tablosunu olusturun ve id, isim hanelerinin birlesimini Primary Key yapin

CREATE TABLE ogrenciler5 (


id char(4),
isim varchar(20),
not_ort number(5,2),
kayit_tarihi DATE,

CONSTRAINT ogrenciler5_primary PRIMARY KEY (id,isim) --bir butun olarak PRIMARY kurali gecerlidir.

);

SELECT * FROM ogrenciler5;

INSERT INTO ogrenciler5 VALUES (null,'Veli Cem',90.6,'15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ID")
INSERT INTO ogrenciler5 VALUES (1234,null,90.6,'15-05-2019'); -- ORA-01400: cannot insert NULL into ("HR"."OGRENCILER5"."ISIM")
INSERT INTO ogrenciler5 VALUES (1234,'Ali Can',90.6,'15-05-2019'); -- PK= 1234Ali Can
INSERT INTO ogrenciler5 VALUES (1234,'Veli Cem',90.6,'15-05-2019'); -- PK=1234Veli Cem
INSERT INTO ogrenciler5 VALUES (1234,'Oli Can',90.6,'15-05-2019');



--“tedarikciler4” isimli bir Tablo olusturun. Icinde “tedarikci_id”, “tedarikci_isim”, “iletisim_isim” field’lari olsun.
--“tedarikci_id” ve “tedarikci_isim” fieldlarini birlestirerek Primary Key olusturun.
--“urunler2” isminde baska bir tablo olusturun.Icinde “tedarikci_id” ve “urun_id” fieldlari olsun.
--“tedarikci_id” ve “urun_id” fieldlarini birlestirerek Foreign Key olusturun

CREATE TABLE tedarikciler4 (


tedarikci_id char(4),
tedarikci_ismi varchar(20),
iletisim_ismi varchar(20),

CONSTRAINT tedarikciler4 PRIMARY KEY (tedarikci_id,tedarikci_ismi)-- char + varchar


);

CREATE TABLE urunler2 (



tedarikci_id char(4),
urun_id varchar(5),

CONSTRAINT urunler2 FOREIGN  KEY (tedarikci_id,urun_id) REFERENCES tedarikciler4 -- char + varchar

);



CREATE TABLE sehirler2 (	
    alan_kodu CHAR(3 ),
	isim VARCHAR2(50),
	nufus NUMBER(8,0) CHECK (nufus>1000)
    );
    INSERT INTO sehirler2 VALUES ('312','Ankara',5750000);
    INSERT INTO sehirler2 VALUES ('232','izmir',375); -- ORA-02290: check constraint (HR.SYS_C007028) violated
    INSERT INTO sehirler2 VALUES ('232','izmir',3750000);
    INSERT INTO sehirler2 VALUES ('436','Maras',null);	















