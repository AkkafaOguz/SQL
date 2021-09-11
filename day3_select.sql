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
   Verileri SELECT komutu ile veritaban�ndan �ekerken filtreleme yapmak i�in 
   
   Syntax
   --------
    SELECT ile birlikte WHERE komutu kullan�labilir. 
   
    SELECT sut�n1, sut�n2
        ...
    FROM  tablo_ad� WHERE ko�ul;
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
    INSERT INTO personel1 VALUES( '10002', 'Mehmet Y�lmaz' ,12000);
    INSERT INTO personel1 VALUES('10003', 'Meryem ', 7215);
    INSERT INTO personel1 VALUES('10004', 'Veli Han', 5000);
    INSERT INTO personel1 VALUES('10005', 'Mustafa Ali', 5500);
    INSERT INTO personel1 VALUES('10005', 'Ay�e Can', 4000);
    
   SELECT * FROM personel;
   
  
 -- Ornek4: id 10002 ile 10005 olan personellerin bilgilerini listele
 
  SELECT  * FROM PERSONEL1 WHERE id BETWEEN '10002' AND '10005';  --ilk ve son deger dahil (in between)
  
    --2.yontem :
  select * from personel1
  where id >= '10002' AND id <= '10005';
 
 --Ornek5: Ismi Mehmet Yilmaz ile Veli Han arasindaki personelleri yazdir
 
 SELECT * FROM PERSONEL1 WHERE isim BETWEEN 'Mehmet Y�lmaz' AND 'Veli Han';
  
  
--ornek6: id si 10002-10004 arasi olmayan personelleri listele

SELECT isim, maas FROM PERSONEL1 WHERE id NOT BETWEEN '10002' AND '10004';


------------------------------Select In------------------------------


/* ======================= SELECT - IN ======================================
    IN birden fazla mant�ksal ifade ile tan�mlayabilece�imiz durumlar� 
    tek komutla yazabilme imk�n� verir

    SYNTAX:
    -------
    SELECT sutun1,sutun2, ...
    FROM tablo_ad�
    WHERE sutun_ad� IN (deger1, deger2, ...);
/* ========================================================================== */


--Ornek7: maasi 4000, 5000,7000 olan personelin bilgilerini listele

 SELECT * FROM PERSONEL1 WHERE maas IN  ('4000','5000', '7000');




/*======================= SELECT - LIKE ======================================
    NOT:LIKE anahtar kelimesi, sorgulama yaparken belirli patternleri
    kullanabilmemize olanak sa�lar.
    SYNTAX:
    -------
    SELECT sut�n1, sut�n2,�
    FROM  tablo_ad� WHERE s�tun LIKE pattern
    PATTERN ���N
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

--ORNEK11:  isminin 2. harfi e olanlar� listeleyiniz

SELECT * FROM PERSONEL1 WHERE isim LIKE '_e%';

--ORNEK12:  isminin 2. harfi e olup di�er harflerinde y olanlar� listeleyiniz

SELECT * FROM PERSONEL1 p WHERE isim LIKE '_e%y%';

--ORNEK13:  ismi A ile ba�lamayanlar� listeleyiniz

SELECT * FROM PERSONEL1 p WHERE isim NOT LIKE 'A%';

--ORNEK15:  isminde a harfi olmayanlar� listeleyiniz

--ORNEK16:  maa��n�n son 2 hanesi 00 olmayanlar� listeleyiniz

--ORNEK17:  maa��n�n 4000 olmayanlar� listeleyiniz

--ORNEK18: maa�� 5 haneli olanlar� listeleyiniz

--ORNEK20: 1. harfi A ve 7.harfi A olan personeli listeleyiniz.
  
  