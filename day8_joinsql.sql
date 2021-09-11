/*============================== JOIN �SLEMLER� ===============================
    fore�gn key id si ortaklar� yanyana yaz�yordu bu bika� tablodan istenilen
    s�tunlar� al�r birle�tirir. set istenilen s�tunlar� tek s�tunda birle�tirir
    Set Operatorleri (Union,Intersect,Minus) farkl� tablolardaki sutunlari
    birlestirmek i�in de kullanilir.
    Join islemleri ise farkl� Tablolari birlestirmek icin kullanilir. Diger
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo
    olusturmak icin kullanilabilir.
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. �unku
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
    getirmek icin kullanilir. ortaklar ayn� sat�rda yaz�l�r, extra fazla sat�r varsa o da yaz�l�r.
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1
    FULL JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
==============================================================================*/

   
   /* -----------------------------------------------------------------------------
  ORNEK1: sirketler ve siparisler ad�ndaki tablolarda yer alan sirket_isim,
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/
   
   
   SELECT sirket_isim, siparis_id, siparis_tarihi FROM SIRKETLER s FULL JOIN siparisler sp ON s.SIRKET_ID= sp.SIRKET_ID; 
  
--ORNEK2: Iki Tabloda sirket_id�si ayni olanlarin sirket_ismi, siparis_id ve
--siparis_tarihleri listeleyen bir sorgu yaziniz. null olanlar ��km�cak ��nk� NULL ortak de�il(bir tabloda null iken di�erinde id null yok, 100, 101 vs var)
   
  
  