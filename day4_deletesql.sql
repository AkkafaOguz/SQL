-- ============================== DELETE ===================================
    -- DELETE FROM tablo_ad�;  Tablonun t�m i�er�ini siler.
    -- Bu komut bir DML komutudur. Dolay�s�yla devam�nda WHERE gibi c�mlecikler
    -- kullan�labilir.
    -- DELETE FROM tablo_ad�
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
  SAVEPOINT ABC; --ROLLBACK k�sm�nda a��klamas� var
    SELECT * FROM ogrenciler;
     DROP TABLE ogrenciler;
/* =============================================================================
         Se�erek silmek i�in WHERE Anahtar kelimesi kullan�labilir.
===============================================================================*/
/* -----------------------------------------------------------------------------
  ORNEK1: id'si 124 olan ogrenciyi siliniz.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE id = 124;
/* -----------------------------------------------------------------------------
  ORNEK2: ismi Kemal Yasa olan sat�r�n� siliniz.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE isim = 'Kemal Yasa';
/* -----------------------------------------------------------------------------
  ORNEK3: ismi Nesibe Yilmaz ve Mustafa Bak olan kay�tlar� silelim.
 -----------------------------------------------------------------------------*/
      DELETE FROM ogrenciler
      WHERE isim = 'Nesibe Yilmaz' OR isim = 'Mustafa Bak';
/* ----------------------------------------------------------------------------
  ORNEK4: �smi Ali Can ve id'si 123 olan kayd� siliniz.
 -----------------------------------------------------------------------------*/
     DELETE FROM ogrenciler
     WHERE isim = 'Ali Can' AND id = 123;
/* ----------------------------------------------------------------------------
  ORNEK5: id 'si 126'dan b�y�k olan kay�tlar� silelim.
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler
    WHERE id>126;
 /* ----------------------------------------------------------------------------
  ORNEK6: id'si 123, 125 ve 126 olanlar� silelim.
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler
    WHERE id IN(123,125,126);
/* ----------------------------------------------------------------------------
  ORNEK7:  TABLODAK� T�M KAYITLARI S�LEL�M..
 -----------------------------------------------------------------------------*/
    DELETE FROM ogrenciler;
--*************************************************
      -- tablodaki kayitlari silmek ile tabloyu silmek farkli islemlerdir
-- silme komutlari da iki basamaklidir, biz genelde geri getirilebilecek sekilde sileriz
-- ancak bazen guvenlik gibi sebeplerle geri getirilmeyecek sekilde silinmesi istenebilir
/* ======================== DELETE - TRUCATE - DROP ============================
  1-) TRUNCATE komutu DELETE komutu gibi bir tablodaki verilerin tamam�n� siler.
    Ancak, se�meli silme yapamaz. ��nk� Truncate komutu DML de�il DDL komutudur.*/
         TRUNCATE TABLE ogrenciler;  --do�ru yaz�m
   /* 2-) DELETE komutu beraberinde WHERE c�mleci�i kullan�labilir. TRUNCATE ile
    kullan�lmaz.
        TRUNCATE TABLE ogrenciler.....yanl�� yaz�m
        WHERE veli_isim='Hasan';
-- TRUNCATE komutu tablo yap�s�n� de�i�tirmeden,
-- tablo i�inde yer alan t�m verileri tek komutla silmenizi sa�lar.
    3-) Delete komutu ile silinen veriler ROLLBACK Komutu ile kolayl�kla geri
    al�nabilir.
    4-) Truncate ile silinen veriler geri al�nmas� daha zordur. Ancak
    Transaction y�ntemi ile geri al�nmas� m�mk�n olabilir.
    5-) DROP komutu da bir DDL komutudur. Ancak DROP veriler ile tabloyu da
    siler. Silinen tablo Veritaban�n�n geri d�n���m kutusuna gider. Silinen
    tablo a�a��daki komut ile geri al�nabilir. Veya SQL GUI'den geri al�nabilir.
     FLASHBACK TABLE tablo_ad� TO BEFORE DROP;  -> tabloyu geri al�r.
     PURGE TABLE tablo_ad�;        -> Geri d�n���mdeki tabloyu siler.
     DROP TABLE tablo_ad� PURGE;  -> Tabloyu tamamen siler
connections da table � sa� t�kla =>table=>drop, purge i�aretle, ��p kutusuna
at�lmaks�z�n direk siler.
connections recyle bin sa� t�kla, purge=>tabloyu tamamen siler. flashback=>
tabloyu geri getirir
==============================================================================*/
    --INSERT veri giri�inden sonra SAVEPO�NT ABC; ile verileri buraya sakla
    --(yanl��l�k yapma olas�l���na kar��n �nlem gibi, AYNI �S�MDE BA�KA TABLO VARSA)
    --sonra istedi�ini sil (ister t�m� ister bir k�sm�)
    --sonra savepoint yapt���n yerden alttaki gibi rollback ile verileri geri getir
    drop table ogrenciler;
    DELETE FROM ogrenciler;  -- T�m verileri sil.
    ROLLBACK TO ABC;         -- Silinen Verileri geri getir.
    SELECT
        * FROM ogrenc�ler;
    DROP TABLE ogrenciler;   -- Tabloyu siler ve Veritaban�n�n ��p kutusuna
                             -- g�nderir. (DDL komutudur.)
    -- ��p kutusundaki tabloyu geri getirir.
    FLASHBACK TABLE ogrenciler TO BEFORE DROP;
    -- Tabloyu tamamen siler (��p kutusuna atmaz.)
   
   DROP TABLE ogrenciler PURGE;
    -- PURGE sadece DROP ile silinmis tablolar icin kullanilir
    -- DROP kullanmadan PURGE komutu kullanmak isterseniz
    -- ORA-38302: invalid PURGE option hatasi alirsiniz
    -- T�m veriler hassas bir �ekilde siler.rollback ile geri al�namaz
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
    Tablolar aras�nda ili�ki var ise veriler nas�l silinebilir?
============================================================================= */
/*============================== ON DELETE CASCADE =============================
  Her defas�nda �nce child tablodaki verileri silmek yerine ON DELETE CASCADE
  silme �zelli�ini aktif hale getirebiliriz.
  Bunun i�in FK olan sat�r�n en sonuna ON DELETE CASCADE komutunu yazmak yeterli
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
    INSERT INTO talebeler VALUES(126, 'Nesibe Y�lmaz', 'Ayse',95);
	INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
     CREATE TABLE notlar
    (
        talebe_id char(3), --FK
        ders_adi varchar2(30),
        yazili_notu number (3),
        CONSTRAINT notlar_fk FOREIGN KEY (talebe_id)
        REFERENCES talebeler(id) ON DELETE CASCADE --on delete cascade sayesinde
       --parent taki silinen bir kay�t ile ili�kili olan t�m child kay�tlar�n�
       --siler.  DELETE FROM talebeleR WHERE id = 124; yaparsak child daki 124 lerde silinir.
       --mesela bir hastane silindi o hastanedeki b�t�n kay�tlar silinmeli, oda b�yle olur.
       --cascade yoksa �nce child temizlenir sonra parent
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