/*============================ GROUP BY =====================================
    GROUP BY cümleciði bir SELECT ifadesinde satýrlarý, sutunlarýn deðerlerine
    göre özet olarak gruplamak için kullanýlýr.
    GROUP BY cümleceði her grup baþýna bir satýr döndürür.
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate
    fonksiyonlarý ile birlikte kullanýlýr.*/


CREATE TABLE manav
    (
        isim varchar2(50),
        urun_adi varchar2(50),
        urun_miktari number(9)
    );
   
    INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
    INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
    INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
    INSERT INTO manav VALUES( 'Veli', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
    INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
    INSERT INTO manav VALUES( 'Ayse', 'Uzum', 4);
    INSERT INTO manav VALUES( 'Ali', '', 2);
    
    
--ORNEK1: kisi ismine göre satýlan toplam meyve miktarlarýný gösteren sorguyu
--yazýnýz. ali=>5+2+2+2 sum= meyve sayýlarýný toplucak
   
   SELECT isim, sum(urun_miktari) AS ToplamMeyve FROM manav GROUP BY isim;
  
--ORNEK2: satýlan meyve türüne (urun_adi) göre urun alan kiþi sayýsýný gösteren
--sorguyu yazýnýz. NULL olarak girilen meyveyi listelemesin.count= elma alan kiþileri sayacak  
  
  SELECT urun_adi, COUNT (isim) AS AlanKisiSayisi FROM manav WHERE urun_adi IS NOT NULL GROUP BY urun_adi;
 
--ORNEK3: satýlan meyve türüne (URUN_ADÝ) göre satýlan (urun_miktari )MIN ve
--MAX urun miktarlarini, MAX urun miktarina göre SIRALAYARAK listeyen sorguyu
--yazýnýz. 
 
 SELECT urun_adi, MIN(urun_miktari), MAX(urun_miktari) FROM MANAV ma WHERE urun_adi IS NOT NULL GROUP BY URUN_ADI ORDER BY max(URUN_MIKTARI) DESC ;
  
 /********SIRALAMA AÞAÐIDAKÝ GÝBÝ OLMALI********
  
  =>SELECT FROM
  =>WHERE  1)gruplamadan bazý þartlara göre bazýlarýný ele
  =>GROUP BY 2)özelliklerine göre grupla
  =>HAVÝNG (BÝRAZDAN ÖÐRENÝCEZ)3) grup özelliklerine göre þartla ele. ya where ya having yani
  =>ORDER BY  4) bu gruplarý istenilen özelliðe göre sýrala
  =>Sonrasinda istenilen extra sart var ise "FETCH NEXT 3 ROWS ONLY" */
 
 
--ORNEK4: kisi ismine ve urun adýna (select) göre satýlan ürünlerin (sum)toplamýný
--gruplandýran ve önce isme göre sonra urun_adi na göre ters sýrayla (order by) listeyen sorguyu yazýnýz.
--önce isme göre sonra meyvelere

SELECT isim, urun_adi, sum (urun_miktari) FROM manav GROUP  BY isim, urun_adi ORDER BY isim, urun_adi DESC; -- isim dogal sirali, urun adi ters sirali oldu. Herkesin DESC'i kendine. Ikisi de DESC olabilir.


--ORNEK5: kisi ISMÝNE ve URUN ADINA göre, satýlan ürünlerin toplamýný bulan ve
--** SELECT ISÝM, URUN_ADÝ    SUM(URUN_MÝKTARÝ) GROUP BY ISÝM, URUN_MÝKTARÝ**
--ve bu toplam deðeri 3 ve fazlasý olan kayýtlarý toplam urun miktarlarina göre
--**HAVÝNG SUM(URUN_MÝKTARÝ)>=3      **  ORDER BY SUM(URUN_MÝKTARÝ)
--ters siralayarak listeyen sorguyu yazýnýz.  veli elma 5
--**DESC                                 ali elma 5
--                                       ali armut 4...

SELECT isim, urun_adi, sum (urun_miktari) FROM manav  GROUP BY ISIM ,URUN_ADI HAVING sum (urun_miktari)>=3 ORDER BY sum (urun_miktari) DESC ;
--WHERE sum (urun_miktari)>2  kullanilamiyor cunku tablomuz kendisi orjinalinde bu veriye sahip degil ( where aggregate
--fonksiyonlarý ile kullanilmiyor. Bunun yerine having method'u kullaniliyor.) 
--AGGREGATE (toplama sum, count vs)fonksiyonlarý ile ilgili bir koþul koymak
--için GROUP BY'dan sonra HAVING cümleciði kullanýlýr.

--ORNEK6: satýlan urun_adi'na göre gruplayýp MAX urun sayýlarýný,(yine max ürün sayýsýna göre)
--sýralayarak listeyen sorguyu yazýnýz. NOT: Sorgu, sadece MAKS urun_miktari
--MIN urun_miktarýna eþit olmayan kayýtlarý (where gibi koþul var) listelemelidir.

SELECT urun_adi, MAX(urun_miktari) FROM manav  GROUP BY urun_adi HAVING MAX(URUN_MIKTARI) <> MIN(URUN_MIKTARI) ORDER BY MAX(urun_miktari) DESC ;





/*============================= DISTINCT =====================================
    DISTINCT cümleciði bir SORGU ifadesinde benzer olan satýrlarý flitrelemek
    için kullanýlýr. Dolayýsýyla seçilen sutun yada sutunlar için benzersiz veri
    içeren satýrlar oluþturmaya yarar.
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_adý;  */

--ORNEK1: satýlan farklý meyve türlerinin sayýsýný listeyen sorguyu yazýnýz.
--(kaç farklý meyve türü var, elma armut üzüm=3)

SELECT  COUNT(DISTINCT urun_adi ) AS UrunCesit FROM manav;

--ORNEK2: satýlan meyve ve isimlerin (totalde )farklý olanlarýný listeyen sorguyu yazýnýz.

SELECT DISTINCT isim, urun_adi FROM manav;

--ORNEK3: satýlan meyvelerin urun_mikarlarinin benzersiz  olanlarýnýn
--toplamlarini listeyen sorguyu yazýnýz.2+3+4+5=14

SELECT  sum ( DISTINCT urun_miktari ) FROM MANAV m ;





