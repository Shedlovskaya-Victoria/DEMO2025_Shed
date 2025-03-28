USE [master]
GO
/****** Object:  Database [user22]    Script Date: 05.02.2025 14:47:01 ******/
CREATE DATABASE [user22]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'user22', FILENAME = N'/var/opt/mssql/data/user22.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'user22_log', FILENAME = N'/var/opt/mssql/data/user22_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [user22] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [user22].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [user22] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [user22] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [user22] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [user22] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [user22] SET ARITHABORT OFF 
GO
ALTER DATABASE [user22] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [user22] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [user22] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [user22] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [user22] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [user22] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [user22] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [user22] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [user22] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [user22] SET  ENABLE_BROKER 
GO
ALTER DATABASE [user22] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [user22] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [user22] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [user22] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [user22] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [user22] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [user22] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [user22] SET RECOVERY FULL 
GO
ALTER DATABASE [user22] SET  MULTI_USER 
GO
ALTER DATABASE [user22] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [user22] SET DB_CHAINING OFF 
GO
ALTER DATABASE [user22] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [user22] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [user22] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [user22] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [user22] SET QUERY_STORE = OFF
GO
USE [user22]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[FIO] [nvarchar](150) NOT NULL,
	[Login] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[IsBlocked] [bit] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[AllUsers]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AllUsers]
AS
SELECT        UserId, RoleId, FIO, Login, Password
FROM            dbo.Users
GO
/****** Object:  Table [dbo].[AdditionalProduct]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdditionalProduct](
	[AdditionalProductId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Cost] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_AdditionalProduct] PRIMARY KEY CLUSTERED 
(
	[AdditionalProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdditionalProductClientsCross]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdditionalProductClientsCross](
	[CrossId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PaymentDate] [date] NOT NULL,
	[AdditionalProductId] [int] NOT NULL,
 CONSTRAINT [PK_AdditionalProductClientsCross] PRIMARY KEY CLUSTERED 
(
	[CrossId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CategoriesRooms]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CategoriesRooms](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK_CategoriesRooms] PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ReservId] [int] IDENTITY(1,1) NOT NULL,
	[UsertId] [int] NOT NULL,
	[RoomsFondId] [int] NOT NULL,
	[PaymenRoomDocument] [varbinary](max) NULL,
	[CostRoom] [decimal](18, 2) NULL,
	[Comments] [nvarchar](200) NULL,
	[Discount] [decimal](18, 2) NULL,
	[DateIn] [date] NOT NULL,
	[DateOut] [date] NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomsFond]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomsFond](
	[RoomsFondId] [int] IDENTITY(1,1) NOT NULL,
	[Floor] [int] NOT NULL,
	[CategoryRoomId] [int] NOT NULL,
	[Number] [int] NULL,
	[RoomStatusId] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_RoomsFond] PRIMARY KEY CLUSTERED 
(
	[RoomsFondId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomsStatuses]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomsStatuses](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_RoomsStatuses] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SheduleCleaning]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SheduleCleaning](
	[CleanId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoomFondId] [int] NOT NULL,
	[DateTimeStart] [datetime] NOT NULL,
	[DateTimeEnd] [datetime] NOT NULL,
 CONSTRAINT [PK_SheduleCleaning] PRIMARY KEY CLUSTERED 
(
	[CleanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AdditionalProduct] ON 

INSERT [dbo].[AdditionalProduct] ([AdditionalProductId], [Title], [Description], [Cost]) VALUES (1, N'вода', NULL, CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[AdditionalProduct] ([AdditionalProductId], [Title], [Description], [Cost]) VALUES (2, N'еда', NULL, CAST(20.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[AdditionalProduct] OFF
GO
SET IDENTITY_INSERT [dbo].[CategoriesRooms] ON 

INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (26, N'Одноместный стандарт')
INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (27, N'Одноместный эконом')
INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (28, N'Стандарт двухместный с 2 раздельными кроватями')
INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (29, N'Эконом двухместный с 2 раздельными кроватями')
INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (30, N'3-местный бюджет')
INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (31, N'Бизнес с 1 или 2 кроватями')
INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (33, N'Студия')
INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (34, N'Люкс с 2 двуспальными кроватями')
INSERT [dbo].[CategoriesRooms] ([CategoryId], [Title]) VALUES (35, N'Двухкомнатный двухместный стандарт с 1 или 2 кроватями
')
SET IDENTITY_INSERT [dbo].[CategoriesRooms] OFF
GO
SET IDENTITY_INSERT [dbo].[Reservations] ON 

INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (1, 6, 1, NULL, NULL, N'', NULL, CAST(N'2025-02-14' AS Date), CAST(N'2025-03-02' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (2, 7, 2, NULL, NULL, N'', NULL, CAST(N'2025-02-28' AS Date), NULL)
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (3, 8, 3, NULL, NULL, N'', NULL, CAST(N'2025-02-23' AS Date), CAST(N'2025-02-02' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (4, 9, 4, NULL, NULL, N'', NULL, CAST(N'2025-03-01' AS Date), CAST(N'2025-03-07' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (5, 10, 5, NULL, NULL, N'', NULL, CAST(N'2025-02-27' AS Date), CAST(N'2025-04-22' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (6, 11, 6, NULL, NULL, N'', NULL, CAST(N'2025-02-24' AS Date), CAST(N'2025-03-17' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (7, 12, 7, NULL, NULL, N'', NULL, CAST(N'2025-02-15' AS Date), CAST(N'2025-03-20' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (8, 13, 8, NULL, NULL, N'', NULL, CAST(N'2025-02-27' AS Date), CAST(N'2025-03-12' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (9, 14, 9, NULL, NULL, N'', NULL, CAST(N'2025-02-14' AS Date), CAST(N'2025-02-02' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (10, 15, 10, NULL, NULL, N'', NULL, CAST(N'2025-02-24' AS Date), CAST(N'2025-03-17' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (11, 16, 11, NULL, NULL, N'', NULL, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-07' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (12, 17, 13, NULL, NULL, N'', NULL, CAST(N'2025-03-01' AS Date), CAST(N'2025-03-04' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (13, 18, 15, NULL, NULL, N'', NULL, CAST(N'2025-02-02' AS Date), CAST(N'2025-02-02' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (14, 19, 16, NULL, NULL, N'', NULL, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-04' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (15, 20, 17, NULL, NULL, N'', NULL, CAST(N'2025-02-25' AS Date), CAST(N'2025-03-04' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (16, 21, 18, NULL, NULL, N'', NULL, CAST(N'2025-02-27' AS Date), NULL)
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (17, 22, 23, NULL, NULL, N'', NULL, CAST(N'2025-02-28' AS Date), CAST(N'2025-03-15' AS Date))
INSERT [dbo].[Reservations] ([ReservId], [UsertId], [RoomsFondId], [PaymenRoomDocument], [CostRoom], [Comments], [Discount], [DateIn], [DateOut]) VALUES (18, 25, 25, NULL, NULL, N'', NULL, CAST(N'2025-02-11' AS Date), NULL)
SET IDENTITY_INSERT [dbo].[Reservations] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [Title]) VALUES (1, N'main manager')
INSERT [dbo].[Roles] ([RoleId], [Title]) VALUES (2, N'administrator')
INSERT [dbo].[Roles] ([RoleId], [Title]) VALUES (3, N'client')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomsFond] ON 

INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (1, 1, 26, 101, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (2, 1, 26, 102, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (3, 1, 27, 103, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (4, 1, 27, 104, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (5, 1, 28, 105, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (6, 1, 28, 106, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (7, 1, 28, 107, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (8, 1, 28, 108, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (9, 1, 29, 109, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (10, 1, 29, 110, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (11, 2, 30, 201, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (12, 2, 31, 202, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (13, 2, 31, 203, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (14, 2, 35, 204, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (15, 2, 35, 205, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (16, 2, 35, 206, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (17, 2, 26, 207, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (18, 2, 26, 208, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (19, 2, 26, 209, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (20, 3, 33, 301, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (21, 3, 33, 302, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (22, 3, 33, 303, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (23, 3, 34, 304, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (24, 3, 34, 305, 1, CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[RoomsFond] ([RoomsFondId], [Floor], [CategoryRoomId], [Number], [RoomStatusId], [Price]) VALUES (25, 3, 34, 306, 1, CAST(100.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[RoomsFond] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomsStatuses] ON 

INSERT [dbo].[RoomsStatuses] ([StatusId], [Title]) VALUES (1, N'Занят')
INSERT [dbo].[RoomsStatuses] ([StatusId], [Title]) VALUES (2, N'Чистый')
INSERT [dbo].[RoomsStatuses] ([StatusId], [Title]) VALUES (3, N'Назначен к уборке')
INSERT [dbo].[RoomsStatuses] ([StatusId], [Title]) VALUES (4, N'Грязный')
SET IDENTITY_INSERT [dbo].[RoomsStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (4, 1, N'Main head', N'1', N'1', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (5, 2, N'Administrator', N'2', N'2', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (6, 3, N'???????? ????? ??????????
', N'123', N'456', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (7, 3, N'???????? ????? ???????
', N'124', N'457', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (8, 3, N'???????? ???? ???????????', N'125', N'458', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (9, 3, N'???????? ???? ????????', N'126', N'459', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (10, 3, N'????? ?????? ??????????', N'127', N'460', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (11, 3, N'??????? ????? ?????????????', N'128', N'461', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (12, 3, N'????????? ??????? ?????????', N'129', N'462', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (13, 3, N'???????? ?????? ??????????', N'130', N'463', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (14, 3, N'???????? ????? ??????????
', N'131', N'464', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (15, 3, N'???????? ????? ??????????
', N'132', N'465', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (16, 3, N'?????? ?????? ?????????', N'133', N'466', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (17, 3, N'???????? ????? ??????????
', N'134', N'467', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (18, 3, N'????????? ???? ??????????', N'135', N'468', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (19, 3, N'????? ?????? ??????????', N'136', N'469', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (20, 3, N'????? ???? ?????????', N'137', N'470', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (21, 3, N'???????? ????? ??????????
', N'138', N'471', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (22, 3, N'???? ?????? ?????????', N'139', N'472', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (23, 3, N'???????? ????? ??????????
', N'140', N'473', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (24, 3, N'???????? ????? ?????????', N'140', N'473', NULL)
INSERT [dbo].[Users] ([UserId], [RoleId], [FIO], [Login], [Password], [IsBlocked]) VALUES (25, 3, N'???????? ????? ?????????', N'140', N'473', NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[AdditionalProductClientsCross]  WITH CHECK ADD  CONSTRAINT [FK_AdditionalProductClientsCross_AdditionalProduct] FOREIGN KEY([AdditionalProductId])
REFERENCES [dbo].[AdditionalProduct] ([AdditionalProductId])
GO
ALTER TABLE [dbo].[AdditionalProductClientsCross] CHECK CONSTRAINT [FK_AdditionalProductClientsCross_AdditionalProduct]
GO
ALTER TABLE [dbo].[AdditionalProductClientsCross]  WITH CHECK ADD  CONSTRAINT [FK_AdditionalProductClientsCross_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[AdditionalProductClientsCross] CHECK CONSTRAINT [FK_AdditionalProductClientsCross_Users]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Users] FOREIGN KEY([UsertId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Users]
GO
ALTER TABLE [dbo].[RoomsFond]  WITH CHECK ADD  CONSTRAINT [FK_RoomsFond_CategoriesRooms] FOREIGN KEY([CategoryRoomId])
REFERENCES [dbo].[CategoriesRooms] ([CategoryId])
GO
ALTER TABLE [dbo].[RoomsFond] CHECK CONSTRAINT [FK_RoomsFond_CategoriesRooms]
GO
ALTER TABLE [dbo].[RoomsFond]  WITH CHECK ADD  CONSTRAINT [FK_RoomsFond_RoomsStatuses] FOREIGN KEY([RoomStatusId])
REFERENCES [dbo].[RoomsStatuses] ([StatusId])
GO
ALTER TABLE [dbo].[RoomsFond] CHECK CONSTRAINT [FK_RoomsFond_RoomsStatuses]
GO
ALTER TABLE [dbo].[SheduleCleaning]  WITH CHECK ADD  CONSTRAINT [FK_SheduleCleaning_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[SheduleCleaning] CHECK CONSTRAINT [FK_SheduleCleaning_Users]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
/****** Object:  StoredProcedure [dbo].[CountHardUploadRoomsForPeriod]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Shed2005
-- Description:	for demo examen 2025 year
-- =============================================
CREATE PROCEDURE [dbo].[CountHardUploadRoomsForPeriod] 
	(
	 @StartDate DATE = NULL,
	 @EndDate DATE = NULL
	)
AS
DECLARE @count_all_rooms INT
DECLARE @count_sales_rooms INT
DECLARE  @result INT 
BEGIN
	SET NOCOUNT ON;
	IF(@StartDate = NULL)
	 SET @StartDate = GETDATE();
	IF(@EndDate = NULL)
	 SET @EndDate = GETDATE();

	 SET @count_all_rooms = (SELECT COUNT(*) FROM RoomsFond);
	 SET @count_sales_rooms = (SELECT COUNT(*) FROM Reservations 
	                           WHERE DateIn = @StartDate AND DateOut = @EndDate);
     SET @result = @count_all_rooms / @count_sales_rooms; 

	 RETURN (@result);
END
GO
/****** Object:  StoredProcedure [dbo].[CountPercentUploudRooms]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CountPercentUploudRooms]
AS
--DECLARE @a TEXT

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 SELECT COUNT(*) AS total_rows FROM Users;
    -- Insert statements for procedure here
	-- SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
	--RETURN total_rows;
END
GO
/****** Object:  StoredProcedure [dbo].[CountPercentUploudRooms2]    Script Date: 05.02.2025 14:47:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CountPercentUploudRooms2]
AS
DECLARE @count_all_rooms INT
DECLARE @count_sales_rooms INT
DECLARE  @result INT 

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET @count_all_rooms = (SELECT COUNT(*) FROM Users);
    SET @count_sales_rooms = (SELECT COUNT(*) FROM Users WHERE RoleId = 2);
	SET @result = @count_all_rooms - @count_sales_rooms;
	RETURN(@result);
	
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Users"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 148
               Right = 258
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllUsers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'AllUsers'
GO
USE [master]
GO
ALTER DATABASE [user22] SET  READ_WRITE 
GO
