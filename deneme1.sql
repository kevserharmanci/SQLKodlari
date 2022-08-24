CREATE table musteri(
musteri_no int,
musteri_isim varchar(30),
musteri_telefonNo char(11)
);
CREATE TABLE telefon_no
AS select musteri_telefonNo,musteri_isim from musteri;
select *from musteri;
select *from telefon_no;
create table ogrenci(
ogrenci_listSira serial,    
ogrenci_no int,
ogrenci_isimSoyisim varchar(20),
ogrenci_veli varchar(20),
ogrenci_notOrtalamasi real
);
create table bursAlanlar
as select ogrenci_no,ogrenci_isimSoyisim,ogrenci_notOrtalamasi from ogrenci;
select *from ogrenci;
select *from bursAlanlar;
Insert into ogrenci values(default,10,'Ali Can','Veli Can',55.5);
Insert into ogrenci values(default,11,'Mehmet','Ahmet',99);
Insert into ogrenci values(default,12,'Enes','Emre',75.5);
Insert into ogrenci(ogrenci_isimSoyisim,ogrenci_notOrtalamasi) values('Ayse yilmaz',85.9);
select ogrenci_no from ogrenci;
select * from ogrenci where ogrenci_notOrtalamasi<80;
delete from ogrenci;
Begin;
insert into ogrenci VALUES (default,13,'Ali Can','Hasan Can',75.5);
insert into ogrenci VALUES (default,14, 'Canan Gül','Ayşe Şen',90.5);
savepoint x;
insert into ogrenci VALUES (default,15,'Kemal Can','Ahmet Can',85.5);
insert into ogrenci VALUES (default,16,'Ahmet Şen','Ayşe Can',65.5);
ROLLBACK TO x;
select * from ogrenci;
commit;
delete from ogrenci where ogrenci_notOrtalamasi=65.5;
Truncate table ogrenci;
--ogrenci tablomuza cinsiyet ve yas ekleyelim 
alter table ogrenci add cinsiyet varchar(20), add yas int;
alter table ogrenci drop column yas;
alter table ogrenci rename column ogrenci_isimSoyisim to ogr_isim;
alter table ogrenci rename to student;
select * from student;
drop table student;
CREATE TABLE calisanlar
(
id CHAR(5) PRIMARY KEY, -- not null + unique
isim VARCHAR(50) UNIQUE, -- UNIQUE --> Bir sutundaki tüm değerlerin BENZERSİZ yani tek olmasını sağlar
maas int NOT NULL, -- NOT NULL --> Bir sutunun NULL içermemesini yani boş olmamasını sağlar
ise_baslama DATE
);
select * from calisanlar;
INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); --Unique
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --NOT NULL
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --UNIQUE
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --NOT NULL
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); -- PRIMARY KEY
select * from calisanlar;
-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;
-- FOREIGN KEY--
CREATE TABLE adresler
(
adres_id char(5),
sokak varchar(20),
cadde varchar(30),
sehir varchar(20),
CONSTRAINT id_fk FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);
INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');
select * from adresler;
delete from adresler where adres_id='10003';
--primary key'in ikici olusturma yolu
CREATE TABLE calisanlar1
(
id CHAR(5), -- not null + unique
isim VARCHAR(50) UNIQUE,--UNIQUE --> Bir sutundaki tum degerlerin BENZERSIZ/tek olmasini saglar
maas int NOT NULL,--NUT NULL -->Bir sutunun NULL icermemesini,Bos olmamasini saglar
ise_baslama DATE,
constraint prima primary key (id)
);
