#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function MA410MNU
    Ponto de entrada para adicionar um botão ao menu de Pedidos de Venda para a cópia dos .PDFs gerados para outro diretório.
    @type  Function
    @author Edison Cake
    @since 25/04/2023
    /*/
User Function MA410MNU()
    
    // Botão extra na rotina para a chamada de uma nova função de usuário para a exportação dos arquivos em .PDF para outro diretório no Windows.
    aAdd(aRotina, {"Export PDF", "u_Export()", 0, 6})

Return 
