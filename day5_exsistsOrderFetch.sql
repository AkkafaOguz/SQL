

CREATE TABLE mart_satislar
    (
        urun_id number(10),
        musteri_isim varchar2(50),
        urun_isim varchar2(50)
    );
   
    CREATE TABLE nisan_satislar
    (
        urun_id number(10),
        musteri_isim varchar2(50),
        urun_isim varchar2(50)
    );
   
    INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar VALUES (10, 'Mark', 'Honda');
    INSERT INTO mart_satislar VALUES (20, 'John', 'Toyota');
    INSERT INTO mart_satislar VALUES (30, 'Amy', 'Ford');
    INSERT INTO mart_satislar VALUES (20, 'Mark', 'Toyota');
    INSERT INTO mart_satislar VALUES (10, 'Adem', 'Honda');
    INSERT INTO mart_satislar VALUES (40, 'John', 'Hyundai');
    INSERT INTO mart_satislar VALUES (20, 'Eddie', 'Toyota');
    
   INSERT INTO nisan_satislar VALUES (10, 'Hasan', 'Honda');
    INSERT INTO nisan_satislar VALUES (10, 'Kemal', 'Honda');
    INSERT INTO nisan_satislar VALUES (20, 'Ayse', 'Toyota');
    INSERT INTO nisan_satislar VALUES (50, 'Yasar', 'Volvo');
    INSERT INTO nisan_satislar VALUES (20, 'Mine', 'Toyota');
    
   
   select * FROM MART_SATISLAR ms ;
   SELECT * FROM NISAN_SATISLAR ns ;
   
--ORNEK1: MART VE NÝSAN aylarýnda ayný URUN_ID ile satýlan ürünlerin
--URUN_ID’lerini listeleyen ve ayný zamanda bu ürünleri MART ayýnda alan
--MUSTERI_ISIM 'lerini listeleyen bir sorgu yazýnýz.  
  
  SELECT urun_id, musteri_isim FROM MART_SATISLAR ms WHERE EXISTS (SELECT URUN_ID FROM NISAN_SATISLAR ns WHERE ns.URUN_ID=ms.URUN_ID);
 -- SELECT urun_id, musteri_isim FROM MART_SATISLAR ms WHERE urun_id IN (SELECT URUN_ID FROM NISAN_SATISLAR ns WHERE MART_SATISLAR.URUN_ID=nisan_satislar.urun_id); --IN daha yavas
 
--ORNEK2: Her iki ayda da satýlan ürünlerin URUN_ISIM'lerini ve bu ürünleri
--NÝSAN ayýnda satýn alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazýnýz.
 
 SELECT urun_isim, musteri_isim FROM NISAN_SATISLAR ns WHERE EXISTS (SELECT URUN_ISIM FROM MART_SATISLAR ms WHERE ms.URUN_ISIM =ns.URUN_ISIM);
 
--ORNEK3: Her iki ayda da ortak olarak satýlmayan ürünlerin URUN_ISIM'lerini
--ve bu ürünleri NÝSAN ayýnda satýn alan MUSTERI_ISIM'lerini listeleyiniz.

SELECT urun_isim, musteri_isim FROM NISAN_SATISLAR ns WHERE NOT EXISTS (SELECT URUN_ISIM FROM MART_SATISLAR ms WHERE ms.URUN_ISIM=ns.URUN_ISIM);



/*===================== IS NULL, IS NOT NULL, COALESCE(kulesk=birleþmek) ========================
    IS NULL, ve IS NOT NULL BOOLEAN operatörleridir. Bir ifadenin NULL olup
    olmadýðýný kontrol ederler.
==============================================================================*/
    CREATE TABLE insanlar
    (
        ssn CHAR(9),
        isim VARCHAR2(50),
        adres VARCHAR2(50)
    );
   
    INSERT INTO insanlar VALUES('123456789', 'Ali Can', 'Istanbul');
    INSERT INTO insanlar VALUES('234567890', 'Veli Cem', 'Ankara');
    INSERT INTO insanlar VALUES('345678901', 'Mine Bulut', 'Izmir');
    INSERT INTO insanlar (ssn, adres) VALUES('456789012', 'Bursa');
    INSERT INTO insanlar (ssn, adres) VALUES('567890123', 'Denizli');
    INSERT INTO insanlar (adres) VALUES('Sakarya');
    INSERT INTO insanlar (ssn) VALUES('999111222');
   
   SELECT * FROM insanlar;
  
--Ismi null olanlari sorgula
  
  SELECT * FROM insanlar WHERE ISIM IS NULL;
 
--Ismi null olmayanlari sorgula
  SELECT * FROM insanlar WHERE ISIM IS NOT NULL;
 
 --Ismi null olan kisilerin ismine no-name atayiniz
 
 UPDATE INSANLAR SET isim='NO NAME' WHERE isim IS NULL;

 UPDATE INSANLAR SET isim=null WHERE isim='NO NAME'; --Alttaki soruyu yapabilmek icin noname'i tekrar null'a cevirdim
 
  
-------------------------------------------------------------------------------------------------

 
 /* COALESCE (birleþmek) ise bir fonksiyondur ve içerisindeki parameterelerden NULL olmayan
    ilk ifadeyi döndürür. Eðer aldýðý tüm ifadeler NULL ise NULL döndürürür.
   *** select COALESCE (sütun1,sütun2,...) from tabloAdý;
    Birden fazla null koþuluna göre deðer atamak istiyorsak COALESCE deyimini kullanabiliriz.
    COALESCE aslýnda case mantýðýnda çalýþýr ve birden fazla kolon arasýnda kontrol saðlayabilirsiniz.
    Bir koþul gerçekleþmez ise diðerine bakar, oda gerçekleþmez ise bir sonraki.
    Deyim bitene kadar
   -- CASE
   WHEN (expression1 IS NOT NULL) THEN expression1
   WHEN (expression2 IS NOT NULL) THEN expression2
   ...
   ELSE expressionN
   END  --gibi*/
 
 
 
SELECT COALESCE (isim,ssn,adres) FROM INSANLAR i ; --siraya gore yazdirir. Isim NULL ise ssn'i yazdirir. O da NULL ise adres'i yazdirir.



--Ornek tablodaki null verileri guzel birer kelime ile degistirin.

UPDATE INSANLAR SET ISIM=COALESCE (ISIM,'Henuz isim girilmedi'), ADRES=COALESCE (ADRES, 'henuz adres belirtilmedi'), SSN = COALESCE (SSN,'no SSN');

SELECT * FROM insanlar;


/*================================ ORDER BY  ===================================
   ORDER BY cümleciði bir SORGU deyimi içerisinde belli bir SUTUN’a göre
   SIRALAMA yapmak için kullanýlýr.
   Syntax
   -------
      ORDER BY sutun_adi ASC   -- ARTAN
      ORDER BY sutun_adi DESC  -- AZALAN
=========================================*/


CREATE TABLE kisiler
    (
        ssn CHAR(9) PRIMARY KEY,
        isim VARCHAR2(50),
        soyisim VARCHAR2(50),
        maas NUMBER,
        adres VARCHAR2(50)
    );
    INSERT INTO kisiler VALUES(123456789, 'Ali','Can', 3000,'Istanbul');
    INSERT INTO kisiler VALUES(234567890, 'Veli','Cem', 2890,'Ankara');
    INSERT INTO kisiler VALUES(345678901, 'Mine','Bulut',4200,'Ankara');
    INSERT INTO kisiler VALUES(256789012, 'Mahmut','Bulut',3150,'Istanbul');
    INSERT INTO kisiler VALUES (344678901, 'Mine','Yasa', 5000,'Ankara');
    INSERT INTO kisiler VALUES (345458901, 'Veli','Yilmaz',7000,'Istanbul');
    SELECT * FROM kisiler;

  
--ORNEK1: kisiler tablosunu adres'e göre sýralayarak sorgulayýnýz.

  SELECT * FROM kisiler ORDER BY adres;
  
--Ornek2: kisiler tablosunda maas'a gore ters siralayarak sorgulayiniz
  
  SELECT * FROM kisiler ORDER BY maas DESC;
 
 --Ornek3: ismi Mine olanlarý, SSN'e göre AZALAN(DESC) sýrada sorgulayýnýz.
 
  SELECT * FROM kisiler WHERE isim='Mine' ORDER BY ssn DESC ;
 
 --ORNEK5: soyismi 'i Bulut olanlarý isim sýralý olarak sorgulayýnýz.
 
 SELECT * FROM kisiler WHERE soyisim='Bulut' ORDER BY 2; --isim yerine tablodaki sirasi olan 2'yi de kullabiliriz. (Orn: soyisim => 3)
 
 
 
 /*====================== FETCH NEXT, OFFSET (12C VE ÜSTÜ oracle larda çalýþýr, daha altsanýz çalýþmaz) ======================
   FETCH cümleciði ile listelenecek kayýtlarý sýnýrlandýrabiliriz. Ýstersek
   satýr sayýsýna göre istersek de toplam satýr sayýsýnýn belli bir yüzdesine
   göre sýnýrlandýrma koymak mümkündür. (þu kadar satýrý getir)
   Syntax
   ---------
   FETCH NEXT satir_sayisi ROWS ONLY;
   FETCH NEXT satir_yuzdesi PERCENT ROWS ONLY;
   OFFSET Cümleciði ile de listenecek olan satýrlardan sýrasýyla istediðimiz
   kadarýný atlayabiliriz.
   Syntax
   ----------
   OFFSET satýr_sayisi ROWS;
==============================================================================*/
 
  
--ORNEK1: MAAÞ'ý en yüksek 3 kiþinin bilgilerini listeleyen sorguyu yazýnýz.
 
 SELECT * FROM kisiler ORDER BY maas DESC FETCH NEXT 3 ROWS ONLY;

SELECT * FROM (SELECT * FROM kisiler ORDER BY maas DESC)--(1) kiþilerde maasa göre ters sýrala
 WHERE ROWNUM < 4;  --1,2,3. satiri getir (bu eski surumlerde calisir)

--ORNEK2: MAAÞ'ý en DÜÞÜK 2 kiþinin bilgilerini listeleyen sorguyu yazýnýz.
    
    SELECT * FROM kisiler ORDER BY maas FETCH NEXT 2 ROWS ONLY;
   
   SELECT * FROM (SELECT * FROM kisiler ORDER BY maas ) WHERE ROWNUM < 3;
  
    select * from kisiler where rownum <3 order by maas;  -- 3. YOL
   
--ORNEK3: MAAÞ'a göre sýralamada 4. 5. ve 6. kiþilerin bilgilerini listeleyen
--sorguyu yazýnýz.  
   
  SELECT * FROM kisiler ORDER BY maas OFFSET 3 FETCH NEXT 3 ROWS ONLY;
 
  SELECT * FROM (SELECT * FROM (SELECT * FROM   kisiler ORDER BY maas DESC) WHERE ROWNUM <=6) WHERE  ROWNUM <=3;
 
  SELECT * FROM (SELECT * FROM   kisiler WHERE ROWNUM <=6 ORDER BY maas DESC) WHERE  ROWNUM <=3;
 
 
 

 
 


