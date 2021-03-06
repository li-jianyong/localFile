USE [master]
GO
/****** Object:  Database [attendancesystem_db]    Script Date: 01/08/2018 23:38:40 ******/
CREATE DATABASE [attendancesystem_db] ON  PRIMARY 
( NAME = N'attendancesystem_db', FILENAME = N'D:\1\公司考勤管理系统\attendancesystem_db.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'attendancesystem_db_log', FILENAME = N'D:\1\公司考勤管理系统\attendancesystem_db_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [attendancesystem_db] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [attendancesystem_db].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [attendancesystem_db] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [attendancesystem_db] SET ANSI_NULLS OFF
GO
ALTER DATABASE [attendancesystem_db] SET ANSI_PADDING OFF
GO
ALTER DATABASE [attendancesystem_db] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [attendancesystem_db] SET ARITHABORT OFF
GO
ALTER DATABASE [attendancesystem_db] SET AUTO_CLOSE ON
GO
ALTER DATABASE [attendancesystem_db] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [attendancesystem_db] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [attendancesystem_db] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [attendancesystem_db] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [attendancesystem_db] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [attendancesystem_db] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [attendancesystem_db] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [attendancesystem_db] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [attendancesystem_db] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [attendancesystem_db] SET  DISABLE_BROKER
GO
ALTER DATABASE [attendancesystem_db] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [attendancesystem_db] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [attendancesystem_db] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [attendancesystem_db] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [attendancesystem_db] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [attendancesystem_db] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [attendancesystem_db] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [attendancesystem_db] SET  READ_WRITE
GO
ALTER DATABASE [attendancesystem_db] SET RECOVERY SIMPLE
GO
ALTER DATABASE [attendancesystem_db] SET  MULTI_USER
GO
ALTER DATABASE [attendancesystem_db] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [attendancesystem_db] SET DB_CHAINING OFF
GO
USE [attendancesystem_db]
GO
/****** Object:  Table [dbo].[zw]    Script Date: 01/08/2018 23:38:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[zw](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[zwname] [varchar](50) NULL,
	[gz] [varchar](50) NULL,
	[jbgz] [varchar](50) NULL,
	[bt] [varchar](50) NULL,
 CONSTRAINT [PK_zw] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sysuser]    Script Date: 01/08/2018 23:38:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sysuser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[uname] [varchar](50) NULL,
	[upass] [varchar](50) NULL,
	[realname] [varchar](50) NULL,
	[img] [varchar](50) NULL,
	[sex] [varchar](50) NULL,
	[age] [varchar](50) NULL,
	[idcard] [varchar](50) NULL,
	[dept] [varchar](50) NULL,
	[xl] [varchar](50) NULL,
	[tel] [varchar](50) NULL,
	[zw] [varchar](50) NULL,
	[birth] [varchar](50) NULL,
	[mz] [varchar](50) NULL,
	[zzmm] [varchar](50) NULL,
	[jg] [varchar](50) NULL,
	[delstatus] [varchar](50) NULL,
	[role] [varchar](50) NULL,
	[status] [varchar](50) NULL,
 CONSTRAINT [PK_sysuser] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[qjinfo]    Script Date: 01/08/2018 23:38:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[qjinfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[empid] [varchar](50) NULL,
	[qjdate] [varchar](50) NULL,
	[etime] [varchar](50) NULL,
	[qjnum] [varchar](50) NULL,
	[reason] [varchar](50) NULL,
	[status] [varchar](50) NULL,
 CONSTRAINT [PK_qjinfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[notice]    Script Date: 01/08/2018 23:38:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[notice](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[title] [varchar](50) NULL,
	[content] [text] NULL,
	[savetime] [varchar](50) NULL,
 CONSTRAINT [PK_notice] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[kqrecord]    Script Date: 01/08/2018 23:38:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[kqrecord](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[recordrq] [varchar](50) NULL,
	[stime] [varchar](50) NULL,
	[etime] [varchar](50) NULL,
	[workhour] [bigint] NULL,
	[empid] [varchar](50) NULL,
 CONSTRAINT [PK_kqrecord] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[dept]    Script Date: 01/08/2018 23:38:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[dept](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[deptname] [varchar](50) NULL,
	[deptzz] [varchar](50) NULL,
	[deptaddr] [varchar](50) NULL,
 CONSTRAINT [PK_dept] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[chat]    Script Date: 01/08/2018 23:38:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[chat](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[content] [varchar](50) NULL,
	[savetime] [varchar](50) NULL,
	[empid] [varchar](50) NULL,
 CONSTRAINT [PK_chat] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
