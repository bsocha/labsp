--1) widok 1
IF EXISTS (SELECT * FROM SYS.views WHERE name='Mechanicy')
DROP VIEW Mechanicy;
GO

CREATE VIEW Mechanicy
AS
SELECT s.nazwa, COUNT(p.idpracownik) AS ilosc
FROM pracownik p JOIN stanowisko s 
	ON p.idstanowisko=s.idstanowisko
	GROUP BY s.nazwa
HAVING COUNT(p.idstanowisko)>1;
GO
-- test
SELECT ilosc, nazwa
FROM Mechanicy
ORDER BY ilosc DESC;
GO

--2) widok 2
IF EXISTS (SELECT * FROM SYS.views WHERE name='BOX')
DROP VIEW BOX;
GO

CREATE VIEW BOX
AS
SELECT a.marka, a.model, a.typ_nadwozia, e.cena, COUNT(e.idegzemplarz) AS ilosc
FROM auto a JOIN egzemplarz e
	ON a.idauto=e.idegzemplarz
	GROUP BY a.marka, a.model, a.typ_nadwozia, e.cena
HAVING COUNT(e.idegzemplarz)>0;
GO
-- test
SELECT marka, model, typ_nadwozia, cena, ilosc
FROM BOX
ORDER BY cena DESC;
GO

--3) funkcja 1
CREATE FUNCTION ilu
(
	@idklient INT
)
RETURNS INT
BEGIN
	DECLARE @ilu INT;
	SELECT @ilu=COUNT(*)
	FROM klient k JOIN auto a
		ON k.idklient=a.idauto
	WHERE k.idklient=@idklient
	RETURN @ilu;
  END;
GO
-- test
SELECT imie, nazwisko, dbo.ilu(idklient) AS ile_samochodow
FROM klient
WHERE dbo.ilu(idklient)>0;
GO

--4) funkcja 2
CREATE FUNCTION wymiary
(	
	@dlugosc varchar(10),
	@szerokosc varchar(10),
	@wysokosc varchar(10)
)
RETURNS varchar(10)
AS
BEGIN
	DECLARE @wymiary varchar(10)
	SET @wymiary = @dlugosc+ 'x' + @szerokosc + 'x' + @wysokosc
	RETURN @wymiary
END;
GO
-- test
SELECT e.marka, e.model, e.cena, dbo.wymiary(dlugosc,szerokosc,wysokosc) 
AS DLUxSZExWYS
FROM egzemplarz e JOIN typ t
	ON e.idtyp=t.idtyp
ORDER BY e.cena;
GO

--5) funkcja 3
CREATE FUNCTION wiek_prac
(	
	@rok_ur varchar(4)
)
RETURNS varchar(4)
AS
BEGIN
	DECLARE @wiek_prac varchar(4)
	SET @wiek_prac=2013-@rok_ur
	RETURN @wiek_prac
END;
GO
-- test
SELECT p.imie, p.nazwisko, s.nazwa, dbo.wiek_prac(rok_ur) AS wiek_pracownika
FROM pracownik p JOIN stanowisko s
	ON p.idstanowisko=s.idstanowisko
ORDER BY wiek_pracownika;
GO

--6) funkcja 4
CREATE FUNCTION roznica_pensji_brutto() 
RETURNS INT
BEGIN
	RETURN (SELECT MAX(brutto)-MIN(brutto) from pensja) 
END;
GO
CREATE FUNCTION roznica_pensji_netto() 
RETURNS INT
BEGIN
	RETURN (SELECT MAX(netto)-MIN(netto) from pensja) 
END;
GO
-- test
SELECT dbo.roznica_pensji_netto() AS roznica_netto;
GO
SELECT dbo.roznica_pensji_brutto() AS roznica_brutto;
GO

--7) procedura 1
SELECT p.imie, p.nazwisko, pe.brutto 
FROM pracownik p JOIN pensja pe
ON p.idpracownik=pe.idpensja;
GO
CREATE PROCEDURE zwieksz_pensje_brutto
	@idpensja INT,
	@kwota DECIMAL(8,2) AS
UPDATE pensja
SET brutto=brutto+@kwota
WHERE idpensja=@idpensja; 
GO
EXECUTE zwieksz_pensje_brutto 2, 100;
GO
-- test
SELECT p.imie, p.nazwisko, pe.brutto 
FROM pracownik p JOIN pensja pe
ON p.idpracownik=pe.idpensja;
GO

--8) procedura 2
CREATE PROCEDURE podwyzka
@idpensja INT, @nowa_pensja MONEY OUTPUT, @procent INT=10
AS
BEGIN
	SELECT @nowa_pensja=brutto+brutto*@procent/100
	FROM pensja
	WHERE idpensja=@idpensja
	UPDATE pensja
	SET brutto=@nowa_pensja
	WHERE idpensja=@idpensja
END;
GO
-- test
DECLARE @nowa_pensja MONEY
EXECUTE podwyzka 2, @nowa_pensja OUTPUT
PRINT @nowa_pensja;
GO

--9) procedura 3
CREATE PROCEDURE sr_pensja
AS
BEGIN
	DECLARE @sr MONEY
	SELECT @sr=AVG(brutto) FROM pensja
	RETURN @sr
END;
GO
-- test
DECLARE @kwota MONEY
EXECUTE @kwota=sr_pensja
PRINT @kwota;
GO

--10) procedura 4
SELECT p.imie, p.nazwisko, pe.netto 
FROM pracownik p JOIN pensja pe
ON p.idpracownik=pe.idpensja;
GO
CREATE PROCEDURE zwieksz_pensje_netto
	@idpensja INT,
	@kwota DECIMAL(8,2) AS
UPDATE pensja
SET netto=netto+@kwota
WHERE idpensja=@idpensja; 
GO
EXECUTE zwieksz_pensje_netto 4, 200;
GO
-- test
SELECT p.imie, p.nazwisko, pe.netto 
FROM pracownik p JOIN pensja pe
ON p.idpracownik=pe.idpensja;
GO

--11) wyzwalacz 1
CREATE VIEW wklient
AS
SELECT k.idklient AS id, k.imie, k.nazwisko,
COUNT(k.idauto) AS ilosc
FROM klient k LEFT JOIN auto a 
	ON k.idauto=a.idauto
	GROUP BY k.idklient, k.imie, k.nazwisko;
GO
CREATE TRIGGER wklient_up ON wklient
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE kursor_up CURSOR
	FOR SELECT id, imie, nazwisko FROM INSERTED
	DECLARE @id INT, @imie VARCHAR(45), @nazwisko VARCHAR(45)
	
	OPEN kursor_up
	FETCH NEXT FROM kursor_up INTO @id, @imie, @nazwisko
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE klient SET imie=@imie, nazwisko=@nazwisko
		WHERE idklient=@id
		FETCH NEXT FROM kursor_up INTO @id, @imie, @nazwisko
	END
	
	CLOSE kursor_up
	DEALLOCATE kursor_up
END
GO
-- test
SELECT id, imie, nazwisko, ilosc
FROM wklient
ORDER BY id ASC;
GO
UPDATE wklient SET imie='JERZY' WHERE id=2;
GO
SELECT id, imie, nazwisko, ilosc
FROM wklient
ORDER BY id ASC;
GO

--12) wyzwalacz 2
CREATE TRIGGER usuwanie_klientow ON klient
AFTER DELETE
AS
BEGIN
	DECLARE kursor_deleted CURSOR
	FOR SELECT imie, nazwisko FROM DELETED;
	DECLARE @imie VARCHAR(45), @nazwisko VARCHAR(45)
	
	OPEN kursor_deleted
	FETCH NEXT FROM kursor_deleted INTO @imie, @nazwisko
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		print 'USUNIETO: '+@imie+' '+@nazwisko
		FETCH NEXT FROM kursor_deleted INTO @imie, @nazwisko
	END
	
	CLOSE kursor_deleted
	DEALLOCATE kursor_deleted
END
GO
-- test
DELETE FROM klient where idklient=1;
GO

--13) wyzwalacz 3
CREATE TRIGGER zamiast_delete ON typ
INSTEAD OF DELETE
AS
	DECLARE @idtyp INT;
	DECLARE @dlugosc INT;
	DECLARE @szerokosc INT;
	DECLARE @wysokosc INT;
	DECLARE @pojemnosc INT;
	
	SELECT @idtyp=d.idtyp FROM deleted d;
	SELECT @dlugosc=d.dlugosc FROM deleted d;
	SELECT @szerokosc=d.szerokosc FROM deleted d;
	SELECT @wysokosc=d.wysokosc FROM deleted d;
	SELECT @pojemnosc=d.pojemnosc FROM deleted d;
	
	BEGIN
		IF(@pojemnosc < 400)
		BEGIN
			RAISERROR('NIE MOZNA USUNAC POJEMNOSC < 400',16,1);
			ROLLBACK;
		END
		ELSE
		BEGIN
			DELETE FROM typ where idtyp=@idtyp;
			COMMIT;
			INSERT INTO typ_t(idtyp,dlugosc,szerokosc,wysokosc,pojemnosc,inf,data)
			VALUES(@idtyp,@dlugosc,@szerokosc,@wysokosc,@pojemnosc,'Deleted -- Instead Of Delete Trigger.',getdate());
			PRINT 'Record Deleted -- Instead Of Delete Trigger.'
		END
	END
GO
-- test
DELETE FROM typ WHERE idtyp=4;
GO

--14) wyzwalacz 4
CREATE TRIGGER bagazniki_bazowe_del1 ON bagazniki_bazowe
AFTER DELETE
AS
BEGIN
	PRINT 'Usunięto '+STR(@@ROWCOUNT)+' rekordów.'
END
GO

CREATE TRIGGER bagazniki_bazowe_del2 ON bagazniki_bazowe
AFTER DELETE
AS
BEGIN
	PRINT 'Rekordy usnięto z bazy danych '+DB_NAME()
END
GO
-- test
DELETE FROM bagazniki_bazowe WHERE idbagazniki_bazowe=1;
GO

--15) pivot 1
SELECT marka, [OCEAN] AS OCEAN, [ECONOMIC] AS ECONOMIC, [EASY] AS EASY, [STELLA] AS STELLA
FROM 
(SELECT marka, model, cena 
FROM egzemplarz ) e
PIVOT
(
SUM (cena)
FOR model IN
( [OCEAN], [ECONOMIC], [EASY], [STELLA])
) AS pvt

--16) pivot 2
SELECT [MECHANIK] AS MECHANICY, [ELEKTRYK] AS ELEKTRYCY, [ZARZADCA] AS ZARZADCY
FROM
(SELECT s.nazwa, p.brutto, p.netto
FROM stanowisko s JOIN pensja p
ON s.idpensja=p.idpensja) s
PIVOT
(
AVG(brutto)
FOR nazwa IN
([MECHANIK], [ELEKTRYK], [ZARZADCA])
) AS pvt2

DROP VIEW Mechanicy;
GO
DROP VIEW BOX;
GO
DROP FUNCTION ilu;
GO
DROP FUNCTION wymiary;
GO
DROP FUNCTION wiek_prac;
GO
DROP FUNCTION roznica_pensji_brutto;
GO
DROP FUNCTION roznica_pensji_netto;
GO
DROP PROCEDURE zwieksz_pensje_brutto;
GO
DROP PROCEDURE podwyzka;
GO
DROP PROCEDURE sr_pensja;
GO
DROP PROCEDURE zwieksz_pensje_netto;
GO
DROP TRIGGER wklient_up;
GO
DROP TRIGGER usuwanie_klientow;
GO
DROP TRIGGER zamiast_delete;
GO
DROP TRIGGER bagazniki_bazowe_del1;
GO
DROP TRIGGER bagazniki_bazowe_del2;
GO
