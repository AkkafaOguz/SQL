/*============================== JOIN ÝSLEMLERÝ ===============================
    foreýgn key id si ortaklarý yanyana yazýyordu bu bikaç tablodan istenilen
    sütunlarý alýr birleþtirir. set istenilen sütunlarý tek sütunda birleþtirir
    Set Operatorleri (Union,Intersect,Minus) farklý tablolardaki sutunlari
    birlestirmek için de kullanilir.
    Join islemleri ise farklý Tablolari birlestirmek icin kullanilir. Diger
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo
    olusturmak icin kullanilabilir.
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Çunku
    Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek
    icin JOIN islemleri kullanilabilir.
    ORACLE SQL'de 4 Cesit Join islemi kullanilabilmektedir.
    1) FULL JOIN:  Tablodaki tum sonuclari gosterir
    2) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
    3) LEFT JOIN:  Ilk tabloda (Sol) olup digerinde olmayan sonuclari gosterir
    4) RIGHT JOIN: Sadece Ikinci tabloda olan tum sonuclari gosterir */


DROP TABLE SIRKETLER ;
CREATE TABLE sirketler
    (
        sirket_id NUMBER(9),
        sirket_isim VARCHAR2(20)
    );
    drop table siparisler;
    INSERT INTO sirketler VALUES(100, 'Toyota');
    INSERT INTO sirketler VALUES(101, 'Honda');
    INSERT INTO sirketler VALUES(102, 'Ford');
    INSERT INTO sirketler VALUES(103, 'Hyundai');
    
   CREATE TABLE siparisler
    (
        siparis_id NUMBER(9),
        sirket_id NUMBER(9),
        siparis_tarihi DATE
    );
    INSERT INTO siparisler VALUES(11, 101, '17-04-2020');
    INSERT INTO siparisler VALUES(22, 102, '18-04-2020');
    INSERT INTO siparisler VALUES(33, 103, '19-04-2020');
    INSERT INTO siparisler VALUES(44, 104, '20-04-2020');
    INSERT INTO siparisler VALUES(55, 105, '21-04-2020');
    SELECT * FROM siparisler;
    SELECT * FROM sirketler;

   /*=============================== FULL JOIN  ==================================
    FULL JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari
    getirmek icin kullanilir. ortaklar ayný satýrda yazýlýr, extra fazla satýr varsa o da yazýlýr.
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    FULL JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/

   
   /* -----------------------------------------------------------------------------
  ORNEK1: sirketler ve siparisler adýndaki tablolarda yer alan sirket_isim,
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/
   
   
   SELECT sirket_isim, siparis_id, siparis_tarihi, sp.SIRKET_ID, s.SIRKET_ID FROM SIRKETLER s FULL JOIN siparisler sp ON s.SIRKET_ID= sp.SIRKET_ID; 
  
--ORNEK2: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri listeleyen bir sorgu yaziniz. null olanlar çýkmýcak çünkü NULL ortak deðil(bir tabloda null iken diðerinde id null yok, 100, 101 vs var)
   
  
/*=============================== INNER JOIN  ==================================
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
================================================================================


/* -----------------------------------------------------------------------------
  ORNEK2: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
  siparis_tarihleri listeleyen bir sorgu yaziniz. null olanlar çýkmýcak çünkü NULL
  ortak deðil(bir tabloda null iken diðerinde id null yok, 100, 101 vs var)
------------------------------------------------------------------------------*/
  

   SELECT sirket_isim, siparis_id, siparis_tarihi, sp.sirket_id FROM SIRKETLER s INNER JOIN SIPARISLER sp ON s.SIRKET_ID = sp.SIRKET_ID ;
  
-- INNER JOIN ile sadece iki tablodaki ortak olan satirlar secilir.
-- Diger ifadeyle iki tablodaki ortak olan sirket_id degerleri icin ilgili sutunlar listenir.
  
  
  
  
  
  
/*=============================== LEFT JOIN  ==================================
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir.
    Ancak, diger tablodan sadece ON ile belirtilen 2.tablodan kosula uyan satirlari getirir.
    -- ancak ortak olmayan kisimlar bos kalir. 2. tablodan 104,105 yok mesela.
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/
  
  
  /* -----------------------------------------------------------------------------
  ORNEK3: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/
  
  SELECT sirket_isim, siparis_id, siparis_tarihi FROM SIRKETLER s LEFT JOIN SIPARISLER sp ON s.SIRKET_ID = sp.SIRKET_ID ;
 
--From sonrasi patron tablo (for LEFT JOIN) JOIN sonrasi cocuk tablo (for RIGHT JOIN)  
 
  
 
/*============================== RIGHT JOIN  ==================================
    RIGHT JOIN, 2. tablodan (sag tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir.
     diger tablodan sadece ON ile belirtilen 1. tablodan kosula uyan (ortak) satirlari getirir.
    ancak ortak olmayan kisimlar bos kalir.1. tablodaki Toyota yazýlmaz, ortak olmadýðý için
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    RIGHT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/

 
 /* -----------------------------------------------------------------------------
  ORNEK4: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile
  bunlara karþýlýk gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/
  
 SELECT siparis_id, siparis_tarihi,sirket_isim FROM SIRKETLER s  RIGHT JOIN SIPARISLER sp ON s.SIRKET_ID = sp.SIRKET_ID ;
  




    CREATE TABLE bolumler (
      bolum_id   NUMBER(2) ,
      bolum_isim VARCHAR2(14),
      konum      VARCHAR2(13)
    );
  
   INSERT INTO bolumler VALUES (10,'MUHASABE','IST');
    INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
    INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
    INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
    INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');
   
CREATE TABLE personel3 (
      personel_id   NUMBER(4) ,
      personel_isim VARCHAR2(10),
      meslek        VARCHAR2(9),
      mudur_id      NUMBER(4),
      ise_baslama   DATE,
      maas          NUMBER(7,2),
      bolum_id      NUMBER(2)
    );
   
   SELECT * FROM bolumler;
   
  INSERT INTO personel3 VALUES (7369,'AHMET','KATIP',7902,'17.12.1980',800,20);
    INSERT INTO personel3 VALUES (7499,'BAHATTIN','SATIS',7698,'20.02.1981',1600,30);
    INSERT INTO personel3 VALUES (7521,'NESE','SATIS',7698,'22.02.1981',1250,30);
    INSERT INTO personel3 VALUES (7566,'MUZAFFER','MUDUR',7839,'02.04.1981',2975,20);
    INSERT INTO personel3 VALUES (7654,'MUHAMMET','SATIS',7698,'28.09.1981',1250,30);
    INSERT INTO personel3 VALUES (7698,'EMINE','MUDUR',7839,'01.05.1981',2850,30);
    INSERT INTO personel3 VALUES (7782,'HARUN','MUDUR',7839,'09.06.1981', 2450,10);
    INSERT INTO personel3 VALUES (7788,'MESUT','ANALIST',7566,'13.07.87',3000,20);
    INSERT INTO personel3 VALUES (7839,'SEHER','BASKAN',NULL,'17.11.1981',5000,10);
    INSERT INTO personel3 VALUES (7844,'DUYGU','SATIS',7698,'08.09.1981',1500,30);
    INSERT INTO personel3 VALUES (7876,'ALI','KATIP',7788,'13.07.1987',1100,20);
    INSERT INTO personel3 VALUES (7900,'MERVE','KATIP',7698,'03.12.1981',950,30);
    INSERT INTO personel3 VALUES (7902,'NAZLI','ANALIST',7566,'03.12.1981',3000,20);
    INSERT INTO personel3 VALUES (7934,'EBRU','KATIP',7782,'23.01.1982',1300,10);
    INSERT INTO personel3 VALUES (7956,'SIBEL','MIMAR',7782,'29.01.1991',3300,60);
    INSERT INTO personel3 VALUES (7933,'ZEKI','MUHENDIS',7782,'26.01.1987',4300,60);
    SELECT * FROM personel3;
  
  
--ORNEK1: SATIS ve MUHASABE bolumlerinde calisan personelin isimlerini ve
--bolumlerini, once bolum sonra isim sýralý olarak listeleyiniz
-----------------------------------------------------------------
  
   SELECT personel_isim, bolum_isim FROM PERSONEL3 p3 FULL JOIN BOLUMLER b ON b.bolum_id= p3.bolum_id WHERE bolum_isim IN ('SATIS','MUHASABE') ORDER BY bolum_isim, personel_isim;
  
  
  
--ORNEK2: SATIS,ISLETME ve DEPO bolumlerinde calisan personelin isimlerini,
--bolumlerini ve ise_baslama tarihlerini bolum_isim sýralý olarak listeleyiniz.
--NOT: calisani olmasa bile bolum ismi gosterilmelidir
  
  SELECT bolum_isim, personel_isim, ise_baslama FROM bolumler b LEFT JOIN personel3 p3 ON b.bolum_id= p3.bolum_id WHERE bolum_isim IN ('SATIS','ISLETME','DEPO') ORDER BY bolum_isim;
  
  
  
  
  
  