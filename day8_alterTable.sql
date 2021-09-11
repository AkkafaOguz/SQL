/*=============================== ALTER TABLE ==================================
    --iç kaporta için UPDATE (DML), dýþ kaporta için ALTER (DDL)
    ALTER TABLE  tabloda ADD, MODIFY, veya DROP/DELETE COLUMNS islemleri icin
    kullanilir.
    ALTER TABLE ifadesi tablolari yeniden isimlendirmek (RENAME) icin de
    kullanilir.
==========================================================*/


CREATE TABLE personel
    (
        id NUMBER(9),
        isim VARCHAR2(50),
        sehir VARCHAR2(50),
        maas NUMBER(20),
        sirket VARCHAR2(20)
    );
   
   DROP TABLE PERSONEL;
   
    INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
    INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
    INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
    INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
    INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
    INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');

   /* -----------------------------------------------------------------------------
  ORNEK1: personel tablosuna ulke_isim adinda ve default degeri 'Turkiye' olan
  yeni bir sutun ekleyiniz.
------------------------------------------------------------------------------*/
   
   ALTER TABLE PERSONEL ADD ulke_isim varchar(20) DEFAULT 'TURKIYE';
   
  SELECT * FROM PERSONEL p ;
  
 
--ORNEK2: personel tablosuna cinsiyet Varchar2(20) ve yas Number(3) seklinde
--yeni sutunlar ekleyiniz.
------------------------------------------------------

  ALTER TABLE PERSONEL ADD (cinsiyet varchar(20), yas number(3));
  
--ORNEK3: personel tablosundan yas sutununu siliniz.
 
 ALTER TABLE PERSONEL DROP COLUMN yas;
 
--ORNEK4: personel tablosundaki ulke_isim sutununun adini ulke_adi olarak degistiriniz.

ALTER TABLE PERSONEL RENAME COLUMN ulke_isim TO ulke_adi;


--ORNEK5: personel tablosunun adini isciler4 olarak degistiriniz.
----------------------------------------------------------------

ALTER TABLE personel RENAME TO isciler4;

SELECT * FROM isciler4;


--ORNEK6: isciler tablosundaki ulke_adi sutununa NOT NULL kisitlamasi ekleyiniz.
-----------------------------------------------------------------

ALTER TABLE isciler4 MODIFY ulke_adi NOT NULL;

--ORNEK7: Maas'u unique yap

ALTER TABLE isciler4 MODIFY maas UNIQUE; --tekrarli maaslar oldugu icin UNIQUE kullanamayiz.

--Ornek8: Check kisitlamasi ile maas sarti ekle

ALTER TABLE isciler4 MODIFY maas CHECK (maas>3000);

INSERT INTO isciler4 VALUES(456715012, 'Ali Sahin', 'Ankara', 2500, 'Ford'); --SQL Error [947] [42000]: ORA-00947: not enough values

--Omer Bulut


