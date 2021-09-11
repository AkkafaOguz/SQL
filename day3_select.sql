-------------------------Select - Where --------------------

CREATE TABLE ogrenciler
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        adres VARCHAR2(100),
        sinav_notu NUMBER(3)
    );
    INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Ankara',75);
    INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ankara',85);
    INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Istanbul',85);
    
SELECT * FROM ogrenciler;

/* ============================================================================
   Verileri SELECT komutu ile veritabanýndan çekerken filtreleme yapmak için 
   
   Syntax
   --------
    SELECT ile birlikte WHERE komutu kullanýlabilir. 
   
    SELECT sutün1, sutün2
        ...
    FROM  tablo_adý WHERE koþul;
==============================================================================*/



--Ornek1: Sinav notu 80'den buyuk olan ogrencilerim tum bilgilerini listele

SELECT * FROM OGRENCILER o WHERE sinav_notu>80;

--Adresi ankara olan ogrencilerin 

SELECT isim, adres  FROM OGRENCILER o  WHERE adres= 'Ankara';  --hepsini almayinca "*" kullanma

--id 124 olan ogrencilerin tum bilgilerini sil

DELETE FROM OGRENCILER o WHERE id= 124;

SELECT * FROM ogrenciler;

---------------------------------Select Between ---------------------

CREATE TABLE personel1
    (
        id CHAR(5),
        isim VARCHAR2(50),
        maas NUMBER(5)
    );
    INSERT INTO personel1 VALUES('10001', 'Ahmet Aslan', 7000);
    INSERT INTO personel1 VALUES( '10002', 'Mehmet Yýlmaz' ,12000);
    INSERT INTO personel1 VALUES('10003', 'Meryem ', 7215);
    INSERT INTO personel1 VALUES('10004', 'Veli Han', 5000);
    INSERT INTO personel1 VALUES('10005', 'Mustafa Ali', 5500);
    INSERT INTO personel1 VALUES('10005', 'Ayþe Can', 4000);
    
   SELECT * FROM personel;
   
  
 -- Ornek4: id 10002 ile 10005 olan personellerin bilgilerini listele
 
  SELECT  * FROM PERSONEL1 WHERE id BETWEEN '10002' AND '10005';  --ilk ve son deger dahil (in between)
  
    --2.yontem :
  select * from personel1
  where id >= '10002' AND id <= '10005';
 
 --Ornek5: Ismi Mehmet Yilmaz ile Veli Han arasindaki personelleri yazdir
 
 SELECT * FROM PERSONEL1 WHERE isim BETWEEN 'Mehmet Yýlmaz' AND 'Veli Han';
  
  
--ornek6: id si 10002-10004 arasi olmayan personelleri listele

SELECT isim, maas FROM PERSONEL1 WHERE id NOT BETWEEN '10002' AND '10004';


------------------------------Select In------------------------------


/* ======================= SELECT - IN ======================================
    IN birden fazla mantýksal ifade ile tanýmlayabileceðimiz durumlarý 
    tek komutla yazabilme imkâný verir

    SYNTAX:
    -------
    SELECT sutun1,sutun2, ...
    FROM tablo_adý
    WHERE sutun_adý IN (deger1, deger2, ...);
/* ========================================================================== */


--Ornek7: maasi 4000, 5000,7000 olan personelin bilgilerini listele

 SELECT * FROM PERSONEL1 WHERE maas IN  ('4000','5000', '7000');




/*======================= SELECT - LIKE ======================================
    NOT:LIKE anahtar kelimesi, sorgulama yaparken belirli patternleri
    kullanabilmemize olanak saðlar.
    SYNTAX:
    -------
    SELECT sutün1, sutün2,…
    FROM  tablo_adý WHERE sütun LIKE pattern
    PATTERN ÝÇÝN
    -------------
    %    ---> 0 veya daha fazla karakteri belirtir.
    _    ---> Tek bir karakteri temsil eder.
 ====================================================*/

 --Ismi a harfi ile baslayanlari listele

SELECT * FROM personel1 WHERE isim LIKE 'A%'; 

 --Ismi a harfi ile baslayanlari listele

SELECT * FROM personel1 WHERE isim LIKE '%A'; 

--ORNEK10:  ismi n harfi ile bitenleri listeleyiniz

SELECT * FROM personel1 WHERE isim LIKE '%n'; 

--ORNEK11:  isminin 2. harfi e olanlarý listeleyiniz

SELECT * FROM PERSONEL1 WHERE isim LIKE '_e%';

--ORNEK12:  isminin 2. harfi e olup diðer harflerinde y olanlarý listeleyiniz

SELECT * FROM PERSONEL1 p WHERE isim LIKE '_e%y%';

--ORNEK13:  ismi A ile baþlamayanlarý listeleyiniz

SELECT * FROM PERSONEL1 p WHERE isim NOT LIKE 'A%';

--ORNEK15:  isminde a harfi olmayanlarý listeleyiniz

--ORNEK16:  maaþýnýn son 2 hanesi 00 olmayanlarý listeleyiniz

--ORNEK17:  maaþýnýn 4000 olmayanlarý listeleyiniz

--ORNEK18: maaþý 5 haneli olanlarý listeleyiniz

--ORNEK20: 1. harfi A ve 7.harfi A olan personeli listeleyiniz.
  
  