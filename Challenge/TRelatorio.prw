#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function TRelatorio
    Relatório com a classe TReport para resumir o pedido de venda recém-criado no ponto de entrada MT410TOK do Challenge.
    @type  Function
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function TRelatorio(cPath, cFile)
    oReport:cFile := cCaminho
    oReport:PrintDialog()
Return 

Static Function GetReport()
    local cAlias        := GetNextAlias()
    local oRelatorio    := TReport():New("TREPORT", "Pedido de venda",, {|oRelatorio| GetInfo(oRelatorio, cAlias)}, "Esse relatório imprimirá as informações do pedido de venda recém adicionado", .F.)

    local oSection1     := TRSection():New(oRelatorio, "Informações do Pedido de Venda",,,,,,,,,, .T.)
    local oSection2     := TRSection():New(oSection1, "Produtos no Pedido de Venda",,,,,,,,,, .T.)
    local oQuebraLinha

    private cPedido     := ""
    private cCliente    := ""
    private cEmissao    := ""
    private cPagto      := ""

    private cItem       := ""
    private cProduto    := ""
    private cDesc       := ""
    private cQtd        := ""
    private nPreco      := ""
    private nValTot     := ""
        
    TRCell():New(oSection1, "PEDIDO", cAlias, "PEDIDO",, 20,, {|| Alltrim("Pedido: " + cPedido)}, "CENTER", .T., "CENTER",,,,,, .T.)
    TRCell():New(oSection1, "CLIENTE", cAlias, "CLIENTE",, 20,, {|| Alltrim(cCliente)}, "LEFT", .T., "LEFT",,,,,, .T.)
    TRCell():New(oSection1, "EMISSAO", cAlias, "EMISSAO", PesqPict("SC5", "C5_EMISSAO"), 12,, {|| Alltrim(cEmissao)}, "CENTER", .T., "CENTER",,,,,, .T.)
    TRCell():New(oSection1, "PAGAMENTO", cAlias, "PAGAMENTO",, 20,, {|| Alltrim(cPagto)}, "CENTER", .T., "CENTER",,,,,, .T.)

    TrCell():New(oSection2, "ITEM", cAlias, "ITEM",, 6,, {|| Alltrim(cItem)}, "CENTER", .T., "CENTER",,,,,, .T.)
    TrCell():New(oSection2, "PRODUTO", cAlias, "PRODUTO",, 20,, {|| Alltrim(cProduto)}, "LEFT", .T., "LEFT",,,,,, .T.)
    TrCell():New(oSection2, "DESCRICAO", cAlias, "DESCRICAO",, 30,, {|| Alltrim(cDesc)}, "LEFT", .T., "LEFT",,,,,, .T.)
    TrCell():New(oSection2, "QTD.", cAlias, "QTD.",, 6,, {|| Alltrim(cQtd)}, "CENTER", .T., "CENTER",,,,,, .T.)
    TrCell():New(oSection2, "VALOR", cAlias, "VALOR",, 10,, {|| nPreco}, "CENTER", .T., "CENTER",,,,,, .T.)
    TrCell():New(oSection2, "TOTAL", cAlias, "TOTAL",, 10,, {|| nValTot}, "CENTER", .T., "CENTER",,,,,, .T.)

    oQuebraLinha := TRBreak():New(oSection1, oSection1:Cell("PEDIDO"), "", .T.)
    TrFunction():New(oSection2:Cell("TOTAL"), "VALTOT", "SUM", oQuebraLinha, "VALOR TOTAL",,, .F., .F., .F.)

Return oRelatorio

Static Function GetInfo(oRelatorio, cAlias)
    local oSection1 := oRelatorio:Section(1)
    local oSection2 := oSection1:Section(1)

    local cQuery    := GeraQuery()
    local nTotal    := 0
    local cCodigo   := ""

    DbUseArea(.T., "TOPCONN", TcGenQry(NIL, NIL, cQuery), cAlias, .T., .T.)
    Count to nTotal

    oRelatorio:SetMeter(nTotal)
    oRelatorio:StartPage()
    (cAlias)->(DbGoTop())

    While (cAlias)->(!EoF())

        if alltrim(cCodigo) != alltrim((cAlias)->(C5_NUM))

            if !Empty(cCodigo)
                oSection2:Finish()
                oSection1:Finish()
                oRelatorio:EndPage()
            endif

            oSection1:Init()

            cPedido     := alltrim((cAlias)->C5_NUM)
            cEmissao    := DtoC(StoD((cAlias)->C5_EMISSAO))
            cCliente    := alltrim((cAlias)->A1_NOME)
            cPagto      := alltrim((cAlias)->E4_DESCRI)
            cCodigo     := alltrim((cAlias)->C5_NUM)

            oSection1:PrintLine()
            oSection2:Init()
        endif

        cItem       := alltrim((cAlias)->C6_ITEM)
        cProduto    := alltrim((cAlias)->C6_PRODUTO)
        cDesc       := alltrim((cAlias)->C6_DESCRI)
        cQtd        := cvaltochar((cAlias)->C6_QTDVEN)

        nPreco      := (cAlias)->C6_PRCVEN
        nValTot     := (CaLIAS)->C6_VALOR
        oSection2:PrintLine()

        (cAlias)->(DbSkip())
    End While

    oSection1:Finish()
    oSection2:Finish()

    (cAlias)->(DbCloseArea())
    oRelatorio:EndPage()

Return 

Static Function GeraQuery()
    local cQuery := ""

    cQuery := "SELECT PV.C5_NUM, PV.C5_EMISSAO, CLI.A1_NOME, COND.E4_DESCRI, PROD.C6_ITEM, PROD.C6_PRODUTO, PROD.C6_DESCRI, PROD.C6_QTDVEN, PROD.C6_PRCVEN, PROD.C6_VALOR FROM " + RetSqlName("SC5") + " PV INNER JOIN " + RetSqlName("SE4") + " COND ON PV.C5_CONDPAG = COND.E4_CODIGO INNER JOIN " + RetSqlName("SA1") + " CLI ON PV.C5_CLIENTE = CLI.A1_COD INNER JOIN " + RetSqlName("SC6") + " PROD ON PV.C5_NUM = PROD.C6_NUM WHERE C5_NUM = '" + alltrim(M->C5_NUM) + "'"

Return cQuery
