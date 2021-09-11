-- ============================== DELETE ===================================
    -- DELETE FROM tablo_adý;  Tablonun tüm içerðini siler.
    -- Bu komut bir DML komutudur. Dolayýsýyla devamýnda WHERE gibi cümlecikler
    -- kullanýlabilir.
    -- DELETE FROM tablo_adý
    -- WHERE sutun_adi = veri;
    CREATE TABLE ogrenciler
    (
        id CHAR(3),
        isim VARCHAR2(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3)
    );
    INSERT INTO ogrenciler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO ogrenciler VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO ogrenciler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO ogrenciler VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
	INSERT INTO ogrenciler VALUES(127, 'Mustafa Bak', 'Can',99);
  SAVEPOINT ABC; --ROLLBACK kýsmýnda açýklamasý var
    SELECT * FROM ogrenciler;
     DROP TABLE ogrenciler;
/* =============================================================================
         Seçerek silmek için WHERE Anahtar kelimesi kullanýlabilir.
===============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK1: id'si 124 olan ogrenciyi siliniz.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE id = 124;
/* -----------------------------------------------------------------------------
  ORNEK2: ismi Kemal Yasa olan satýrýný siliniz.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE isim = 'Kemal Yasa';
/* -----------------------------------------------------------------------------
  ORNEK3: ismi Nesibe Yilmaz ve Mustafa Bak olan kayýtlarý silelim.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE isim = 'Nesibe Yilmaz' OR isim = 'Mustafa Bak';
/* ----------------------------------------------------------------------------
  ORNEK4: Ýsmi Ali Can ve id'si 123 olan kaydý siliniz.
 -----------------------------------------------------------------------------*/
     DELETE FROM ogrenciler
     WHERE isim = 'Ali Can' AND id = 123;
/* ----------------------------------------------------------------------------
  ORNEK5: id 'si 126'dan büyük olan kayýtlarý silelim.
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler
    WHERE id>126;
 /* ----------------------------------------------------------------------------
  ORNEK6: id'si 123, 125 ve 126 olanlarý silelim.
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler
    WHERE id IN(123,125,126);
/* ----------------------------------------------------------------------------
  ORNEK7:  TABLODAKÝ TÜM KAYITLARI SÝLELÝM..
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler;
--*************************************************
      -- tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir
-- silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz
-- ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir
/* ======================== DELETE - TRUCATE - DROP ============================
  1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamamýný siler.
    Ancak, seçmeli silme yapamaz. Çünkü Truncate komutu DML deðil DDL komutudur.*/
         TRUNCATE TABLE ogrenciler;  --doðru yazým
   /* 2-) DELETE komutu beraberinde WHERE cümleciði kullanýlabilir. TRUNCATE ile
    kullanýlmaz.
        TRUNCATE TABLE ogrenciler.....yanlýþ yazým
        WHERE veli_isim='Hasan';
-- TRUNCATE komutu tablo yapýsýný deðiþtirmeden,
-- tablo içinde yer alan tüm verileri tek komutla silmenizi saðlar.
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolaylýkla geri
    alýnabilir.
    4-) Truncate ile silinen veriler geri alýnmasý daha zordur. Ancak
    Transaction yöntemi ile geri alýnmasý mümkün olabilir.
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da
    siler. Silinen tablo Veritabanýnýn geri dönüþüm kutusuna gider. Silinen
    tablo aþaðýdaki komut ile geri alýnabilir. Veya SQL GUI'den geri alýnabilir.
     FLASHBACK TABLE tablo_adý TO BEFORE DROP;  -> tabloyu geri alýr.
     PURGE TABLE tablo_adý;        -> Geri dönüþümdeki tabloyu siler.
     DROP TABLE tablo_adý PURGE;  -> Tabloyu tamamen siler
connections da table ý sað týkla =>table=>drop, purge iþaretle, çöp kutusuna
atýlmaksýzýn direk siler.
connections recyle bin sað týkla, purge=>tabloyu tamamen siler. flashback=>
tabloyu geri getirir
==============================================================================*/
    --INSERT veri giriþinden sonra SAVEPOÝNT ABC; ile verileri buraya sakla
    --(yanlýþlýk yapma olasýlýðýna karþýn önlem gibi, AYNI ÝSÝMDE BAÞKA TABLO VARSA)
    --sonra istediðini sil (ister tümü ister bir kýsmý)
    --sonra savepoint yaptýðýn yerden alttaki gibi rollback ile verileri geri getir
    drop table ogrenciler;
    DELETE FROM ogrenciler;  -- Tüm verileri sil.
    ROLLBACK TO ABC;         -- Silinen Verileri geri getir.
    SELECT
        * FROM ogrencýler;
    DROP TABLE ogrenciler;   -- Tabloyu siler ve Veritabanýnýn Çöp kutusuna
                             -- gönderir. (DDL komutudur.)
    -- Çöp kutusundaki tabloyu geri getirir.
    FLASHBACK TABLE ogrenciler TO BEFORE DROP;
    -- Tabloyu tamamen siler (Çöp kutusuna atmaz.)
   
   DROP TABLE ogrenciler PURGE;
    -- PURGE sadece DROP ile silinmis tablolar icin kullanilir
    -- DROP kullanmadan PURGE komutu kullanmak isterseniz
    -- ORA-38302: invalid PURGE option hatasi alirsiniz
    -- Tüm veriler hassas bir þekilde siler.rollback ile geri alýnamaz
    -- PURGE yapmak icin 2 yontem kullanabiliriz
--1 tek satirda DROP ve PURGE beraber kullanabiliriz
DROP TABLE ogrenciler7 PURGE;
-- bu komut ile sildigimiz tabloyu geri getirmek icin FLASHBACK komutunu kullansak
-- ORA-38305: object not in RECYCLE BIN hatasini alirsiniz
-- 2 daha once DROP ile silinmis bir tablo varsa sadece PURGE kullanabiliriz
--Tabloyu yeniden olusturalim
DROP TABLE ogrenciler7;
-- bu asamada istersek FLASHBACK ile tablomuzu geri getirebiliriz
PURGE TABLE ogrenciler7;
-- bu asamada istesem de tabloyu geri getiremem
/* =============================================================================
    Tablolar arasýnda iliþki var ise veriler nasýl silinebilir?
============================================================================= */
/*============================== ON DELETE CASCADE =============================
  Her defasýnda önce child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme özelliðini aktif hale getirebiliriz.
  Bunun için FK olan satýrýn en sonuna ON DELETE CASCADE komutunu yazmak yeterli
==============================================================================*/
    CREATE TABLE talebeler
    (
        id CHAR(3),  --PK
        isim VARCHAR2(50),
        veli_isim VARCHAR2(50),
        yazili_notu NUMBER(3),
        CONSTRAINT talebe_pk PRIMARY KEY (id)
    );
    INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
    INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
	INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
    INSERT INTO talebeler VALUES(126, 'Nesibe Yýlmaz', 'Ayse',95);
	INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
     CREATE TABLE notlar
    (
        talebe_id char(3), --FK
        ders_adi varchar2(30),
        yazili_notu number (3),
        CONSTRAINT notlar_fk FOREIGN KEY (talebe_id)
        REFERENCES talebeler(id) ON DELETE CASCADE --on delete cascade sayesinde
       --parent taki silinen bir kayýt ile iliþkili olan tüm child kayýtlarýný
       --siler.  DELETE FROM talebeleR WHERE id = 124; yaparsak child daki 124 lerde silinir.
       --mesela bir hastane silindi o hastanedeki bütün kayýtlar silinmeli, oda böyle olur.
       --cascade yoksa önce child temizlenir sonra parent
    );
    INSERT INTO notlar VALUES ('123','kimya',75);
    INSERT INTO notlar VALUES ('124', 'fizik',65);
    INSERT INTO notlar VALUES ('125', 'tarih',90);
	INSERT INTO notlar VALUES ('126', 'Matematik',90);
    SELECT * FROM TALEBELER;
    SELECT * FROM NOTLAR;
    DELETE FROM notlar
    WHERE talebe_id = 124;
    DELETE FROM talebeler
    WHERE id = 124;