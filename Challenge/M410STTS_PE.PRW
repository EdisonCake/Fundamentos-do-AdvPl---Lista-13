#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function M410STTS
    Ponto de entrada na valida��o do pedido de venda
    @type  Function
    @author user
    @since 24/04/2023
    /*/
User Function M410STTS()
    local lRet  := .T.

    //! Vari�veis para cria��o do arquivo, ser�o informadas por par�metro.
    local cPath := "\Pedidos de Venda\"
    local cFile := ""

    if INCLUI
        cFile := alltrim(M->C5_NUM)

        // //? CFun��o de usu�rio que cria um log de eventos do pedido rec�m criado.
        FwAlertInfo("Aguarde, gerando log de informa��es.", "Aten��o!")
        U_LogPedido(cPath, cFile)
        

        //? Fun��o de usu�rio que cria um relat�rio em PDF com a classe FwMsPrinter() com o resumo do pedido rec�m criado.
        FwAlertInfo("Gerando resumo do pedido " + cFile + ", aguarde!", "Aten��o")
        U_MsPedido(cPath, cFile)

    endif

Return lRet
