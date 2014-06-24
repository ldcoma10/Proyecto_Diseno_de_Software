Create Table Usuario(
IdUsuario int Identity Constraint PKidUsuario Primary Key,
Email Varchar(max) ,
Contrasena Varchar(100),
Rol Char(1)
)

Create Table Foto(
IdFoto int Identity Constraint PKidFoto Primary Key,
Foto image,
Ip Varchar(50),
Comentario Varchar(100),
Usuario Varchar(100)
)

Create Table Album(
IdAlbum int Identity Constraint Al Primary Key,
IdFoto int)

Alter table Album
add constraint const unique nonclustered(IdAlbum,IdFoto)



--Album Pk: IDAlbum, IdFoto
Create Table Lugar(
IdLugar int Identity Constraint PKidLugar Primary Key,
Nombre Varchar(max),
Pais Varchar(max)
)


Create Table HistorialporUsuario(
IdHistorial int Identity Constraint PKidHistorial Primary Key,
IdLugar int not null FOREIGN KEY REFERENCES Lugar(IdLugar) ,
IdUsuario int not null FOREIGN KEY REFERENCES Usuario(IdUsuario),
IdAlbum int FOREIGN KEY REFERENCES Album (IdAlbum),
Fecha datetime)


--Modifico
CREATE TABLE [dbo].[UsuariosConectadosWeb](
	[NumeroCookie] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[Fecha] [datetime] NULL,
 CONSTRAINT [PkUsuariosConectados] PRIMARY KEY CLUSTERED 
(
	[NumeroCookie] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[UsuariosConectadosWeb]  WITH CHECK ADD  CONSTRAINT [fkUsConectados] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO

ALTER TABLE [dbo].[UsuariosConectadosWeb] CHECK CONSTRAINT [fkUsConectados]
GO


CREATE  Procedure [dbo].[IniciarSesion] 
@correo varchar(max)

AS
Begin
Declare @idUsuario int,@numerocookie int
Set @idUsuario=(Select IdUsuario From Usuario Where Email=@correo)
Insert Into UsuariosConectadosWeb(IdUsuario)
Values(@idUsuario)
Set @numerocookie=(Select top 1 (numerocookie) From UsuariosConectadosWeb where IdUsuario=@idUsuario Order by 1 Desc)
return @numerocookie
END





