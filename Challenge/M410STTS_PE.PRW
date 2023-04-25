#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function M410STTS
    Ponto de entrada na validação do pedido de venda
    @type  Function
    @author user
    @since 24/04/2023
    /*/
User Function M410STTS()
    local lRet  := .T.

    //! Variáveis para criação do arquivo, serão informadas por parâmetro.
    local cPath := "\Pedidos de Venda\"
    local cFile := ""

    if INCLUI
        cFile := alltrim(M->C5_NUM)

        // //? CFunção de usuário que cria um log de eventos do pedido recém criado.
        FwAlertInfo("Aguarde, gerando log de informações.", "Atenção!")
        U_LogPedido(cPath, cFile)
        

        //? Função de usuário que cria um relatório em PDF com a classe FwMsPrinter() com o resumo do pedido recém criado.
        FwAlertInfo("Gerando resumo do pedido " + cFile + ", aguarde!", "Atenção")
        U_MsPedido(cPath, cFile)

    endif

Return lRet
