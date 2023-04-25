#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MA410MNU
    Ponto de entrada para adicionar um bot�o ao menu de Pedidos de Venda para a c�pia dos .PDFs gerados para outro diret�rio.
    @type  Function
    @author Edison Cake
    @since 25/04/2023
    /*/
User Function MA410MNU()
    
    // Bot�o extra na rotina para a chamada de uma nova fun��o de usu�rio para a exporta��o dos arquivos em .PDF para outro diret�rio no Windows.
    aAdd(aRotina, {"Export PDF", "u_Export()", 0, 6})

Return 
