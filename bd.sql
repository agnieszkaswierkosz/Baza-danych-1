USE [master]
GO
/****** Object:  Database [SprzedazBD]    Script Date: 09.07.2021 19:00:29 ******/
CREATE DATABASE [SprzedazBD]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'SprzedazBD', FILENAME = N'C:\SQLDane\SprzedazBD.mdf' , SIZE = 1046528KB , MAXSIZE = UNLIMITED, FILEGROWTH = 0), 
 FILEGROUP [DRUGA] 
( NAME = N'SprzedazBD_Zamowienia', FILENAME = N'C:\SQLDane2\SprzedazBDZam.ndf' , SIZE = 262144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB ), 
 FILEGROUP [INDEKSY] 
( NAME = N'SprzedazBD_Indeksy', FILENAME = N'C:\SQLIndeksy\SprzedazBDIndeksy.ndf' , SIZE = 262144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'SprzedazBD_log', FILENAME = N'C:\SQLLog\SprzedazBD.ldf' , SIZE = 524288KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [SprzedazBD] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SprzedazBD].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SprzedazBD] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [SprzedazBD] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [SprzedazBD] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [SprzedazBD] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [SprzedazBD] SET ARITHABORT OFF 
GO
ALTER DATABASE [SprzedazBD] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [SprzedazBD] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [SprzedazBD] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [SprzedazBD] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [SprzedazBD] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [SprzedazBD] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [SprzedazBD] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [SprzedazBD] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [SprzedazBD] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [SprzedazBD] SET  DISABLE_BROKER 
GO
ALTER DATABASE [SprzedazBD] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [SprzedazBD] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [SprzedazBD] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [SprzedazBD] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [SprzedazBD] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [SprzedazBD] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [SprzedazBD] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [SprzedazBD] SET RECOVERY FULL 
GO
ALTER DATABASE [SprzedazBD] SET  MULTI_USER 
GO
ALTER DATABASE [SprzedazBD] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [SprzedazBD] SET DB_CHAINING OFF 
GO
ALTER DATABASE [SprzedazBD] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [SprzedazBD] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [SprzedazBD] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [SprzedazBD] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'SprzedazBD', N'ON'
GO
ALTER DATABASE [SprzedazBD] SET QUERY_STORE = OFF
GO
USE [SprzedazBD]
GO
/****** Object:  UserDefinedFunction [dbo].[ZwrocNazweKlienta]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ZwrocNazweKlienta]
(
@CzyFirma BIT,
@KlientID INT
)
RETURNS varchar(255)
AS
BEGIN



DECLARE @nazwa varchar(255) = ''



IF (@CzyFirma = 1)
BEGIN
--firma
SELECT @nazwa = Nazwa
FROM [dbo].[Firmy]
WHERE ID = @KlientID
END
ELSE
BEGIN
--osoby fizyczne
SELECT @nazwa = Imie + ' ' + Nazwisko
FROM [dbo].[OsobyFizyczne]
WHERE ID = @KlientID
END



RETURN @nazwa
END
GO
/****** Object:  Table [dbo].[Firmy]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Firmy](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nazwa] [varchar](255) NOT NULL,
	[NIP] [char](10) NOT NULL,
	[AdresID] [int] NOT NULL,
 CONSTRAINT [PK_Table_2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OsobyFizyczne]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OsobyFizyczne](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Imie] [varchar](120) NOT NULL,
	[Nazwisko] [varchar](120) NOT NULL,
	[PESEL] [char](11) NOT NULL,
	[Plec] [bit] NOT NULL,
	[AdresID] [int] NOT NULL,
 CONSTRAINT [PK_OsobyFizyczne] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Klienci]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Klienci](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirmaID] [int] NULL,
	[OsobaFizycznaID] [int] NULL,
	[CzyFirma] [bit] NOT NULL,
	[CzyAktywny] [bit] NOT NULL,
 CONSTRAINT [PK_Klienci] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Zamowienia]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Zamowienia](
	[KlientID] [int] NOT NULL,
	[ProduktID] [tinyint] NOT NULL,
	[NrZamowienia] [char](10) NOT NULL,
	[DataZamowienia] [smalldatetime] NOT NULL,
	[Ilosc] [tinyint] NOT NULL,
	[Wartosc] [decimal](9, 2) NOT NULL,
 CONSTRAINT [IX_Zamowienia] UNIQUE NONCLUSTERED 
(
	[NrZamowienia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[ZwrocNajnowszeZamowieniaDlaKlienta]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ZwrocNajnowszeZamowieniaDlaKlienta]
(
@Liczba TINYINT,
@KID INT
)
RETURNS TABLE
AS
RETURN
SELECT TOP (@Liczba) WITH TIES z.[NrZamowienia], z.[DataZamowienia], z.[Wartosc],
CASE WHEN k.CzyFirma = 1 THEN (SELECT f.Nazwa
FROM [dbo].[Firmy] AS f
WHERE f.ID = k.FirmaID)
ELSE (SELECT [of].Imie + ' ' + [of].Nazwisko
FROM [dbo].[OsobyFizyczne] AS [of]
WHERE [of].ID = k.OsobaFizycznaID) END AS [Nazwa],

CASE WHEN k.CzyFirma = 1 THEN (SELECT f.NIP
FROM [dbo].[Firmy] AS f
WHERE f.ID = k.FirmaID)
ELSE (SELECT [of].PESEL
FROM [dbo].[OsobyFizyczne] AS [of]
WHERE [of].ID = k.OsobaFizycznaID) END AS [NIP/PESEL]



FROM [dbo].[Zamowienia] AS z
INNER JOIN [dbo].[Klienci] AS k ON (z.KlientID = k.ID)
WHERE [KlientID] = @KID
ORDER BY [DataZamowienia] DESC
GO
/****** Object:  Table [dbo].[Adresy]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Adresy](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Miasto] [varchar](255) NOT NULL,
	[Kod] [char](6) NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Produkty]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produkty](
	[ID] [tinyint] NOT NULL,
	[Nazwa] [varchar](300) NOT NULL,
	[Cena] [decimal](9, 2) NULL,
	[CzyAktywny] [bit] NULL,
	[CzyDostepny] [bit] NULL,
	[TypProduktuID] [tinyint] NULL,
 CONSTRAINT [PK_Produkty] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TypyProduktow]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TypyProduktow](
	[ID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nazwa] [varchar](200) NOT NULL,
 CONSTRAINT [PK_TypyProduktow] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Klienci] ADD  CONSTRAINT [DF_Klienci_CzyAktywny]  DEFAULT ((1)) FOR [CzyAktywny]
GO
ALTER TABLE [dbo].[OsobyFizyczne] ADD  CONSTRAINT [DF_OsobyFizyczne_AdresyID]  DEFAULT ((1)) FOR [AdresID]
GO
ALTER TABLE [dbo].[Firmy]  WITH CHECK ADD  CONSTRAINT [FK_Firmy_Adresy] FOREIGN KEY([AdresID])
REFERENCES [dbo].[Adresy] ([ID])
GO
ALTER TABLE [dbo].[Firmy] CHECK CONSTRAINT [FK_Firmy_Adresy]
GO
ALTER TABLE [dbo].[Klienci]  WITH CHECK ADD  CONSTRAINT [FK_Klienci_Firmy1] FOREIGN KEY([FirmaID])
REFERENCES [dbo].[Firmy] ([ID])
GO
ALTER TABLE [dbo].[Klienci] CHECK CONSTRAINT [FK_Klienci_Firmy1]
GO
ALTER TABLE [dbo].[Klienci]  WITH CHECK ADD  CONSTRAINT [FK_Klienci_OsobyFizyczne1] FOREIGN KEY([OsobaFizycznaID])
REFERENCES [dbo].[OsobyFizyczne] ([ID])
GO
ALTER TABLE [dbo].[Klienci] CHECK CONSTRAINT [FK_Klienci_OsobyFizyczne1]
GO
ALTER TABLE [dbo].[OsobyFizyczne]  WITH CHECK ADD  CONSTRAINT [FK_OsobyFizyczne_Adresy] FOREIGN KEY([AdresID])
REFERENCES [dbo].[Adresy] ([ID])
GO
ALTER TABLE [dbo].[OsobyFizyczne] CHECK CONSTRAINT [FK_OsobyFizyczne_Adresy]
GO
ALTER TABLE [dbo].[Produkty]  WITH CHECK ADD  CONSTRAINT [FK_Produkty_TypyProduktow] FOREIGN KEY([TypProduktuID])
REFERENCES [dbo].[TypyProduktow] ([ID])
GO
ALTER TABLE [dbo].[Produkty] CHECK CONSTRAINT [FK_Produkty_TypyProduktow]
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_Zamowienia_Klienci] FOREIGN KEY([KlientID])
REFERENCES [dbo].[Klienci] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_Zamowienia_Klienci]
GO
ALTER TABLE [dbo].[Zamowienia]  WITH CHECK ADD  CONSTRAINT [FK_Zamowienia_Produkty] FOREIGN KEY([ProduktID])
REFERENCES [dbo].[Produkty] ([ID])
GO
ALTER TABLE [dbo].[Zamowienia] CHECK CONSTRAINT [FK_Zamowienia_Produkty]
GO
/****** Object:  StoredProcedure [dbo].[ZwrocNajnowszeZamowieniaDlaKlientaSP]    Script Date: 09.07.2021 19:00:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ZwrocNajnowszeZamowieniaDlaKlientaSP]
(
@Liczba TINYINT,
@KID INT
)
AS



SELECT TOP (@Liczba) WITH TIES z.[NrZamowienia], z.[DataZamowienia], z.[Wartosc],

CASE WHEN k.CzyFirma = 1 THEN (SELECT dbo.ZwrocNazweKlienta(k.CzyFirma, k.[FirmaID]))
ELSE (SELECT dbo.ZwrocNazweKlienta(k.CzyFirma, k.[OsobaFizycznaID])) END AS [Nazwa],

CASE WHEN k.CzyFirma = 1 THEN (SELECT f.NIP
FROM [dbo].[Firmy] AS f
WHERE f.ID = k.FirmaID)
ELSE (SELECT [of].PESEL
FROM [dbo].[OsobyFizyczne] AS [of]
WHERE [of].ID = k.OsobaFizycznaID) END AS [NIP/PESEL]



FROM [dbo].[Zamowienia] AS z
INNER JOIN [dbo].[Klienci] AS k ON (z.KlientID = k.ID)
WHERE [KlientID] = @KID
ORDER BY [DataZamowienia] DESC
GO
USE [master]
GO
ALTER DATABASE [SprzedazBD] SET  READ_WRITE 
GO
