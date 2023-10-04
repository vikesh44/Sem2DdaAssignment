USE [RestaurantManagement]
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetMenu]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_GetMenu]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tables]') AND type in (N'U'))
ALTER TABLE [dbo].[Tables] DROP CONSTRAINT IF EXISTS [FK_Tables_Order]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Restaurant_Address]') AND type in (N'U'))
ALTER TABLE [dbo].[Restaurant_Address] DROP CONSTRAINT IF EXISTS [FK_Restaurant_Address_Restaurant]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person_PhoneNo]') AND type in (N'U'))
ALTER TABLE [dbo].[Person_PhoneNo] DROP CONSTRAINT IF EXISTS [FK_Person_PhoneNo_Person]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person_Name]') AND type in (N'U'))
ALTER TABLE [dbo].[Person_Name] DROP CONSTRAINT IF EXISTS [FK_Person_Name_Person]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person_Address]') AND type in (N'U'))
ALTER TABLE [dbo].[Person_Address] DROP CONSTRAINT IF EXISTS [FK_Person_Address_Person]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order_Items]') AND type in (N'U'))
ALTER TABLE [dbo].[Order_Items] DROP CONSTRAINT IF EXISTS [FK_Order_Items_Order]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order_Items]') AND type in (N'U'))
ALTER TABLE [dbo].[Order_Items] DROP CONSTRAINT IF EXISTS [FK_Order_Items_Menu]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Employee]') AND type in (N'U'))
ALTER TABLE [dbo].[Employee] DROP CONSTRAINT IF EXISTS [FK_Employee_Person]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer_Employee_Order]') AND type in (N'U'))
ALTER TABLE [dbo].[Customer_Employee_Order] DROP CONSTRAINT IF EXISTS [FK_Customer_Employee_Order_Order]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer_Employee_Order]') AND type in (N'U'))
ALTER TABLE [dbo].[Customer_Employee_Order] DROP CONSTRAINT IF EXISTS [FK_Customer_Employee_Order_Employee]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer_Employee_Order]') AND type in (N'U'))
ALTER TABLE [dbo].[Customer_Employee_Order] DROP CONSTRAINT IF EXISTS [FK_Customer_Employee_Order_Customer]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Customer]') AND type in (N'U'))
ALTER TABLE [dbo].[Customer] DROP CONSTRAINT IF EXISTS [FK_Customer_Person]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Tables]
GO
/****** Object:  Table [dbo].[Restaurant_Address]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Restaurant_Address]
GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Restaurant]
GO
/****** Object:  Table [dbo].[Person_PhoneNo]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Person_PhoneNo]
GO
/****** Object:  Table [dbo].[Person_Name]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Person_Name]
GO
/****** Object:  Table [dbo].[Person_Address]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Person_Address]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Person]
GO
/****** Object:  Table [dbo].[Order_Items]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Order_Items]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Order]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Menu]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Employee]
GO
/****** Object:  Table [dbo].[Customer_Employee_Order]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Customer_Employee_Order]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP TABLE IF EXISTS [dbo].[Customer]
GO
/****** Object:  User [Admin]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP USER IF EXISTS [Admin]
GO
USE [master]
GO
/****** Object:  Database [RestaurantManagement]    Script Date: 10/4/2023 7:22:31 PM ******/
DROP DATABASE IF EXISTS [RestaurantManagement]
GO
/****** Object:  Database [RestaurantManagement]    Script Date: 10/4/2023 7:22:31 PM ******/
CREATE DATABASE [RestaurantManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RestaurantManagement', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\RestaurantManagement.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'RestaurantManagement_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\RestaurantManagement_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [RestaurantManagement] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RestaurantManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RestaurantManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RestaurantManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RestaurantManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RestaurantManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RestaurantManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [RestaurantManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RestaurantManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RestaurantManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RestaurantManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RestaurantManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RestaurantManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RestaurantManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RestaurantManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RestaurantManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RestaurantManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RestaurantManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RestaurantManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RestaurantManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RestaurantManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RestaurantManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RestaurantManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RestaurantManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RestaurantManagement] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RestaurantManagement] SET  MULTI_USER 
GO
ALTER DATABASE [RestaurantManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RestaurantManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RestaurantManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RestaurantManagement] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [RestaurantManagement] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [RestaurantManagement] SET QUERY_STORE = OFF
GO
USE [RestaurantManagement]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
USE [RestaurantManagement]
GO
/****** Object:  User [Admin]    Script Date: 10/4/2023 7:22:31 PM ******/
CREATE USER [Admin] FOR LOGIN [Admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Admin]
GO
ALTER ROLE [db_accessadmin] ADD MEMBER [Admin]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [Admin]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [Admin]
GO
ALTER ROLE [db_backupoperator] ADD MEMBER [Admin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [Admin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [Admin]
GO
ALTER ROLE [db_denydatareader] ADD MEMBER [Admin]
GO
ALTER ROLE [db_denydatawriter] ADD MEMBER [Admin]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [nvarchar](20) NOT NULL,
	[PersonId] [bigint] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer_Employee_Order]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Employee_Order](
	[OrderId] [nvarchar](15) NOT NULL,
	[CustomerId] [nvarchar](20) NOT NULL,
	[EmployeeId] [nvarchar](20) NULL,
	[OrderTime] [datetime] NOT NULL,
 CONSTRAINT [PK_Customer_Employee_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [nvarchar](20) NOT NULL,
	[PersonId] [bigint] NOT NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[ItemId] [nvarchar](10) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Cost] [decimal](8, 2) NOT NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [nvarchar](15) NOT NULL,
	[OrderType] [nchar](10) NOT NULL,
	[Cost] [decimal](10, 2) NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order_Items]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_Items](
	[OrderId] [nvarchar](15) NOT NULL,
	[ItemId] [nvarchar](10) NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Order_Items] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC,
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [bigint] NOT NULL,
	[EmailId] [nvarchar](200) NOT NULL,
	[DateOfBirth] [datetime] NULL,
 CONSTRAINT [PK_Person] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person_Address]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person_Address](
	[PersonId] [bigint] NOT NULL,
	[HouseNo] [nvarchar](20) NOT NULL,
	[Area] [nvarchar](200) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Zip] [varchar](6) NOT NULL,
 CONSTRAINT [PK_Person_Address] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person_Name]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person_Name](
	[PersonId] [bigint] NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Person_Name] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person_PhoneNo]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person_PhoneNo](
	[PersonId] [bigint] NOT NULL,
	[PhoneNo] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Person_PhoneNo] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurant](
	[FssaiNo] [varchar](14) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Restaurant] PRIMARY KEY CLUSTERED 
(
	[FssaiNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurant_Address]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Restaurant_Address](
	[FssaiNo] [varchar](14) NOT NULL,
	[Area] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Zip] [varchar](6) NOT NULL,
 CONSTRAINT [PK_Restaurant_Address] PRIMARY KEY CLUSTERED 
(
	[FssaiNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tables](
	[TableId] [int] NOT NULL,
	[OrderId] [nvarchar](15) NOT NULL,
	[Reservation] [bit] NOT NULL,
 CONSTRAINT [PK_Tables] PRIMARY KEY CLUSTERED 
(
	[TableId] ASC,
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'B1', N'Breads', N'Roti', CAST(28.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'B2', N'Breads', N'Butter Roti', CAST(35.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'B3', N'Breads', N'Naan', CAST(48.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'B4', N'Breads', N'Butter Naan', CAST(55.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'B5', N'Breads', N'Kulcha', CAST(42.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'B6', N'Breads', N'Garlic Kulcha', CAST(52.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'D1', N'Desserts', N'Fruit Salad', CAST(100.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'D2', N'Desserts', N'Jelly with Ice Cream', CAST(90.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'D3', N'Desserts', N'Royal Faluda', CAST(135.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'D4', N'Desserts', N'Gulab Jamun', CAST(100.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'MC1', N'Main Course', N'Veg Kadai Lajawab', CAST(175.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'MC2', N'Main Course', N'Paneer Lahori', CAST(185.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'MC3', N'Main Course', N'Paneer Kofta', CAST(190.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'MC4', N'Main Course', N'Cheese Angoori', CAST(180.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'MC5', N'Main Course', N'Paneed Bhuna Masala', CAST(190.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'MC6', N'Main Course', N'Veg Amritsari', CAST(170.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'MC7', N'Main Course', N'Veg Rajasthani', CAST(170.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'R1', N'Rice', N'Jeera Rice', CAST(110.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'R2', N'Rice', N'Plain Rice', CAST(90.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'R3', N'Rice', N'Veg Pulao', CAST(135.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'R4', N'Rice', N'Paneed Pulao', CAST(150.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'R5', N'Rice', N'Dal Khichdi', CAST(140.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'So1', N'Soup', N'Cream of Tomato', CAST(110.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'So2', N'Soup', N'Cream of Palak', CAST(105.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'So3', N'Soup', N'Plain Sweet Corn', CAST(99.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'So4', N'Soup', N'Veg Manchow', CAST(120.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'So5', N'Soup', N'Veg Hot and Sour', CAST(120.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'ST1', N'Starters', N'Paneer Tikka', CAST(215.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'ST2', N'Starters', N'Soya Chaap Tikka', CAST(195.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'ST3', N'Starters', N'Corn Tikki', CAST(185.00 AS Decimal(8, 2)))
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'ST4', N'Starters', N'Veg Hara Bhara Kabab', CAST(185.00 AS Decimal(8, 2)))
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Person]
GO
ALTER TABLE [dbo].[Customer_Employee_Order]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Employee_Order_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([CustomerId])
GO
ALTER TABLE [dbo].[Customer_Employee_Order] CHECK CONSTRAINT [FK_Customer_Employee_Order_Customer]
GO
ALTER TABLE [dbo].[Customer_Employee_Order]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Employee_Order_Employee] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[Customer_Employee_Order] CHECK CONSTRAINT [FK_Customer_Employee_Order_Employee]
GO
ALTER TABLE [dbo].[Customer_Employee_Order]  WITH CHECK ADD  CONSTRAINT [FK_Customer_Employee_Order_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[Customer_Employee_Order] CHECK CONSTRAINT [FK_Customer_Employee_Order_Order]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Person]
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD  CONSTRAINT [FK_Order_Items_Menu] FOREIGN KEY([ItemId])
REFERENCES [dbo].[Menu] ([ItemId])
GO
ALTER TABLE [dbo].[Order_Items] CHECK CONSTRAINT [FK_Order_Items_Menu]
GO
ALTER TABLE [dbo].[Order_Items]  WITH CHECK ADD  CONSTRAINT [FK_Order_Items_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[Order_Items] CHECK CONSTRAINT [FK_Order_Items_Order]
GO
ALTER TABLE [dbo].[Person_Address]  WITH CHECK ADD  CONSTRAINT [FK_Person_Address_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Person_Address] CHECK CONSTRAINT [FK_Person_Address_Person]
GO
ALTER TABLE [dbo].[Person_Name]  WITH CHECK ADD  CONSTRAINT [FK_Person_Name_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Person_Name] CHECK CONSTRAINT [FK_Person_Name_Person]
GO
ALTER TABLE [dbo].[Person_PhoneNo]  WITH CHECK ADD  CONSTRAINT [FK_Person_PhoneNo_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Person_PhoneNo] CHECK CONSTRAINT [FK_Person_PhoneNo_Person]
GO
ALTER TABLE [dbo].[Restaurant_Address]  WITH CHECK ADD  CONSTRAINT [FK_Restaurant_Address_Restaurant] FOREIGN KEY([FssaiNo])
REFERENCES [dbo].[Restaurant] ([FssaiNo])
GO
ALTER TABLE [dbo].[Restaurant_Address] CHECK CONSTRAINT [FK_Restaurant_Address_Restaurant]
GO
ALTER TABLE [dbo].[Tables]  WITH CHECK ADD  CONSTRAINT [FK_Tables_Order] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[Tables] CHECK CONSTRAINT [FK_Tables_Order]
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetMenu]    Script Date: 10/4/2023 7:22:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 04/Oct/2023
-- Description:	Gets the Menu items
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetMenu]
AS
BEGIN
	SELECT ItemId
		  ,Category
		  ,Name
		  ,Cost
	  FROM Menu
	ORDER BY Category
END
GO
USE [master]
GO
ALTER DATABASE [RestaurantManagement] SET  READ_WRITE 
GO
