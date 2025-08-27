CREATE OR REPLACE PROCEDURE get_next_id (
  current_tablo_ad IN VARCHAR2, 
  current_field_name IN VARCHAR2,
  next_id OUT NUMBER
)
IS
BEGIN
  SELECT LAST_VALUE INTO next_id
  FROM SEQ
  WHERE TABLO_ADI = current_tablo_ad AND FIELD_NAME = current_field_name
  FOR UPDATE; --satiri kitliyor (farklı kullanıcılardan aynı anda insert olması ihtimali)

  next_id := next_id + 1;

  UPDATE SEQ
  SET LAST_VALUE = next_id
  WHERE TABLO_ADI = current_tablo_ad AND FIELD_NAME = current_field_name;
END;
/