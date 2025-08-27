
CREATE OR REPLACE FUNCTION ogrenci_bilgi (wanted_id IN NUMBER)
RETURN VARCHAR2
AS 
	current_ad KISI.AD%TYPE;
	current_soyad KISI.SOYAD%TYPE;
	current_kisi_id OGRENCI.KISI_ID%TYPE;
	yazma_sekli NUMBER;
	sonuc_string VARCHAR(220);
BEGIN 
	SELECT DEGER INTO yazma_sekli FROM PARAMETER;
	SELECT KISI_ID INTO current_kisi_id FROM OGRENCI WHERE wanted_id = OGRENCI_ID;
	SELECT AD, SOYAD INTO current_ad, current_soyad FROM KISI WHERE current_kisi_id = KISI_ID;

	IF yazma_sekli = 1 THEN
		sonuc_string:= current_ad || ', ' || current_soyad;
	ELSIF yazma_sekli = 2 THEN
		sonuc_string:= current_soyad || ', ' || current_ad;
	ELSE
		sonuc_string:= 'invalid request';
	END IF;

	RETURN sonuc_string;
END;
/





CREATE OR REPLACE FUNCTION toplam_grade(
  current_sinif_id IN NUMBER,
  current_ogrenci_id IN NUMBER
)
RETURN NUMBER
IS 
  toplamGrade NUMBER := 0;
BEGIN 
  FOR notKayit IN (
    SELECT 
      sinifNot.NOTU AS not_deger,
      notAgirlik.NOT_AGIRLIK AS not_agirlik
    FROM SINIF_OGRENCI sinif_ogrenci
    JOIN SINIF_NOT sinifNot 
      ON sinifNot.SINIF_OGRENCI_ID = sinif_ogrenci.SINIF_OGRENCI_ID
    JOIN NOT_AGIRLIK notAgirlik
      ON sinif_ogrenci.SINIF_ID = notAgirlik.SINIF_ID
     AND sinifNot.NOT_TUR_ID = notAgirlik.NOT_TUR_ID
    WHERE sinif_ogrenci.SINIF_ID = current_sinif_id
      AND sinif_ogrenci.OGRENCI_ID = current_ogrenci_id 
  )
  LOOP 
    toplamGrade := toplamGrade + (notKayit.not_deger * notKayit.not_agirlik);
  END LOOP;

  RETURN toplamGrade;
END;
/




CREATE OR REPLACE FUNCTION harf_notu (
  current_sinif_id IN NUMBER,
  current_not IN NUMBER
)
RETURN VARCHAR2
IS
  harf_result HARF_SKALASI.HARF_SIMGE%TYPE;
  max_alt NUMBER := -1;
BEGIN
  FOR satir IN (
    SELECT HARF_SIMGE, ALT_SINIR
    FROM HARF_SKALASI
    WHERE SINIF_ID = current_sinif_id
  )
  LOOP
    IF current_not >= satir.ALT_SINIR AND satir.ALT_SINIR > max_alt THEN
      max_alt := satir.ALT_SINIR;
      harf_result := satir.HARF_SIMGE;
    END IF;
  END LOOP;

  RETURN harf_result;
END;
/




CREATE OR REPLACE FUNCTION ogrenci_sayac (
  current_sinif_id IN NUMBER
)
RETURN NUMBER
IS
  sayac NUMBER := 0;
  onceki_id NUMBER := -1;
  current_ogrenci_id NUMBER;

  CURSOR cursor_sayac IS
    SELECT OGRENCI_ID
    FROM SINIF_OGRENCI 
    WHERE SINIF_ID = current_sinif_id
    ORDER BY OGRENCI_ID;

BEGIN
  OPEN cursor_sayac;

  LOOP
    FETCH cursor_sayac INTO current_ogrenci_id;
    EXIT WHEN cursor_sayac%NOTFOUND;

    IF current_ogrenci_id != onceki_id THEN
      sayac := sayac + 1;
      onceki_id := current_ogrenci_id;  
    END IF;

  END LOOP;

  CLOSE cursor_sayac;
  RETURN sayac;
END;
/





CREATE OR REPLACE FUNCTION kalan_ogrenci_sayac (
  current_sinif_id IN NUMBER
)
RETURN NUMBER
IS
  sayac NUMBER := 0;
  onceki_id NUMBER := -1;
  current_ogrenci_id NUMBER;

  CURSOR cursor_sayac IS
    SELECT OGRENCI_ID
    FROM SINIF_OGRENCI 
    WHERE SINIF_ID = current_sinif_id
    ORDER BY OGRENCI_ID;

BEGIN
  OPEN cursor_sayac;

  LOOP
    FETCH cursor_sayac INTO current_ogrenci_id;
    EXIT WHEN cursor_sayac%NOTFOUND;

    IF current_ogrenci_id != onceki_id THEN 
      IF harf_notu(current_sinif_id, toplam_grade(current_sinif_id, current_ogrenci_id)) = 'F' THEN
        sayac := sayac + 1;
      END IF;

      onceki_id := current_ogrenci_id;
    END IF;

  END LOOP;

  CLOSE cursor_sayac;
  RETURN sayac;
END;
/


CREATE OR REPLACE FUNCTION basari_orani (
  current_sinif_id IN NUMBER
)
RETURN VARCHAR2
IS
  toplam NUMBER := 0;
  kalan NUMBER := 0;
  gecen NUMBER := 0;
  oran NUMBER := 0;
  oran_str VARCHAR2(20);
BEGIN
  toplam := ogrenci_sayac(current_sinif_id);
  kalan := kalan_ogrenci_sayac(current_sinif_id);
  gecen := toplam - kalan;

  oran := (gecen / toplam) * 100;
  
  oran_str := TO_CHAR(ROUND(oran, 2)) || '%';

  RETURN oran_str;
END;
/


CREATE OR REPLACE FUNCTION sinif_ortalama (
  current_sinif_id IN NUMBER
)
RETURN NUMBER
IS
  toplam_not NUMBER := 0;
  ogrenci_sayisi NUMBER := 0;
  onceki_id NUMBER := -1;
  current_ogrenci_id NUMBER;

  CURSOR cursor_ortalama IS
    SELECT OGRENCI_ID
    FROM SINIF_OGRENCI
    WHERE SINIF_ID = current_sinif_id
    ORDER BY OGRENCI_ID;

BEGIN
  	OPEN cursor_ortalama;

  	LOOP
		FETCH cursor_ortalama INTO current_ogrenci_id;
		EXIT WHEN cursor_ortalama%NOTFOUND;

		IF current_ogrenci_id != onceki_id THEN
		toplam_not := toplam_not + toplam_grade(current_sinif_id, current_ogrenci_id);
		onceki_id := current_ogrenci_id;
		END IF;
  	END LOOP;

  	CLOSE cursor_ortalama;

  	ogrenci_sayisi := ogrenci_sayac(current_sinif_id);

	RETURN toplam_not / ogrenci_sayisi;
 
END;
/

