/*============================ GROUP BY =====================================
    GROUP BY c�mleci�i bir SELECT ifadesinde sat�rlar�, sutunlar�n de�erlerine
    g�re �zet olarak gruplamak i�in kullan�l�r.
    GROUP BY c�mlece�i her grup ba��na bir sat�r d�nd�r�r.
    GROUP BY genelde, AVG(),COUNT(),MAX(),MIN() ve SUM() gibi aggregate
    fonksiyonlar� ile birlikte kullan�l�r.*/


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
    
    
--ORNEK1: kisi ismine g�re sat�lan toplam meyve miktarlar�n� g�steren sorguyu
--yaz�n�z. ali=>5+2+2+2 sum= meyve say�lar�n� toplucak
   
   SELECT isim, sum(urun_miktari) AS ToplamMeyve FROM manav GROUP BY isim;
  
--ORNEK2: sat�lan meyve t�r�ne (urun_adi) g�re urun alan ki�i say�s�n� g�steren
--sorguyu yaz�n�z. NULL olarak girilen meyveyi listelemesin.count= elma alan ki�ileri sayacak  
  
  SELECT urun_adi, COUNT (isim) AS AlanKisiSayisi FROM manav WHERE urun_adi IS NOT NULL GROUP BY urun_adi;
 
--ORNEK3: sat�lan meyve t�r�ne (URUN_AD�) g�re sat�lan (urun_miktari )MIN ve
--MAX urun miktarlarini, MAX urun miktarina g�re SIRALAYARAK listeyen sorguyu
--yaz�n�z. 
 
 SELECT urun_adi, MIN(urun_miktari), MAX(urun_miktari) FROM MANAV ma WHERE urun_adi IS NOT NULL GROUP BY URUN_ADI ORDER BY max(URUN_MIKTARI) DESC ;
  
 /********SIRALAMA A�A�IDAK� G�B� OLMALI********
  
  =>SELECT FROM
  =>WHERE  1)gruplamadan baz� �artlara g�re baz�lar�n� ele
  =>GROUP BY 2)�zelliklerine g�re grupla
  =>HAV�NG (B�RAZDAN ��REN�CEZ)3) grup �zelliklerine g�re �artla ele. ya where ya having yani
  =>ORDER BY  4) bu gruplar� istenilen �zelli�e g�re s�rala
  =>Sonrasinda istenilen extra sart var ise "FETCH NEXT 3 ROWS ONLY" */
 
 
--ORNEK4: kisi ismine ve urun ad�na (select) g�re sat�lan �r�nlerin (sum)toplam�n�
--grupland�ran ve �nce isme g�re sonra urun_adi na g�re ters s�rayla (order by) listeyen sorguyu yaz�n�z.
--�nce isme g�re sonra meyvelere

SELECT isim, urun_adi, sum (urun_miktari) FROM manav GROUP  BY isim, urun_adi ORDER BY isim, urun_adi DESC; -- isim dogal sirali, urun adi ters sirali oldu. Herkesin DESC'i kendine. Ikisi de DESC olabilir.


--ORNEK5: kisi ISM�NE ve URUN ADINA g�re, sat�lan �r�nlerin toplam�n� bulan ve
--** SELECT IS�M, URUN_AD�    SUM(URUN_M�KTAR�) GROUP BY IS�M, URUN_M�KTAR�**
--ve bu toplam de�eri 3 ve fazlas� olan kay�tlar� toplam urun miktarlarina g�re
--**HAV�NG SUM(URUN_M�KTAR�)>=3      **  ORDER BY SUM(URUN_M�KTAR�)
--ters siralayarak listeyen sorguyu yaz�n�z.  veli elma 5
--**DESC                                 ali elma 5
--                                       ali armut 4...

SELECT isim, urun_adi, sum (urun_miktari) FROM manav  GROUP BY ISIM ,URUN_ADI HAVING sum (urun_miktari)>=3 ORDER BY sum (urun_miktari) DESC ;
--WHERE sum (urun_miktari)>2  kullanilamiyor cunku tablomuz kendisi orjinalinde bu veriye sahip degil ( where aggregate
--fonksiyonlar� ile kullanilmiyor. Bunun yerine having method'u kullaniliyor.) 
--AGGREGATE (toplama sum, count vs)fonksiyonlar� ile ilgili bir ko�ul koymak
--i�in GROUP BY'dan sonra HAVING c�mleci�i kullan�l�r.

--ORNEK6: sat�lan urun_adi'na g�re gruplay�p MAX urun say�lar�n�,(yine max �r�n say�s�na g�re)
--s�ralayarak listeyen sorguyu yaz�n�z. NOT: Sorgu, sadece MAKS urun_miktari
--MIN urun_miktar�na e�it olmayan kay�tlar� (where gibi ko�ul var) listelemelidir.

SELECT urun_adi, MAX(urun_miktari) FROM manav  GROUP BY urun_adi HAVING MAX(URUN_MIKTARI) <> MIN(URUN_MIKTARI) ORDER BY MAX(urun_miktari) DESC ;





/*============================= DISTINCT =====================================
    DISTINCT c�mleci�i bir SORGU ifadesinde benzer olan sat�rlar� flitrelemek
    i�in kullan�l�r. Dolay�s�yla se�ilen sutun yada sutunlar i�in benzersiz veri
    i�eren sat�rlar olu�turmaya yarar.
    SYNTAX
    -------
    SELECT DISTINCT sutun_adi1, sutun_adi2, satin_adi3
    FROM  tablo_ad�;  */

--ORNEK1: sat�lan farkl� meyve t�rlerinin say�s�n� listeyen sorguyu yaz�n�z.
--(ka� farkl� meyve t�r� var, elma armut �z�m=3)

SELECT  COUNT(DISTINCT urun_adi ) AS UrunCesit FROM manav;

--ORNEK2: sat�lan meyve ve isimlerin (totalde )farkl� olanlar�n� listeyen sorguyu yaz�n�z.

SELECT DISTINCT isim, urun_adi FROM manav;

--ORNEK3: sat�lan meyvelerin urun_mikarlarinin benzersiz  olanlar�n�n
--toplamlarini listeyen sorguyu yaz�n�z.2+3+4+5=14

SELECT  sum ( DISTINCT urun_miktari ) FROM MANAV m ;





