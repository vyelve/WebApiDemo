USE [master]
GO
/****** Object:  Database [EmployeeDB]    Script Date: 23-04-2020 18:01:03 ******/
CREATE DATABASE [EmployeeDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'EmployeeDB', FILENAME = N'D:\DataBase\EmployeeDB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EmployeeDB_log', FILENAME = N'D:\DataBase\EmployeeDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EmployeeDB] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EmployeeDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EmployeeDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EmployeeDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EmployeeDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EmployeeDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EmployeeDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EmployeeDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EmployeeDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EmployeeDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EmployeeDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EmployeeDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EmployeeDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EmployeeDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EmployeeDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EmployeeDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EmployeeDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EmployeeDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EmployeeDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EmployeeDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [EmployeeDB] SET  MULTI_USER 
GO
ALTER DATABASE [EmployeeDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EmployeeDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EmployeeDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EmployeeDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [EmployeeDB] SET DELAYED_DURABILITY = DISABLED 
GO
USE [EmployeeDB]
GO
/****** Object:  Table [dbo].[Department]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Department](
	[DepartmentID] [bigint] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](50) NULL,
 CONSTRAINT [PK_Department] PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeID] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeName] [varchar](500) NULL,
	[DepartmentID] [bigint] NOT NULL,
	[EmailId] [nvarchar](500) NULL,
	[DOJ] [date] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Department] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Department]
GO
/****** Object:  StoredProcedure [dbo].[AddDepartment]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[AddDepartment]
(
	@Id int output,
	@DepartmentName VARCHAR(50)
)
As
Begin
    SET NOCOUNT ON;

	INSERT INTO Department(DepartmentName)
	VALUES(@DepartmentName)
	
	SET @Id = SCOPE_IDENTITY()    

	IF (@@ERROR != 0)    
	BEGIN    
		RETURN - 1    
	END    
	ELSE    
	BEGIN    
		RETURN @Id   
	End

End
GO
/****** Object:  StoredProcedure [dbo].[AddEmployee]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[AddEmployee]
(
	@EmployeeName VARCHAR(100),
	@DepartmentID int,
	@EmailId nvarchar(100),
	@DOJ date,
	@Id int output
)
As
Begin
	SET NOCOUNT ON;

	INSERT INTO Employee(EmployeeName,DepartmentID,EmailId,DOJ)
	VALUES(@EmployeeName,@DepartmentID,@EmailId,@DOJ)

	SET @Id = SCOPE_IDENTITY()    

	IF (@@ERROR != 0)    
	BEGIN    
		RETURN - 1    
	END    
	ELSE    
	BEGIN    
		RETURN @Id   
	End

End
GO
/****** Object:  StoredProcedure [dbo].[DeleteDepartment]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[DeleteDepartment]
(
	@DepartmentID BIGINT
)
As
Begin
	Delete from Department Where DepartmentID = @DepartmentID;
End
GO
/****** Object:  StoredProcedure [dbo].[DeleteEmployee]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[DeleteEmployee]
(
	@EmployeeID int
)
As
Begin
	Delete from Employee Where EmployeeID = @EmployeeID;
End
GO
/****** Object:  StoredProcedure [dbo].[GetDepartments]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[GetDepartments]
As
Begin
	SELECT DepartmentID, DepartmentName FROM Department;
End
GO
/****** Object:  StoredProcedure [dbo].[GetDepartmentsByID]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[GetDepartmentsByID]
(
	@DepartmentID BIGINT
)
As
Begin
	
	SELECT DepartmentID, DepartmentName 
	FROM Department 
	Where DepartmentID = @DepartmentID;

End
GO
/****** Object:  StoredProcedure [dbo].[GetEmployees]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[GetEmployees]
As
Begin
	SELECT EmployeeID, 
		   EmployeeName, 
		   DepartmentID, 
		   EmailId,
		   CONVERT(varchar(10),DOJ,120) as DOJ 
	FROM Employee;
End
GO
/****** Object:  StoredProcedure [dbo].[GetEmployeesByID]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[GetEmployeesByID]
(
	@EmployeeID BIGINT
)
As
Begin
	SELECT EmployeeID, 
		   EmployeeName, 
		   DepartmentID, 
		   EmailId,
		   CONVERT(varchar(10),DOJ,120) as DOJ 
	FROM Employee
	WHERE EmployeeID = @EmployeeID;

End
GO
/****** Object:  StoredProcedure [dbo].[UpdateDepartment]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateDepartment]
(
	@DepartmentID BIGINT,
	@DepartmentName VARCHAR(100),
	@Id int output
)
As
Begin

	Update Department 
	Set DepartmentName = @DepartmentName		
	Where DepartmentID = @DepartmentID

	SET @Id = @DepartmentID

	IF (@@ERROR != 0)    
	BEGIN    
		RETURN - 1    
	END    
	ELSE    
	BEGIN    
		RETURN @Id   
	End

End
GO
/****** Object:  StoredProcedure [dbo].[UpdateEmployee]    Script Date: 23-04-2020 18:01:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[UpdateEmployee]
(
	@EmployeeID int,
	@EmployeeName VARCHAR(100),
	@DepartmentID int,
	@EmailId nvarchar(100),
	@DOJ date,
	@Id int output
)
As
Begin
	Update Employee 
	Set EmployeeName = @EmployeeName,
		DepartmentID = @DepartmentID,
		EmailId = @EmailId,
		DOJ = @DOJ
	Where EmployeeID = @EmployeeID;

	SET @Id = @DepartmentID

	IF (@@ERROR != 0)    
	BEGIN    
		RETURN - 1    
	END    
	ELSE    
	BEGIN    
		RETURN @Id   
	End

End
GO
USE [master]
GO
ALTER DATABASE [EmployeeDB] SET  READ_WRITE 
GO
