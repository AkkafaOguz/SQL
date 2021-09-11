
-- Update - Set ------

  /*  Aþaðýdaki gibi tedarikciler adýnda bir tablo oluþturunuz ve vergi_no
    sutununu primary key yapýnýz. Ayrýca aþaðýdaki verileri tabloya giriniz.
    
    vergi_no NUMBER(3),
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50),
  
    INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
	INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammamen');
    INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');
   
   
    Sonrasýnda aþaðýdaki gibi urunler adýnda bir baþka tablo oluþturunuz ve bu
    tablonun ted_vergino sutunu ile tedarikciler tablosunun vergi_no sutunu
    iliþkilendiriniz. Verileri giriniz.
  
    ted_vergino NUMBER(3),
    urun_id NUMBER(11),
    urun_isim VARCHAR2(50),
    musteri_isim VARCHAR2(50),
  
    INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayþe Can');
    INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
    INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yýlmaz');    */


CREATE TABLE TEDARIKCILER1(


    vergi_no NUMBER(3) PRIMARY KEY,
    firma_ismi VARCHAR2(50),
    irtibat_ismi VARCHAR2(50)
);



    INSERT INTO tedarikciler1 VALUES (101, 'IBM', 'Kim Yon');
	INSERT INTO tedarikciler1 VALUES (102, 'Huawei', 'Çin Li');
	INSERT INTO tedarikciler1 VALUES (103, 'Erikson', 'Maki Tammamen');	
    INSERT INTO tedarikciler1 VALUES (104, 'Apple', 'Adam Eve');
    
   
  CREATE TABLE urunler1(
  
  
    ted_vergino NUMBER(3),
    urun_id NUMBER(11),
    urun_isim VARCHAR2(50),
    musteri_isim VARCHAR2(50),

    CONSTRAINT urunler_fk FOREIGN KEY (ted_vergino) REFERENCES TEDARIKCILER1 (vergi_no)
  
  );
 
 DROP TABLE URUNLER1 ;
  
 
    INSERT INTO urunler1 VALUES(101, 1001,'Laptop', 'Ayþe Can');
    INSERT INTO urunler1 VALUES(102, 1002,'Phone', 'Fatma Aka');
    INSERT INTO urunler1 VALUES(102, 1003,'TV', 'Ramazan Öz');
    INSERT INTO urunler1 VALUES(102, 1004,'Laptop', 'Veli Han');
    INSERT INTO urunler1 VALUES(103, 1005,'Phone', 'Canan Ak');
    INSERT INTO urunler1 VALUES(104, 1006,'TV', 'Ali Bak');
    INSERT INTO urunler1 VALUES(104, 1007,'Phone', 'Aslan Yýlmaz');
   
   
   SELECT *FROM urunler1;
   SELECT * FROM TEDARIKCILER1;
   

   -- SYNTAX
    ----------
    -- UPDATE tablo_adý
    -- SET sutun1 = yeni_deger1, sutun2 = yeni_deger2,...
    -- WHERE koþul
    
  
  --Ornek1: vergi_nosu 101 olan tedarikcinin firma ismini 'LG' olarak guncelleyin
  
  
  UPDATE tedarikciler1 SET firma_ismi='LG' WHERE VERGI_NO= 101;
 
 --Ornet2: Tedarikciler tablosundaki tum firma isimlerini Samsung olarak guncelle
 
 UPDATE tedarikciler1  SET firma_ismi='Samsung';



-- ORNEK3: vergi_no’su 102 olan tedarikcinin ismini 'Samsung' ve irtibat_ismi’ni
-- 'Ali Veli' olarak güncelleyeniz.

UPDATE tedarikciler1  SET firma_ismi='LENOVO',IRTIBAT_ISMI ='Ali Veli' WHERE VERGI_NO=102;
  
  
  --Ornek4: firma_ismi Samsung olan tedarikcinin irtibat_ismini 'Ayþe Yýlmaz'
--  olarak güncelleyiniz.  

UPDATE tedarikciler1  SET IRTIBAT_ISMI ='Ayþe Yýlmaz' WHERE FIRMA_ISMI ='Samsung';
  
  
  --Ornek5: urunler tablosundaki urun_id deðeri 1004'ten büyük olanlarýn urun_id
  --deðerlerini bir arttýrýnýz

UPDATE urunler1  SET URUN_ID =URUN_ID +1 WHERE urun_id > 1004;
  
  
  --Ornek6: urunler tablosundaki tüm ürünlerin urun_id deðerini ted_vergino
  --sutun deðeri ile toplayarak güncelleyiniz.
   
  UPDATE urunler1  SET URUN_ID = URUN_ID + TED_VERGINO;
 
 --Ornek7: urunler tablosundan Ali Bak’in aldigi urunun ismini, TEDARÝKCÝ
 --TABLOSUNDA ÝRTÝBAT_ÝSMÝ 'Adam Eve' OLAN FÝRMANIN ÝSMÝ (FÝRMA_ÝSMÝ) ile
 --degistiriniz.
 
 
   UPDATE urunler1  SET URUN_ISIM = (SELECT firma_ismi FROM TEDARIKCILER1 where irtibat_ismi='Adam Eve')  WHERE MUSTERI_ISIM='Ali Bak';
   
  --Ornek8: Laptop satin alan musterilerin ismini, Apple'in irtibat ismi ile degistirin.
  
  UPDATE URUNLER1 SET MUSTERI_ISIM = (SELECT irtibat_ismi FROM TEDARIKCILER1 t WHERE firma_ismi='Apple') WHERE URUN_ISIM='Laptop';
   
 
 