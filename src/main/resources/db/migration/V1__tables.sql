/*
drop table ILETISIM
/
drop table KISI_GOREV
/
drop table SINIF_NOT
/
drop table SINIF_GUN_SAAT
/
drop table SINIF_OGRENCI
/
drop table SINIF
/
drop table OGRETMEN
/
drop table DERS
/
drop table OGRENCI_DONEM
/
drop table OGRENCI
/
drop table KISI
/
drop table ORG
/
drop table GUN
/
drop table NOT_TUR
/
drop table ORG_TUR
/
drop table DONEM
/
drop table GOREV
/
drop table KIMLIK_TUR
/
drop table CINSIYET
/
drop table ILETISIM_SAHIP_TUR
/
drop table YARIYIL
/
drop table ILETISIM_TUR
/
drop table UYRUK
/
drop table HARF_SKALASI
/
*/


--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Uyruk tablosu
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table UYRUK(
	UYRUK_ID		number(4)			not null,
	UYRUK_ADI		varchar(50)			not null,
	UYRUK_ADI_ASC		varchar(50)			not null,
	constraint		PK_UYRUK 			primary key(UYRUK_ID),
	constraint		UK_UYRUK_UYRUK_ADI_ASC		unique(UYRUK_ADI_ASC)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Adres, telefon no, web siteleri gibi iletisim turleri
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table ILETISIM_TUR(
	ILETISIM_TUR_ID		number(2)			not null,
	ILETISIM_TUR_ADI	varchar(30)			not null,
	constraint		PK_ILETISIM_TUR			primary key(ILETISIM_TUR_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Yariyil tablosu
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table YARIYIL(
	YARIYIL_ID		number(1)			not null,
	YARIYIL_ADI		varchar(20)			not null,
	constraint		PK_YARIYIL 			primary key(YARIYIL_ID)
)
/
--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Iletisim bilgisi tutulan turler. (Kisi,bolum,kampus,fakulte...)
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table ILETISIM_SAHIP_TUR(
	ILETISIM_SAHIP_TUR_ID	number(2) 			not null,
	ILETISIM_SAHIP_TUR_ADI	varchar(50)			not null, -- giris yapilirken trigger ile asc olarak direk tutacağız
	constraint 		PK_ILETISIM_SAHIP_TUR 		primary key(ILETISIM_SAHIP_TUR_ID),
	constraint		UK_ILETISIM_SAHIP_TUR_ADI	unique(ILETISIM_SAHIP_TUR_ADI))
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Cinsiyet tablosu
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table CINSIYET(
	CINSIYET_ID		number(1)			not null constraint CK_CINSIYET_CINSIYET_ID check(CINSIYET_ID in (1, 2, 3)), -- 3 : bilinmiyor
	CINSIYET_ADI		varchar(20)			not null,
	constraint		PK_CINSIYET			primary key(CINSIYET_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Kimlik turleri (yabanci kisiler icin pasaport vs.)
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table KIMLIK_TUR(
	KIMLIK_TUR_ID		number(2)			not null,
	KIMLIK_TUR_ADI		varchar(50)			not null,
	constraint		PK_KIMLIK_TUR			primary key(KIMLIK_TUR_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Gorev turleri
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table GOREV(
	GOREV_ID		number(4)			not null,
	GOREV_ADI		varchar(50)			not null,
	GOREV_ADI_ASC		varchar(50)			not null,
	constraint		PK_GOREV			primary key(GOREV_ID),
	constraint		UK_GOREV_GOREV_ADI_ASC		unique(GOREV_ADI_ASC)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Egitim donemleri
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table DONEM(
	DONEM_ID 		number(4)			not null,
	YARIYIL_ID		number(1)			not null, 
	YIL			number(4)			not null constraint CHECK_DONEM_YIL check(YIL between 2023 and 2400), -- eski yıllar yok olmaz
	BAS_TARIH		date				not null,
	BIT_TARIH		date				not null,
	constraint		PK_DONEM			primary key(DONEM_ID),
	constraint		UK_DONEM_YIL_YARIYIL		unique(YIL,YARIYIL_ID),
	constraint		FK_YARIYIL_DONEM		foreign key(YARIYIL_ID) 	references YARIYIL(YARIYIL_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Universite bunyesinde bulunan organizasyon turleri(kampus,fakulte,bolum,kantin...)
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table ORG_TUR(
	ORG_TUR_ID		number(3)			not null,
	ORG_TUR_ADI		varchar(50)			not null,
	constraint		PK_ORG_TUR			primary key(ORG_TUR_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- ogrencilerin aldigi vize,proje gibi farkli not turleri
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table NOT_TUR(
	NOT_TUR_ID		number(2)			not null,
	NOT_TUR_ADI		varchar(30)			not null,
	constraint 		PK_NOT_TUR			primary key(NOT_TUR_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Haftanin gunleri
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table GUN(
	GUN_ID			number(2)			not null,
	GUN_ADI			varchar(20)			not null,
	GUN_KISA_ADI		varchar(5)			not null,
	GUN_SIRA		number(1)			not null constraint CK_GUN_GUN_SIRA check(GUN_SIRA between 1 and 7),--- Gunun haftadaki sirasi (Turkiye icin Pzt : 1, Sali : 2 ...)
	constraint		PK_GUN				primary key(GUN_ID),
	constraint		UK_GUN_GUN_SIRA			unique(GUN_SIRA)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Agac yapisi ile universite bunyesinde bulunan organizasyonlarin bilgilerini tutar.(kampus,fakulte,bolum,kantin...)
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table ORG(
	ORG_ID			number(4)			not null,
	ORG_KODU		varchar(20)			null,
	ORG_ADI			varchar(70)			not null,
	UST_ORG_ID		number(4)			null,
	ORG_TUR_ID		number(3)			not null,
	ORG_ADI_ASC		varchar(70)			not null,
	ORG_AKTIF		number(1)			not null constraint CK_ORG_ORG_AKTIF check(ORG_AKTIF in(0, 1)), --- 0 : pasif   1: aktif
	constraint 		PK_ORG				primary key(ORG_ID),
	constraint 		UK_ORG_ORG_KODU			unique(ORG_KODU),
	constraint 		FK_ORG_ORG			foreign key(UST_ORG_ID)		references ORG(ORG_ID),
	constraint 		FK_ORG_TUR_ORG			foreign key(ORG_TUR_ID)		references ORG_TUR(ORG_TUR_ID)	
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Kisi bilgilerini tutan tablo
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table KISI(
	KISI_ID			number(9)			not null,
	KIMLIK_TUR_ID		number(2)			not null,
	KIMLIK_NO		varchar(20)			not null,
	AD			varchar(70)			not null,
	SOYAD			varchar(50)			not null,
	CINSIYET_ID		number(1)			not null,
	DOGUM_TARIH		date				not null,
	UYRUK_ID		number(3)			not null,
	AD_ASC			varchar(70)			not null,
	SOYAD_ASC		varchar(50)			not null,
	constraint		PK_KISI				primary key(KISI_ID),
	constraint		UK_KISI_KIMLIK_TUR_IDKIMLIK_NO	unique(KIMLIK_TUR_ID, KIMLIK_NO),
	constraint		FK_KIMLIK_TUR_KISI		foreign key(KIMLIK_TUR_ID)	references KIMLIK_TUR(KIMLIK_TUR_ID),
	constraint		FK_CINSIYET_KISI		foreign key(CINSIYET_ID)	references CINSIYET(CINSIYET_ID),
	constraint		FK_UYRUK_KISI			foreign key(UYRUK_ID)		references UYRUK(UYRUK_ID)	
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- ogrenci bilgilerini tutan tablo
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table OGRENCI(
	OGRENCI_ID		number(8)			not null,
	KISI_ID			number(9)			not null,
	OGRENCI_NO		varchar(20)			not null,
	VELI_KISI_ID		number(9)			null,
	KAYIT_TARIHI		DATE				not null,
	constraint		PK_OGRENCI			primary key(OGRENCI_ID),
	constraint		UK_OGRENCI_OGRENCI_NO		unique(OGRENCI_NO),
	constraint		FK_KISI_OGRENCI			foreign key(KISI_ID)		references KISI(KISI_ID),
	constraint		FK_VELIKISI_OGRENCI		foreign key(VELI_KISI_ID)	references KISI(KISI_ID)	
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- ogrencilerin donem bazinda kayit bilgisini tutan tablo
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table OGRENCI_DONEM(
	OGRENCI_DONEM_ID	number(9)			not null,
	OGRENCI_ID		number(8)			not null,
	DONEM_ID		number(4)			not null,
	constraint		PK_OGRENCI_DONEM		primary key(OGRENCI_DONEM_ID),
	constraint		UK_OGR_DONEM_OGR_ID_DONEM_ID	unique(OGRENCI_ID, DONEM_ID),
	constraint		FK_OGRENCI_OGRENCI_DONEM	foreign key(OGRENCI_ID)		references OGRENCI(OGRENCI_ID),
	constraint		FK_DONEM_OGRENCI_DONEM		foreign key(DONEM_ID)		references DONEM(DONEM_ID)	
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- universitede verilen derslerin bilgilerini tutan tablo
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table DERS(
	DERS_ID			number(4)			not null,
	DERS_KODU		varchar(10)			not null,
	DERS_ADI		varchar(70)			not null,
	ORG_BOLUM_ID		number(4)			not null, 
	DERS_ADI_ASC		varchar(70)			not null,
	KREDI			number(2)			not null, 
	constraint 		PK_DERS				primary key(DERS_ID),
	constraint 		UK_DERS_DERS_ADI_ASC		unique(DERS_ADI_ASC), 
	constraint 		UK_DERS_DERS_KODU		unique(DERS_KODU),
	constraint 		FK_ORG_DERS_BOLUM_ID		foreign key(ORG_BOLUM_ID)	references ORG(ORG_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- ogretmen bilgilerini tutan tablo
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table OGRETMEN(
	OGRETMEN_ID		number(4)			not null,
	KISI_ID			number(9)			not null,
	ORG_OFIS_ID		number(4)			not null,
	constraint		PK_OGRETMEN			primary key(OGRETMEN_ID),
	CONSTRAINTS		UK_OGRETMEN_KISI_ID		unique(KISI_ID),
	constraint		FK_KISI_OGRETMEN_KISI_ID	foreign key(KISI_ID)		references KISI(KISI_ID),
	constraint		FK_ORG_OGRETMEN_OFIS_ID		foreign key(ORG_OFIS_ID)	references ORG(ORG_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Sinif (ders gruplari) bilgilerini tutan tablo
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table SINIF(
	SINIF_ID		number(8)			not null,
	DERS_ID			number(4)			not null,
	DONEM_ID		number(4)			not null,
	OGRETMEN_ID		number(4)			not null,
	ORG_DERSLIK_ID		number(4)			not null, ---- Derslik bilgisi
	KONTENJAN		number				not null,
	constraint		PK_SINIF			primary key(SINIF_ID),
	constraint		FK_DERS_SINIF_DERS_ID		foreign key(DERS_ID)		references DERS(DERS_ID),
	constraint		FK_DONEM_SINIF_DONEM_ID		foreign key(DONEM_ID)		references DONEM(DONEM_ID),
	constraint		FK_OGRETMEN_SINIF_OGRETMEN_ID	foreign key(OGRETMEN_ID)	references OGRETMEN(OGRETMEN_ID),
	constraint		FK_ORG_SINIF_DERSLIK_ID		foreign key(ORG_DERSLIK_ID)	references ORG(ORG_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Derslere kayit olan ogrencilerin siniflara gore listesini tutar.
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table SINIF_OGRENCI(
	SINIF_OGRENCI_ID	number(16)			not null,
	SINIF_ID		number(8)			not null,
	OGRENCI_ID		number(8)			not null,
	constraint		PK_SINIF_OGRENCI		primary key(SINIF_OGRENCI_ID),
	constraint		UK_SINIF_OGRENCI_OGRENCI_ID	unique(SINIF_ID, OGRENCI_ID),
	constraint		FK_SINIF_SINIF_OGRENCI		foreign key(SINIF_ID)		references SINIF(SINIF_ID),
	constraint		FK_OGRENCI_SINIF_OGRENCI	foreign key(OGRENCI_ID)		references OGRENCI(OGRENCI_ID)	
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Ders takvimine iliskin bilgileri tutar.
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table SINIF_GUN_SAAT(
	SINIF_GUN_SAAT_ID	number(9)			not null,
	SINIF_ID		number(8)			not null,
	GUN_ID			number(2)			not null,
	BAS_SAAT		date				not null,
	SURE			number(3)	default(50)	not null constraint CK_SINIF_GUN_SAAT_SURE	check(SURE between 0 and 60),
	constraint		PK_SINIF_GUN_SAAT		primary key(SINIF_GUN_SAAT_ID),
	constraint		UK_SINIF_GUN_ID_SAAT		unique(SINIF_ID, GUN_ID, BAS_SAAT),
	constraint		FK_SINIF_SINIF_GUN_SAAT		foreign key(SINIF_ID)		references SINIF(SINIF_ID),
	constraint		FK_GUN_SINIF_GUN_SAAT		foreign key(GUN_ID)		references GUN(GUN_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- ogrencilerin derslerden aldiklari notlari tutar.
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table SINIF_NOT(
	SINIF_NOT_ID		number(18)			not null,
	TARIH			DATE				not null,
	SINIF_OGRENCI_ID	number(16) 			not null,
	NOT_TUR_ID		number(2)			not null,
	NOTU			number(5,2)			not null constraint CHECK_NOTLAR_NOT_ARALIK	check(NOTU between 0 and 100),
	constraint		PK_SINIF_NOT			primary key(SINIF_NOT_ID),
	constraint		UK_TARIH_SINIFOGRENCI_NOTTUR	unique(TARIH, SINIF_OGRENCI_ID, NOT_TUR_ID),
	constraint		FK_SINIF_OGRENCI_SINIF_NOT	foreign key(SINIF_OGRENCI_ID)	references SINIF_OGRENCI(SINIF_OGRENCI_ID),
	constraint		FK_NOT_TUR_SINIF_NOT		foreign key(NOT_TUR_ID)		references NOT_TUR(NOT_TUR_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Kisilerin gorevleriyle ilgili bilgileri barindiran tablo
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table KISI_GOREV(
	KISI_GOREV_ID		number(13)			not null,
	KISI_ID			number(9)			not null,
	GOREV_ID		number(4)			not null,
	ORG_ID			number(4)			not null,
	BAS_TARIH		date				not null,
	BIT_TARIH		date				null,
	constraint		PK_KISI_GOREV_ID		primary key(KISI_GOREV_ID),
	constraint		UK_KISI_GOREV_TARIH		unique(KISI_ID, GOREV_ID, BAS_TARIH),
	constraint		FK_KISI_KISI_GOREV		foreign key(KISI_ID)	references KISI(KISI_ID),
	constraint		FK_GOREV_KISI_GOREV		foreign key(GOREV_ID)	references GOREV(GOREV_ID),
	constraint		FK_ORG_KISI_GOREV		foreign key(ORG_ID)	references ORG(ORG_ID)
)
/

--------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
--- Kisi ve organizasyonlarin cesitli iletisim bilgilerini tutar.
---------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------
create table ILETISIM(
	ILETISIM_ID		number(13)			not null,
	ILETISIM_SAHIP_TUR_ID	number(2)			not null,
	ILETISIM_SAHIP_PK_ID	number(10)			not null,
	ILETISIM_TUR_ID		number(2)			not null,
	TERCIH_SIRA_NO		number(1)	default(1)	not null, ----Ayni kisi veya organizasyon icin, ayni turde birden fazla iletisim bilgisi bulunuyor ise, bunlarin tercih sirasi.
	ILETISIM_BILGI		varchar(500)			not null,
	ORG_ID			number(4)			null,
	BAS_TARIH		date				not null,
	BIT_TARIH		date				null,
	AKTIF			number(1)	default(1)	not null constraint CK_ILETISIM_AKTIF	check(AKTIF in (0,1)),
	constraint		PK_ILETISIM			primary key(ILETISIM_ID),
	constraint		UK_IL_TURID_ILSAHIPPKID_TERNO	unique(ILETISIM_SAHIP_TUR_ID, ILETISIM_SAHIP_PK_ID, ILETISIM_TUR_ID, TERCIH_SIRA_NO, AKTIF),
	constraint		FK_ILETISIM_SAHIP_TUR_ILETISIM	foreign key(ILETISIM_SAHIP_TUR_ID)	references ILETISIM_SAHIP_TUR(ILETISIM_SAHIP_TUR_ID),
	constraint		FK_ILETISIM_TUR_ILETISIM	foreign key(ILETISIM_TUR_ID)		references ILETISIM_TUR(ILETISIM_TUR_ID),
	constraint		FK_ORG_ILETISIM			foreign key(ORG_ID)			references ORG(ORG_ID)	
)
/


--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--- Derslerin notlandırma ağırlıklarını tutar.
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
create table  NOT_AGIRLIK(
	NOT_AGIRLIK_ID		number(8)			not null,
	SINIF_ID		number(8)			not null,
	NOT_TUR_ID		number(2)			not null,
	NOT_AGIRLIK		number(3,2)			not null constraint CK_NOT_AGIRLIK	check(NOT_AGIRLIK between 0 and 1),
	constraint		PK_NOT_AGIRLIK			primary key(NOT_AGIRLIK_ID),
	constraint		UK_SINIF_NOT_TUR		unique(SINIF_ID, NOT_TUR_ID),
	constraint		FK_SINIF_NOT_AGIRLIK		foreign key(SINIF_ID)		references SINIF(SINIF_ID),
	constraint		FK_NOT_TUR_NOT_AGIRLIK		foreign key(NOT_TUR_ID)		references NOT_TUR(NOT_TUR_ID)
)
/

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--- Dogum gunu vb. olan kişilerin iletişim bilgileri
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
create table MAIL_SMS_GONDERIM
(
  MAIL_SMS_ID     NUMBER not null,
  KISI_ID         NUMBER not null,
  ILETISIM_TUR_ID NUMBER not null,
  ILETISIM_BILGI  VARCHAR2(500) not null,
  MESAJ           VARCHAR2(500),
  DURUM           NUMBER default (0) not null,
  constraint PK_MAIL_SMS	primary key(MAIL_SMS_ID)
)
/


--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--- Harf Notları için Skala
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
create table HARF_SKALASI
(
  SKALA_ID     	NUMBER not null,
  SINIF_ID     	NUMBER not null,
  HARF_SIMGE 	VARCHAR(2) not null,
  ALT_SINIR  	NUMBER not null,
  constraint 	PK_SKALA			primary key(SKALA_ID)
  constraint	FK_SINIF_SKALA			foreign key(SINIF_ID)		references SINIF(SINIF_ID),
)
/