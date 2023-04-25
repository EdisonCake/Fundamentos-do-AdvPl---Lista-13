#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

/*/{Protheus.doc} User Function LogPedido
    Função para criação de log de eventos do pedido de venda recém criado.
    @type  Function
    @author user
    @since 24/04/2023
    /*/
User Function LogPedido(cPath, cFile)
    local cPedido   := cFile 
    local cLOG      := cFile + ".txt"     
    local aFiles    := {} 
    local oFile     := FwFileWriter():New(cPath + cLOG, .T.)
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery    := GetQuery(cPedido)
    local cInfo     := ""
    local nCount    := 0
    local nTotal    := 0

    TCQUERY cQuery ALIAS &(cAlias) NEW
    &(cAlias)->(DbGoTop())

    if !ExistDir(cPath)

        if MakeDir(cPath) == 0
            MsgInfo("Diretório criado com sucesso.", "Concluído!")
            MsgInfo("Criando arquivo de log em TXT.", "Aguarde!")

            if !File(cPath + cLOG)

                if !oFile:Create()
                    FwAlertError("Houve um erro ao tentar criar o log de eventos desse pedido.")
                else
                    
                    oFile:Write( "Log de Eventos // Pedido: " + cPedido + CRLF)
                    oFile:Write( "Emissão: " + DtoC(StoD((cAlias)->(C5_EMISSAO))) + CRLF)
                    oFile:Write( "Cliente: " + (cAlias)->(A1_NOME) + CRLF)
                    oFile:Write( "Pagamento: " + (cAlias)->(E4_DESCRI) + CRLF)
                    
                    While (cAlias)->(!Eof())
                        cInfo += Replicate("*", 50) + CRLF
                        cInfo += "Adicionado o item " + (cAlias)->(C6_ITEM) + ", " + (cAlias)->(C6_DESCRI) + CRLF
                        cInfo += "No valor de R$ " + cvaltochar((cAlias)->(C6_PRCVEN)) + CRLF
                        cInfo += Replicate("*", 50) + CRLF

                        nTotal += (cAlias)->(C6_VALOR)
                        (cAlias)->(DbSkip())
                    End do

                    oFile:Write(cInfo)
                    oFile:Write("Valor total da venda: R$ " + cvaltochar(nTotal))

                    oFile:Close()

                    if MsgYesNo("Arquivo de log gerado. Deseja visualizar o conteúdo?", "Concluído!")
                        ShellExecute('OPEN', cLOG, "", cPath, 1)
                    endif

                endif

            endif

        else
            FwAlertError("Houve um problema ao tentar criar o diretório especificado.", "Atenção!")
        endif

    else
        // Condição para que se o diretório já exista, criar apenas o arquivo.
        if !File(cPath + cLOG)

                if !oFile:Create()
                    FwAlertError("Houve um erro ao tentar criar o log de eventos desse pedido.")
                else
                    
                    oFile:Write( "Log de Eventos // Pedido: " + cPedido + CRLF)
                    oFile:Write( "Emissão: " + DtoC(StoD((cAlias)->(C5_EMISSAO))) + CRLF)
                    oFile:Write( "Cliente: " + (cAlias)->(A1_NOME) + CRLF)
                    oFile:Write( "Pagamento: " + (cAlias)->(E4_DESCRI) + CRLF)
                    
                    While (cAlias)->(!Eof())
                        cInfo += Replicate("*", 50) + CRLF
                        cInfo += "Adicionado o item " + (cAlias)->(C6_ITEM) + ", " + (cAlias)->(C6_DESCRI) + CRLF
                        cInfo += "No valor de R$ " + cvaltochar((cAlias)->(C6_PRCVEN)) + CRLF
                        cInfo += Replicate("*", 50) + CRLF

                        nTotal += (cAlias)->(C6_VALOR)
                        (cAlias)->(DbSkip())
                    End do

                    oFile:Write(cInfo)
                    oFile:Write("Valor total da venda: R$ " + cvaltochar(nTotal))

                    oFile:Close()

                    if MsgYesNo("Arquivo de log gerado. Deseja visualizar o conteúdo?", "Concluído!")
                        ShellExecute('OPEN', cLOG, "", cPath, 1)
                    endif

                endif
            
            else
                aFiles := Directory(cPath + cLOG, "D",,, 1)

                if MsgYesNo("Deseja sobrescrever o arquivo " + cLOG + "?", "Atenção")
                    if len(aFiles) > 0
                        For nCount := 3 to len(aFiles)
                            if Ferase(cPath + aFiles[nCount, 1]) == -1
                                FwAlertError("Erro ao excluir o arquivo.", "Erro")
                            endif
                        Next
                    endif
                endif

                if !oFile:Create()
                    FwAlertError("Houve um erro ao tentar criar o log de eventos desse pedido.")
                else
                    
                    oFile:Write( "Log de Eventos // Pedido: " + cPedido + CRLF)
                    oFile:Write( "Emissão: " + DtoC(StoD((cAlias)->(C5_EMISSAO))) + CRLF)
                    oFile:Write( "Cliente: " + (cAlias)->(A1_NOME) + CRLF)
                    oFile:Write( "Pagamento: " + (cAlias)->(E4_DESCRI) + CRLF)
                    
                    While (cAlias)->(!Eof())
                        cInfo += Replicate("*", 50) + CRLF
                        cInfo += "Adicionado o item " + (cAlias)->(C6_ITEM) + ", " + (cAlias)->(C6_DESCRI) + CRLF
                        cInfo += "No valor de R$ " + cvaltochar((cAlias)->(C6_PRCVEN)) + CRLF
                        cInfo += Replicate("*", 50) + CRLF

                        nTotal += (cAlias)->(C6_VALOR)
                        (cAlias)->(DbSkip())
                    End do

                    oFile:Write(cInfo)
                    oFile:Write("Valor total da venda: R$ " + cvaltochar(nTotal))

                    oFile:Close()

                    if MsgYesNo("Arquivo de log gerado. Deseja visualizar o conteúdo?", "Concluído!")
                        ShellExecute('OPEN', cLOG, "", cPath, 1)
                    endif

                endif

            endif

    endif

    &(cAlias)->(DbCloseArea())
    RestArea(aArea)

Return 

Static Function GetQuery(cPedido)
    local cQuery := ""

    cQuery := "SELECT PV.C5_NUM, PV.C5_EMISSAO, CLI.A1_NOME, COND.E4_DESCRI, PROD.C6_ITEM, PROD.C6_PRODUTO, PROD.C6_DESCRI, PROD.C6_QTDVEN, PROD.C6_PRCVEN, PROD.C6_VALOR FROM " + RetSqlName("SC5") + " PV INNER JOIN " + RetSqlName("SE4") + " COND ON PV.C5_CONDPAG = COND.E4_CODIGO INNER JOIN " + RetSqlName("SA1") + " CLI ON PV.C5_CLIENTE = CLI.A1_COD INNER JOIN " + RetSqlName("SC6") + " PROD ON PV.C5_NUM = PROD.C6_NUM WHERE C5_NUM = '" + cPedido + "'"

Return cQuery
