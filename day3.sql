CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE,
maas int NOT NULL,
ise_baslama DATE
);
CREATE TABLE calisanlar2(
id CHAR(5),
isim VARCHAR(50),
maas int NOT NULL,
ise_baslama DATE,
CONSTRAINT pk_id PRIMARY KEY(id),
CONSTRAINT ism_unq UNIQUE(isim)
);
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14');--Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12');--NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14');--Unique
--INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');--Not Null
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14');--primary key
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14');--primary key
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14');--primary key
select * from calisanlar
-- FOREİGN KEY
cREATE TABLE ADRESLER(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),	
sehir varchar(20),
constraint id_fk foreign key (adres_id) references calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');
--Parent tabloda olmayan id ile child tabloya ekleme yapamayız
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
--Calisanlar id ile adresler tablosundaki adres_id ile eşleşenlere bakmak için
select * from calisanlar,adresler WHERE calisanlar.id=adresler.adres_id;
Drop table calisanlar
-- Parent tabloyu yani primary key olan tabloyu silmek istediğimizde tabloyu silmez
--Önce child tabloyu silmemiz gerekir
delete from calisanlar where id=10002 -- parent
delete from adresler where adres_id='10002' -- child
drop table calisanlar;
-- on delete cascade --
--her defasında önce child tablodaki verileri silmek yerine
-- on delete cascade silme özelliğini aktif hale getirebiliriz
--Bunun için FK olan satırın en sonuna ON DELETE CASCADE komutunu yazmamız yeterli
CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);
INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);
CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);
INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);
select * from talebeler
select * from notlar
delete from notlar where talebe_id ='123'
delete from talebeler where id ='126' -- ON DELETE CASCADE kullandığımız için PARENT table dan direkt silebildik
-- PArent table dan sildiğimiz için child table dan da silinmiş olur
delete from talebeler
drop table talebeler cascade --parent tabloyu kaldırmak sitersek drop table tablo_adı ndan sonra cascade komutunu kullanırız

-- talebeler tablosundaki isim sütununa not null kısıtlması ekleyiniz ve veri tipini varchar(30) olarak değiştiriniz
alter table talebeler
alter column isim TYPE VARCHAR(30),
alter column isim SET NOT NULL;
--talebeler tablosundaki yazılı_notu kısmına 60 dan buyuk rakam gırılebılsın
alter table talebeler
ADD CONSTRAINT sinir CHECK (yazili_notu>60);
--CHECK kısıtlaması ile tablodaki istedigimiz sütunu sınırlandırabılırız
 -- yukarda 60'i sinir olarak belirledigimiz icin bunu eklemedi

INSERT INTO talebeler VALUES(128,'Mustafa Can','Hasan',45);

create table ogrenciler(
id int,
isim varchar(45),
adres varchar(100),
sinav_notu int
);
Create table ogrenci_adres
AS
SELECT id, adres from ogrenciler;
select * from ogrenciler
select * from ogrenci_adres
-- tablodaki bir sutuna PRIMARY KEY ekle
alter table ogrenciler
ADD PRIMARY KEY(id);
--PRIMARY KEY oluşturmada 2.yol
alter table ogrenciler
ADD CONSTRAINT pk_id PRIMARY KEY(id);

--PK den sonra FK ataması
alter table ogrenci_adres
ADD foreign key (id) REFERENCES ogrenciler;
--Child tabloyu parent tablodan olusturdugumuz ıcın sutun adı verılmedı

--pk yı sılme CONSTRAINT silme 
alter table ogrenciler DROP CONSTRAINT pk_id;
--FK yı sılme CONTRAINT SİLME
alter table ogrenci_adres DROP CONSTRAINT ogrenci_adres_id_fkey;

-- Yazılı notu 85 den büyük olan talebe bilgilerini getirin
select * from talebeler WHERE yazili_notu>85;

-- ismi Mustafa Bak olan talebenın tüm bilgilerini getirin

select * from talebeler WHERE isim='Mustafa Bak'

--SELECT komutunda --BETWEEN kosulu 
--BETween belirttiginiz iki veri arasındaki bilgileri listeler
--Between de belirttiginz degerlerde listelemeye dahıldır
create table personel
(
id char(4),
isim varchar(50),
maas int
);
insert into personel values('1001', 'Ali Can', 70000);
insert into personel values('1002', 'Veli Mert', 85000);
insert into personel values('1003', 'Ayşe Tan', 65000);
insert into personel values('1004', 'Derya Soylu', 95000);
insert into personel values('1005', 'Yavuz Bal', 80000);
insert into personel values('1006', 'Sena Beyaz', 100000);
SELECT * FROM personel
/*
AND(VE):Belirtilen şartların her ikisi de gerceklesıyors o kayıt lıstelenır
bir tanesı gerceklesmezse listelenmez
select  from matematik sinav1>50 AND sinav2>50
hem sınav1 hem de sinav2 alanı 50 den buyuk olan kayıtları lısteler
OR(veya): belirtılen sartlardan bırı gerceklesırse , kayıt listelenir
select  from matematık_sınav>50 OR sınav2>50
sınav1 veya sınav2 alanı 50 den buyuk olan kayıtları lısteler*\


-- id si 1003 ıle 1005 arasında olan personel bılgısını lısteleyınız

select * from personel WHERE id BETWEEN '1003' and '1005';

--2.yol
select * from personel WHERE id>='1003' and id<='1005';

--DERya Soylu ile Yavuz Bal arasındakı personel bilgisini listeleyiniz
select * from personel WHERE isim between 'Derya Soylu' AND 'Yavuz Bal'-- isimden cagırınca hata alabılırız arasında ısım yok cunku

-- maası 70000 veya ismi Sena olan personelı lıstele
select * from persone WHERE maas=70000 or isim='SENA'

--IN :birden fazla mantıksal ıfade ıle tanımlayabılecegımız durumları tek komutta yazabılme ımkanı verır
--farklı sutunları ıcın ın kullanılamaz

-- id si 1001,1002,1004 olan personelın bılgılerını lıstele
select * from personel WHERE id='1001' or id='1002' or id='1004';

--2. yol
select * from personel WHERE id IN ('1001','1002','1004');

--MAAsı sadece 70000,100000 olan personelı lıstele
select * from personel WHERE id maas IN (70000,100000);-- ınt old ıcın tırnak ıcınde yazmadık

/*
SELECT - LIKE koşulu
LIKE : Sorgulama yaparken belirli kalıp ifadeleri kullanabılmemızı saglar
ILIKE : SORGULAMA yaparken buyuk/ kucuk harfe duyarsız olarak eslestırır
LIKE :~~
ILIKE:~~
NOT LIKE :!~~
NOT ILIKE :!~~*
%--> 0 veya daha fazla karekteerı belırtır
_  (alt cızgı)--> tek bır karekterı belırıtr

*\

-- ısmı A harfı ıle baslayan personelı lıstele
select * from personel WHERE isim like 'A%'; -- sonu ne olursa olsun a ıle baslasın

-- ısmı t harfı ıle biten personelı lıstele
select * from personel WHERE isim like '%t'; -- basında ne olursaolsun sonu t ıle bıtsın

-- ısmının ıkıncı harfı e olan personelı lıstele
SELECT * FROM  personel WHERE isim LIKE '_e%'; -- _ ILK HARFI TEMSIL EDIYOR 2. E SONU DA NE OLURSA OLSUN






