1.
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

SELECT ilosc, nazwa
FROM Mechanicy
ORDER BY ilosc DESC;
GO

2.
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

SELECT marka, model, typ_nadwozia, cena, ilosc
FROM BOX
ORDER BY cena DESC;
GO

3.
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

SELECT imie, nazwisko, dbo.ilu(idklient) AS ile_samochodow
FROM klient
WHERE dbo.ilu(idklient)>0;
GO

4.
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

SELECT e.marka, e.model, e.cena, dbo.wymiary(dlugosc,szerokosc,wysokosc) 
AS WYMIARY
FROM egzemplarz e JOIN typ t
	ON e.idtyp=t.idtyp
ORDER BY e.cena;
GO

5.
CREATE FUNCTION wiek_prac
(	
	@data_ur DATETIME
)
RETURNS DATETIME
AS
BEGIN
	DECLARE @wiek_prac DATETIME
	SET @wiek_prac=GETDATE()-@data_ur
	RETURN @wiek_prac
END;
GO

SELECT p.imie, p.nazwisko, s.nazwa, dbo.wiek_prac(data_ur) 
AS wiek_pracownika
FROM pracownik p JOIN stanowisko s
	ON p.idstanowisko=s.idstanowisko
ORDER BY wiek_pracownika;
GO

6.
CREATE FUNCTION roznica_pensji_brutto() 
RETURNS INT
BEGIN
	RETURN (SELECT MAX(brutto)-MIN(brutto) from pensja) 
END;
GO
SELECT dbo.roznica_pensji_brutto() AS roznica;
GO
CREATE FUNCTION roznica_pensji_netto() 
RETURNS INT
BEGIN
	RETURN (SELECT MAX(netto)-MIN(netto) from pensja) 
END;
GO
SELECT dbo.roznica_pensji_netto() AS roznica;
GO

7.
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
SELECT p.imie, p.nazwisko, pe.brutto 
FROM pracownik p JOIN pensja pe
ON p.idpracownik=pe.idpensja;
GO

8.
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
DECLARE @nowa_pensja MONEY
EXECUTE podwyzka 2, @nowa_pensja OUTPUT
PRINT @nowa_pensja;
GO

9.
CREATE PROCEDURE sr_pensja
AS
BEGIN
	DECLARE @sr MONEY
	SELECT @sr=AVG(brutto) FROM pensja
	RETURN @sr
END;
GO
DECLARE @kwota MONEY
EXECUTE @kwota=sr_pensja
PRINT @kwota;
GO

10.
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
SELECT p.imie, p.nazwisko, pe.netto 
FROM pracownik p JOIN pensja pe
ON p.idpracownik=pe.idpensja;
GO

11.
CREATE TRIGGER klient_up ON klient
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE kursor_up CURSOR
	FOR SELECT idklient, idauto, idadres, imie, nazwisko, nr_tel FROM INSERTED
	DECLARE @idklient INT, @idauto INT, @idadres INT, @imie VARCHAR(45), @nazwisko VARCHAR(45), @nr_tel VARCHAR(11)
	
	OPEN kursor_up
	FETCH NEXT FROM kursor_up INTO @idklient, @idauto, @idadres, @imie, @nazwisko, @nr_tel
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		UPDATE klient SET imie=@imie, nazwisko=@nazwisko, nr_tel=@nr_tel
	END
	
	CLOSE kursor_up
	DEALLOCATE kursor_up
END
GO

12.
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

13.
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

DELETE FROM typ WHERE idtyp=4;
GO
