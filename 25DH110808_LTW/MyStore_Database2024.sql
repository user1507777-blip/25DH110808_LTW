/*
    Database: MyStore
    Dùng cho project ASP.NET MVC5 + Entity Framework DB First
    Theo cấu trúc Database2024.txt của giảng viên.
*/

IF DB_ID(N'MyStore') IS NULL
BEGIN
    CREATE DATABASE [MyStore];
END
GO

USE [MyStore];
GO

-- Bang User: quan ly tai khoan cua Khach hang va Admin
IF OBJECT_ID(N'[dbo].[User]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[User] (
        [Username] NVARCHAR(255) NOT NULL,
        [Password] NCHAR(50) NOT NULL,
        [UserRole] NCHAR(1) NOT NULL,
        PRIMARY KEY CLUSTERED ([Username] ASC)
    );
END
GO

-- Bang Customer: luu thong tin khach hang
IF OBJECT_ID(N'[dbo].[Customer]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Customer] (
        [CustomerID] INT IDENTITY(1, 1) NOT NULL,
        [CustomerName] NVARCHAR(MAX) NOT NULL,
        [CustomerPhone] NVARCHAR(15) NOT NULL,
        [CustomerEmail] NVARCHAR(MAX) NULL,
        [CustomerAddress] NVARCHAR(MAX) NULL,
        [Username] NVARCHAR(255) NOT NULL,
        PRIMARY KEY CLUSTERED ([CustomerID] ASC),
        CONSTRAINT [FK_User_Customer]
            FOREIGN KEY ([Username]) REFERENCES [dbo].[User] ([Username])
    );
END
GO

-- Bang Category: luu thong tin danh muc san pham
IF OBJECT_ID(N'[dbo].[Category]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Category] (
        [CategoryID] INT IDENTITY(1, 1) NOT NULL,
        [CategoryName] NVARCHAR(MAX) NOT NULL,
        PRIMARY KEY CLUSTERED ([CategoryID] ASC)
    );
END
GO

-- Bang Product: luu thong tin san pham
IF OBJECT_ID(N'[dbo].[Product]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Product] (
        [ProductID] INT IDENTITY(1, 1) NOT NULL,
        [CategoryID] INT NOT NULL,
        [ProductName] NVARCHAR(MAX) NOT NULL,
        [ProductDecription] NVARCHAR(MAX) NOT NULL,
        [ProductPrice] DECIMAL(18, 2) NOT NULL,
        [ProductImage] NVARCHAR(MAX) NULL,
        PRIMARY KEY CLUSTERED ([ProductID] ASC),
        CONSTRAINT [FK_Pro_Category]
            FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Category] ([CategoryID])
    );
END
GO

-- Bang Order: luu thong tin don hang cua khach hang
IF OBJECT_ID(N'[dbo].[Order]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[Order] (
        [OrderID] INT IDENTITY(1, 1) NOT NULL,
        [CustomerID] INT NOT NULL,
        [OrderDate] DATE NOT NULL,
        [TotalAmount] DECIMAL(18, 2) NOT NULL,
        [PaymentStatus] NVARCHAR(MAX) NULL,
        [AddressDelivery] NVARCHAR(MAX) NOT NULL,
        PRIMARY KEY CLUSTERED ([OrderID] ASC),
        FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customer] ([CustomerID])
    );
END
GO

-- Bang OrderDetail: luu thong tin chi tiet cac san pham co trong don hang
IF OBJECT_ID(N'[dbo].[OrderDetail]', N'U') IS NULL
BEGIN
    CREATE TABLE [dbo].[OrderDetail] (
        [ID] INT IDENTITY(1, 1) NOT NULL,
        [ProductID] INT NOT NULL,
        [OrderID] INT NOT NULL,
        [Quantity] INT NOT NULL,
        [UnitPrice] DECIMAL(18, 2) NOT NULL,
        PRIMARY KEY CLUSTERED ([ID] ASC),
        FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Product] ([ProductID]),
        FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Order] ([OrderID])
    );
END
GO

/*
    File goc cua giang vien co dong:
    ALTER AUTHORIZATION ON DATABASE::MyStore TO sa;

    Dong nay khong can thiet de tao cac bang va quan he,
    nen de comment de script co the chay tren may khac ma khong phu thuoc
    vao tai khoan sa.
*/
-- ALTER AUTHORIZATION ON DATABASE::MyStore TO sa;
GO
