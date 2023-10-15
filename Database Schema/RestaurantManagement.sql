USE [RestaurantManagement]
GO
/****** Object:  StoredProcedure [dbo].[SSP_ValidateUser]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_ValidateUser]
GO
/****** Object:  StoredProcedure [dbo].[SSP_UpdatePerson]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_UpdatePerson]
GO
/****** Object:  StoredProcedure [dbo].[SSP_RetrivePassword]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_RetrivePassword]
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetPersonAddress]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_GetPersonAddress]
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetMenu]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_GetMenu]
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetEmployees]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_GetEmployees]
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetCustomerDetail]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_GetCustomerDetail]
GO
/****** Object:  StoredProcedure [dbo].[SSP_DeletePersonAddress]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_DeletePersonAddress]
GO
/****** Object:  StoredProcedure [dbo].[SSP_DeletePerson]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_DeletePerson]
GO
/****** Object:  StoredProcedure [dbo].[SSP_DeleteMenuItem]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_DeleteMenuItem]
GO
/****** Object:  StoredProcedure [dbo].[SSP_AddUpdatePersonAddress]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_AddUpdatePersonAddress]
GO
/****** Object:  StoredProcedure [dbo].[SSP_AddUpdateMenuItem]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_AddUpdateMenuItem]
GO
/****** Object:  StoredProcedure [dbo].[SSP_AddPerson]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP PROCEDURE IF EXISTS [dbo].[SSP_AddPerson]
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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person_LoginDetails]') AND type in (N'U'))
ALTER TABLE [dbo].[Person_LoginDetails] DROP CONSTRAINT IF EXISTS [FK_Person_LoginDetails_Person]
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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Person_LoginDetails]') AND type in (N'U'))
ALTER TABLE [dbo].[Person_LoginDetails] DROP CONSTRAINT IF EXISTS [DF_Person_LoginDetails_IsActive]
GO
/****** Object:  Table [dbo].[Tables]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Tables]
GO
/****** Object:  Table [dbo].[Restaurant_Address]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Restaurant_Address]
GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Restaurant]
GO
/****** Object:  Table [dbo].[Person_PhoneNo]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Person_PhoneNo]
GO
/****** Object:  Table [dbo].[Person_Name]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Person_Name]
GO
/****** Object:  Table [dbo].[Person_LoginDetails]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Person_LoginDetails]
GO
/****** Object:  Table [dbo].[Person_Address]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Person_Address]
GO
/****** Object:  Table [dbo].[Person]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Person]
GO
/****** Object:  Table [dbo].[Order_Items]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Order_Items]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Order]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Menu]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Employee]
GO
/****** Object:  Table [dbo].[Customer_Employee_Order]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Customer_Employee_Order]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TABLE IF EXISTS [dbo].[Customer]
GO
/****** Object:  UserDefinedTableType [dbo].[PersonAddressData]    Script Date: 15-10-2023 5.14.53 PM ******/
DROP TYPE IF EXISTS [dbo].[PersonAddressData]
GO
/****** Object:  UserDefinedTableType [dbo].[PersonAddressData]    Script Date: 15-10-2023 5.14.53 PM ******/
CREATE TYPE [dbo].[PersonAddressData] AS TABLE(
	[PersonId] [bigint] NOT NULL,
	[AddressNo] [int] NOT NULL,
	[HouseNo] [nvarchar](50) NOT NULL,
	[Area] [nvarchar](200) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Zip] [varchar](6) NOT NULL,
	PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[AddressNo] ASC
)WITH (IGNORE_DUP_KEY = OFF)
)
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Customer_Employee_Order]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Menu]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Order_Items]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Person]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Person_Address]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person_Address](
	[PersonId] [bigint] NOT NULL,
	[AddressNo] [int] NOT NULL,
	[HouseNo] [nvarchar](50) NOT NULL,
	[Area] [nvarchar](200) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[Zip] [varchar](6) NOT NULL,
 CONSTRAINT [PK_Person_Address] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[AddressNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person_LoginDetails]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person_LoginDetails](
	[PersonId] [bigint] NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Person_LoginDetails] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Person_Name]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Person_PhoneNo]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Person_PhoneNo](
	[PersonId] [bigint] NOT NULL,
	[PhoneNo] [varchar](10) NOT NULL,
 CONSTRAINT [PK_Person_PhoneNo] PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC,
	[PhoneNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Restaurant]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Restaurant_Address]    Script Date: 15-10-2023 5.14.53 PM ******/
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
/****** Object:  Table [dbo].[Tables]    Script Date: 15-10-2023 5.14.53 PM ******/
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
INSERT [dbo].[Customer] ([CustomerId], [PersonId]) VALUES (N'C_0', 0)
GO
INSERT [dbo].[Customer] ([CustomerId], [PersonId]) VALUES (N'C_1', 1)
GO
INSERT [dbo].[Customer] ([CustomerId], [PersonId]) VALUES (N'C_3', 3)
GO
INSERT [dbo].[Employee] ([EmployeeId], [PersonId]) VALUES (N'E_4', 4)
GO
INSERT [dbo].[Employee] ([EmployeeId], [PersonId]) VALUES (N'E_5', 5)
GO
INSERT [dbo].[Employee] ([EmployeeId], [PersonId]) VALUES (N'P_0', 0)
GO
INSERT [dbo].[Menu] ([ItemId], [Category], [Name], [Cost]) VALUES (N'B1', N'Breads', N'Roti3', CAST(28.00 AS Decimal(8, 2)))
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
INSERT [dbo].[Person] ([PersonId], [EmailId], [DateOfBirth]) VALUES (0, N'deleteduser@email.com', CAST(N'1900-01-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Person] ([PersonId], [EmailId], [DateOfBirth]) VALUES (1, N'vikesh@email.com', CAST(N'1989-11-14T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Person] ([PersonId], [EmailId], [DateOfBirth]) VALUES (2, N'customer@gmail.com', CAST(N'1989-01-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Person] ([PersonId], [EmailId], [DateOfBirth]) VALUES (3, N'vikesh.ldrp@gmail.com', CAST(N'1989-11-14T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Person] ([PersonId], [EmailId], [DateOfBirth]) VALUES (4, N'testing', CAST(N'2020-01-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Person] ([PersonId], [EmailId], [DateOfBirth]) VALUES (5, N'asdf@gmail.com', CAST(N'2023-10-01T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[Person_Address] ([PersonId], [AddressNo], [HouseNo], [Area], [City], [Zip]) VALUES (1, 1, N'A305 Suyog Space', N'Wakad', N'Pune', N'411057')
GO
INSERT [dbo].[Person_Address] ([PersonId], [AddressNo], [HouseNo], [Area], [City], [Zip]) VALUES (1, 2, N'92, Saraswati Society', N'S.J. Road', N'Sidhpur, Gujarat', N'384151')
GO
INSERT [dbo].[Person_LoginDetails] ([PersonId], [UserName], [Password], [IsActive]) VALUES (1, N'a', N'a', 1)
GO
INSERT [dbo].[Person_LoginDetails] ([PersonId], [UserName], [Password], [IsActive]) VALUES (2, N'c', N'c', 1)
GO
INSERT [dbo].[Person_LoginDetails] ([PersonId], [UserName], [Password], [IsActive]) VALUES (3, N'b', N'b', 1)
GO
INSERT [dbo].[Person_LoginDetails] ([PersonId], [UserName], [Password], [IsActive]) VALUES (4, N'testing1234', N'test', 1)
GO
INSERT [dbo].[Person_LoginDetails] ([PersonId], [UserName], [Password], [IsActive]) VALUES (5, N'asdf', N'asdf', 1)
GO
INSERT [dbo].[Person_Name] ([PersonId], [FirstName], [LastName]) VALUES (0, N'Deleted', N'User')
GO
INSERT [dbo].[Person_Name] ([PersonId], [FirstName], [LastName]) VALUES (1, N'Vikesh2', N'Mewada')
GO
INSERT [dbo].[Person_Name] ([PersonId], [FirstName], [LastName]) VALUES (2, N'Poonam', N'Mewada')
GO
INSERT [dbo].[Person_Name] ([PersonId], [FirstName], [LastName]) VALUES (3, N'Vikeshkumar', N'Mewada')
GO
INSERT [dbo].[Person_Name] ([PersonId], [FirstName], [LastName]) VALUES (4, N'testing', N'testing')
GO
INSERT [dbo].[Person_Name] ([PersonId], [FirstName], [LastName]) VALUES (5, N'asdf', N'asdf')
GO
INSERT [dbo].[Person_PhoneNo] ([PersonId], [PhoneNo]) VALUES (1, N'9879879870')
GO
INSERT [dbo].[Person_PhoneNo] ([PersonId], [PhoneNo]) VALUES (2, N'9654321654')
GO
INSERT [dbo].[Person_PhoneNo] ([PersonId], [PhoneNo]) VALUES (3, N'8600990050')
GO
INSERT [dbo].[Person_PhoneNo] ([PersonId], [PhoneNo]) VALUES (3, N'9742949310')
GO
INSERT [dbo].[Person_PhoneNo] ([PersonId], [PhoneNo]) VALUES (4, N'testing')
GO
INSERT [dbo].[Person_PhoneNo] ([PersonId], [PhoneNo]) VALUES (5, N'asdf')
GO
ALTER TABLE [dbo].[Person_LoginDetails] ADD  CONSTRAINT [DF_Person_LoginDetails_IsActive]  DEFAULT ((1)) FOR [IsActive]
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
ALTER TABLE [dbo].[Person_LoginDetails]  WITH CHECK ADD  CONSTRAINT [FK_Person_LoginDetails_Person] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Person_LoginDetails] CHECK CONSTRAINT [FK_Person_LoginDetails_Person]
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
/****** Object:  StoredProcedure [dbo].[SSP_AddPerson]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 12/Oct/2023
-- Description:	Creates the new Person
-- =============================================
CREATE PROCEDURE [dbo].[SSP_AddPerson]
	@UserName nvarchar(50),
	@Password nvarchar(50),
	@EmailId nvarchar(200),
	@DateOfBirth datetime,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@PhoneNo varchar(MAX),
	@IsCustomer bit
AS
BEGIN
	DECLARE @PersonId bigint
	SELECT @PersonId=PersonId FROM Person WHERE EmailId=@EmailId
	IF (@PersonId IS NULL)
	BEGIN
		SELECT @PersonId=PersonId FROM Person_LoginDetails WHERE UserName=@UserName
	END

	IF (@PersonId IS NULL)
	BEGIN
		SELECT @PersonId = MAX(PersonId)+1 FROM Person
		PRINT @PersonId

		INSERT INTO [Person]([PersonId],[EmailId],[DateOfBirth])
			 VALUES(@PersonId,@EmailId,@DateOfBirth)

		INSERT INTO [Person_LoginDetails]([PersonId],[UserName],[Password])
			 VALUES(@PersonId, @UserName, @Password)

		INSERT INTO [Person_Name]([PersonId],[FirstName],[LastName])
			 VALUES(@PersonId,@FirstName,@LastName)

		DELETE FROM [Person_PhoneNo] WHERE [PersonId]=@PersonId
		INSERT INTO [Person_PhoneNo]([PersonId],[PhoneNo])
		SELECT @PersonId as PersonId, value as PhoneNo FROM STRING_SPLIT(@PhoneNo, ',')

		IF (@IsCustomer = 1)
		BEGIN
			INSERT INTO [Customer]([CustomerId],[PersonId])
				 VALUES('C_'+CAST(@PersonId as nvarchar), @PersonId)
		END
		ELSE
		BEGIN
			INSERT INTO [Employee]([EmployeeId],[PersonId])
				 VALUES('E_'+CAST(@PersonId as nvarchar), @PersonId)
		END
	END
	ELSE
	BEGIN
		PRINT 'USER EXISTS'
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_AddUpdateMenuItem]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 11/Oct/2023
-- Description:	Add OR Update the Menu Item
-- =============================================
CREATE PROCEDURE [dbo].[SSP_AddUpdateMenuItem]
	@ItemId nvarchar(10),
	@Category nvarchar(50),
	@Name nvarchar(50),
	@Cost decimal(8,2)
AS
BEGIN
	IF EXISTS (SELECT [ItemId] FROM [Menu] WHERE [ItemId]=@ItemId)
	BEGIN
		UPDATE [Menu]
		   SET [Category] = @Category
			  ,[Name] = @Name
			  ,[Cost] = @Cost
		 WHERE [ItemId]=@ItemId
	END
	ELSE
	BEGIN
		INSERT INTO [Menu]
			   ([ItemId]
			   ,[Category]
			   ,[Name]
			   ,[Cost])
		 VALUES
			   (@ItemId,
				@Category,
				@Name,
				@Cost)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_AddUpdatePersonAddress]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 15/Oct/2023
-- Description:	Add the new address for a Person
-- =============================================
CREATE PROCEDURE [dbo].[SSP_AddUpdatePersonAddress]
	@PersonAddress PersonAddressData READONLY
AS
BEGIN
	
	DECLARE @PersonId bigint
	DECLARE @AddressNo int

	SELECT TOP 1 @PersonId=[PersonId],@AddressNo=[AddressNo] FROM @PersonAddress

	IF NOT EXISTS (SELECT [PersonId] FROM [Person_Address] WHERE [PersonId]=@PersonId AND [AddressNo]=@AddressNo)
	BEGIN
		SELECT @AddressNo=MAX([AddressNo])+1 FROM [Person_Address] WHERE [PersonId]=@PersonId
		
		INSERT INTO [Person_Address]([PersonId],[AddressNo],[HouseNo],[Area],[City],[Zip])
		SELECT [PersonId],@AddressNo AS [AddressNo],[HouseNo],[Area],[City],[Zip] FROM @PersonAddress
	END
	ELSE
	BEGIN
		UPDATE [Person_Address]
		   SET [HouseNo] = PA.[HouseNo]
			  ,[Area] = PA.[Area]
			  ,[City] = PA.[City]
			  ,[Zip] = PA.[Zip]
		 FROM @PersonAddress PA
		 WHERE PA.[PersonId]=[Person_Address].[PersonId] AND PA.[AddressNo]=[Person_Address].[AddressNo]
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_DeleteMenuItem]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 11/Oct/2023
-- Description:	Delete the Menu Item
-- =============================================
CREATE PROCEDURE [dbo].[SSP_DeleteMenuItem]
	@ItemId nvarchar(10)
AS
BEGIN
	DELETE FROM [Menu] WHERE [ItemId]=@ItemId
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_DeletePerson]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 12/Oct/2023
-- Description:	Delete the Person
-- =============================================
CREATE PROCEDURE [dbo].[SSP_DeletePerson]
	@PersonId nvarchar(20),
	@IsCustomer bit
AS
BEGIN

	UPDATE [Person_LoginDetails] SET [IsActive]=0 WHERE [PersonId]=@PersonId

	--DELETE FROM [Person_Name] WHERE [PersonId]=@PersonId

	--DELETE FROM [Person_PhoneNo] WHERE [PersonId]=@PersonId

	--DELETE FROM [Person_Address] WHERE [PersonId]=@PersonId

	--IF (@IsCustomer = 1)
	--BEGIN
	--	UPDATE [Customer_Employee_Order] SET [CustomerId]=0 WHERE [CustomerId] IN (SELECT [CustomerId] FROM [Customer] WHERE [PersonId]=@PersonId)

	--	DELETE FROM [Customer] WHERE [PersonId]=@PersonId
	--END
	--ELSE
	--BEGIN
	--	UPDATE [Customer_Employee_Order] SET [EmployeeId]=0 WHERE [EmployeeId] IN (SELECT [EmployeeId] FROM [Employee] WHERE [PersonId]=@PersonId)

	--	DELETE FROM [Employee] WHERE [PersonId]=@PersonId
	--END
	
	--DELETE FROM [Person] WHERE [PersonId]=@PersonId
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_DeletePersonAddress]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 15/Oct/2023
-- Description:	Delete the Person's address
-- =============================================
CREATE PROCEDURE [dbo].[SSP_DeletePersonAddress]
	@PersonId bigint,
	@AddressNo int
AS
BEGIN
	DELETE FROM [Person_Address] WHERE [PersonId]=@PersonId AND [AddressNo]=@AddressNo
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetCustomerDetail]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 12/Oct/2023
-- Description:	Updates the person
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetCustomerDetail]
	@PersonId bigint
AS
BEGIN
	SELECT P.[PersonId]
		  ,[UserName]
		  ,[Password]
		  ,[EmailId]
		  ,[DateOfBirth]
		  ,[FirstName]
		  ,[LastName]
		  ,(SELECT STRING_AGG(PhoneNo, ',') FROM Person_PhoneNo WHERE PersonId=@PersonId) AS PhoneNo
	  FROM [Person] P
	  INNER JOIN [Person_Name] PN ON P.PersonId=PN.PersonId
	  INNER JOIN [Person_LoginDetails] PLD ON P.PersonId=PLD.PersonId
	 WHERE P.[PersonId]=@PersonId
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetEmployees]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 12/Oct/2023
-- Description:	Gets the all Employee details
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetEmployees]
AS
BEGIN	
	SELECT P.[PersonId]
		  ,[UserName]
		  ,[EmailId]
		  ,[DateOfBirth]
		  ,[FirstName]
		  ,[LastName]
		  ,(SELECT STRING_AGG(PhoneNo, ',') FROM Person_PhoneNo WHERE PersonId=P.[PersonId]) AS PhoneNo
	  FROM [Person] P
	  INNER JOIN [Person_Name] PN ON P.PersonId=PN.PersonId
	  INNER JOIN [Person_LoginDetails] PLD ON P.PersonId=PLD.PersonId
	  INNER JOIN [Employee] E ON P.[PersonId]=E.[PersonId]
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetMenu]    Script Date: 15-10-2023 5.14.53 PM ******/
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
	SELECT [ItemId]
		  ,[Category]
		  ,[Name]
		  ,[Cost]
	  FROM [Menu]
	ORDER BY [Category]
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_GetPersonAddress]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 15/Oct/2023
-- Description:	Gets the All address of a Person
-- =============================================
CREATE PROCEDURE [dbo].[SSP_GetPersonAddress]
	@PersonId bigint
AS
BEGIN
	SELECT [PersonId]
		  ,[AddressNo]
		  ,[HouseNo]
		  ,[Area]
		  ,[City]
		  ,[Zip]
	  FROM [Person_Address]
	 WHERE [PersonId]=@PersonId
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_RetrivePassword]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 13/Oct/2023
-- Description:	Gets the password of user based on email id
-- =============================================
CREATE PROCEDURE [dbo].[SSP_RetrivePassword]
	@EmailId nvarchar(200)
AS
BEGIN
	SELECT [Password]
	  FROM [Person] P
	  INNER JOIN [Person_LoginDetails] PLD ON P.PersonId=PLD.PersonId
	 WHERE P.[EmailId]=@EmailId
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_UpdatePerson]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 12/Oct/2023
-- Description:	Updates the person
-- =============================================
CREATE PROCEDURE [dbo].[SSP_UpdatePerson]
	@PersonId bigint,
	@UserName nvarchar(50),
	@Password nvarchar(50),
	@EmailId nvarchar(200),
	@DateOfBirth datetime,
	@FirstName nvarchar(50),
	@LastName nvarchar(50),
	@PhoneNo nvarchar(max)
AS
BEGIN
	IF EXISTS(SELECT PersonId FROM Person WHERE PersonId=@PersonId)
	BEGIN

		UPDATE [Person]
		   SET [EmailId] = @EmailId
			  ,[DateOfBirth] = @DateOfBirth
		 WHERE [PersonId]=@PersonId

		UPDATE [Person_LoginDetails]
		   SET [UserName]=@UserName
		      ,[Password]=IIF(@Password = '',[Password],@Password)
		 WHERE [PersonId]=@PersonId

		UPDATE [Person_Name]
		   SET [FirstName]=@FirstName
		      ,[LastName]=@LastName
		 WHERE [PersonId]=@PersonId

		DELETE FROM [Person_PhoneNo] WHERE [PersonId]=@PersonId
		INSERT INTO [Person_PhoneNo]([PersonId],[PhoneNo])
		SELECT @PersonId as PersonId, value as PhoneNo FROM STRING_SPLIT(@PhoneNo, ',')
	END
	ELSE
	BEGIN
		PRINT 'USER DOES NOT EXISTS'
	END
END
GO
/****** Object:  StoredProcedure [dbo].[SSP_ValidateUser]    Script Date: 15-10-2023 5.14.53 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Vikeshkumar Mewada
-- Create date: 11/Oct/2023
-- Description:	Validates the user
-- =============================================
CREATE PROCEDURE [dbo].[SSP_ValidateUser]
	@UserName nvarchar(50),
	@Password nvarchar(50)
AS
BEGIN
    IF EXISTS (SELECT [PersonId] FROM [Person_LoginDetails] WHERE [UserName]=@UserName AND [Password]=@Password)
	BEGIN
		DECLARE @PersonId bigint
		DECLARE @IsCustomer bit

		SELECT @PersonId=[PersonId] FROM [Person_LoginDetails] WHERE [UserName]=@UserName AND [Password]=@Password

		IF EXISTS (SELECT * FROM [Customer] WHERE [PersonId]=@PersonId)
		BEGIN
			SET @IsCustomer=1
		END
		ELSE
		BEGIN
			SET @IsCustomer=0
		END

		SELECT N.PersonId, N.[FirstName], @IsCustomer AS IsCustomer
		  FROM [Person_LoginDetails] LD INNER JOIN [Person_Name] N ON LD.PersonId=N.PersonId
		 WHERE [UserName]=@UserName AND [Password]=@Password AND LD.[IsActive]=1
	END
	ELSE
	BEGIN
		SELECT 0 AS PersonId, '' AS [FirstName]
	END
END
GO
