--Nuevo
Create TRIGGER [dbo].[GuardarFecha] on [dbo].[UsuariosConectadosWeb]
   AFTER INSERT
AS 
BEGIN
	SET NOCOUNT ON;
Declare @Cookie int

Select @Cookie=(Select NumeroCookie From  inserted)

Update UsuariosConectadosWeb set Fecha=GETDATE()    

END