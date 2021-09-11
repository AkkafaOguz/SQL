---------SUBQUERY--------------

--Sorgu icinde calisan sorguya subquery (alt sorgu) denilir.

CREATE TABLE personel2
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        sehir VARCHAR2(50),
        maas NUMBER(20),
        sirket VARCHAR2(20)
    );
   
    INSERT INTO personel2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Honda');
    INSERT INTO personel2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'Toyota');
    INSERT INTO personel2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Honda');
    INSERT INTO personel2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Ford');
    INSERT INTO personel2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Hyundai');
    INSERT INTO personel2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Ford');
    INSERT INTO personel2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Honda');
    
   CREATE TABLE sirketler
    (
        sirket_id NUMBER(9),
        sirket_adi VARCHAR2(20),
        personel_sayisi NUMBER(20)
    );
   
    INSERT INTO sirketler VALUES(100, 'Honda', 12000);
    INSERT INTO sirketler VALUES(101, 'Ford', 18000);
    INSERT INTO sirketler VALUES(102, 'Hyundai', 10000);
    INSERT INTO sirketler VALUES(103, 'Toyota', 21000);
    INSERT INTO sirketler VALUES(104, 'Mazda', 17000);
    
  
    SELECT *FROM sirketler;
    SELECT * FROM personel2;
    
   
    --ORNEK1: PERSONEL SAYISI 15.000’den COK OLAN SÝRKETLERÝN ÝSÝMLERÝNÝ (alt sorgu þirketler)ve bu
    --sirkette calisan personelin isimlerini ve maaþlarýný (asýl sorgu personel) listeleyin
   
   SELECT isim, maas, sirket FROM personel2 WHERE sirket IN (SELECT sirket_adi FROM sirketler WHERE personel_sayisi > 15000);

  
  --ORNEK2: sirket_id’si 101’den büyük olan þirket çalýþanlarýnýn isim, maaþ ve
 -- þehirlerini listeleyiniz.
  
  SELECT isim, maas, sehir FROM personel2 WHERE sirket IN (SELECT sirket_adi FROM sirketler WHERE sirket_id > 101);
  
 --ORNEK3: Ankara’da personeli olan þirketlerin þirket id'lerini ve personel
  --sayýlarýný listeleyiniz
 
 SELECT sirket_id, personel_sayisi  FROM sirketler WHERE sirket_adi IN (SELECT sirket FROM personel2 WHERE sehir='Ankara');



/* ===================== AGGREGATE METOT KULLANIMI ===========================
    Aggregate Metotlarý(SUM,COUNT, MIN,MAX, AVG) Subquery içinde kullanýlabilir.
    Ancak, Sorgu tek bir deðer döndürüyor olmalýdýr.
-- *** SELECT den sonra SUBQUERY yazarsak sorgu sonucunun sadece 1 deger getireceginden emin olmaliyiz--SELECT id,isim,maas
                                                                                                        --FROM personel
                                                                                                      --WHERE sirket='Honda';
-- bir tablodan tek deger getirebilmek icin ortalama AVG , toplam SUM, adet COUNT, MIN, MAX  gibi
-- fonksiyonlar kullanilir ve bu fonksiyonlara AGGREGATE FONKSIYONLAR denir
==============================================================================*/



--ORNEK4: Her þirketin ismini, personel sayýsýný ve o þirkete ait personelin
--toplam maaþýný listeleyen bir Sorgu yazýnýz.

SELECT sirket_adi, personel_sayisi, (SELECT SUM(maas) FROM personel2 WHERE sirketler.sirket_adi=personel2.sirket) AS toplam_maas FROM sirketler;

--ORNEK5: Her þirketin ismini, personel sayýsýný ve o þirkete ait personelin
--ortalama maaþýný listeleyen bir Sorgu yazýnýz.

SELECT sirket_adi, personel_sayisi, (SELECT ROUND(AVG(maas)) FROM personel2 WHERE sirket_adi= sirket) AS ortalama_maas FROM sirketler;

--ORNEK6: Her þirketin ismini, personel sayýsýný ve o þirkete ait personelin
--maksimum ve minumum maaþýný listeleyen bir Sorgu yazýnýz.

SELECT sirket_adi, personel_sayisi, (SELECT ROUND(MAX(maas)) FROM personel2 WHERE sirket_adi= sirket) AS max_maas, (SELECT ROUND(MIN(maas)) FROM personel2 WHERE sirket_adi= sirket) AS min_maas FROM sirketler;


--ORNEK7: Her sirketin id’sini, ismini ve toplam kaç þehirde bulunduðunu
--listeleyen bir SORGU yazýnýz.

SELECT sirket_adi, personel_sayisi, (SELECT count(sehir) FROM personel2 WHERE sirket_adi= sirket ) AS sirket_sayisi FROM sirketler;




















 