#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RPTDEF.CH'
#INCLUDE 'FWPRINTSETUP.CH'

#DEFINE VERMELHO    RGB(139,0,0)
#DEFINE AZUL        RGB(25,25,112)

#DEFINE LINHA_1     105
#DEFINE LINHA_FIM   770

/*/{Protheus.doc} User Function MsPedido
    Função para a emissão de um arquivo em PDF e salvamento automático no diretório criado anteriormente.
    @type  Function
    @author Edison Cake
    @since 25/04/2023
    /*/
User Function MsPedido(cPath, cFile)
    local cAlias := GeraCons()
    local cPDF := cFile + ".pdf"

    if !Empty(cAlias)

        Processa({|| MontaRel(cAlias, cPDF)}, "Aguarde...", "Gerando Informações.", .F.)
    else

        FwAlertError("Nenhum registro encontrado.", "Atenção!")
    endif
Return 

Static Function GeraCons()
    local aArea     := GetArea()
    local cAlias    := GetNextAlias()
    local cQuery := ""

    cQuery := "SELECT PV.C5_NUM, PV.C5_EMISSAO, CLI.A1_NOME, COND.E4_CODIGO, COND.E4_DESCRI, PROD.C6_ITEM, PROD.C6_PRODUTO, PROD.C6_DESCRI, PROD.C6_QTDVEN, PROD.C6_PRCVEN, PROD.C6_VALOR FROM " + RetSqlName("SC5") + " PV INNER JOIN " + RetSqlName("SE4") + " COND ON PV.C5_CONDPAG = COND.E4_CODIGO INNER JOIN " + RetSqlName("SA1") + " CLI ON PV.C5_CLIENTE = CLI.A1_COD INNER JOIN " + RetSqlName("SC6") + " PROD ON PV.C5_NUM = PROD.C6_NUM WHERE C5_NUM = '" + alltrim(M->C5_NUM) + "'"

    TCQUERY cQuery ALIAS (cAlias) NEW
    (cAlias)->(DbGoTop())

    if (cAlias)->(Eof())
        cAlias := ""
    endif

    RestArea(aArea)
Return cAlias

Static Function MontaRel(cAlias, cPDF)
    local cCaminho := "C:\TOTVS12\Protheus\protheus_data\pedidos de venda\"
    local cArquivo := cPDF + ".pdf"

    private nLinha := LINHA_1
    private oPrint

    private oFont10 := TFont():New("Fira Code",,10,,.F.,,,,,.F.,.F.)
    private oFont12 := TFont():New("Fira Code",,12,,.T.,,,,,.F.,.F.)
    private oFont14 := TFont():New("Fira Code",,14,,.T.,,,,,.F.,.F.)
    private oFont16 := TFont():New("Fira Code",,16,,.T.,,,,,.T.,.F.)

    oPrint := FwMsPrinter():New(cArquivo, IMP_PDF, .F., "", .T.,, @oPrint,,,,, .T.)
    oPrint:cPathPDF := cCaminho
    oPrint:SetPortrait()
    oPrint:SetPaperSize(9)
    oPrint:StartPage()

    Top(cAlias)
    Info(cAlias)

    oPrint:EndPage()
    oPrint:Preview()
Return

Static Function Top(cAlias)
    local cString := ""

    oPrint:Box(15, 15, 85, 580, '-8')
    oPrint:Line(50, 15, 50, 580,,'-6')

    oPrint:Say(35, 020, "Empresa/Filial: " + alltrim(SM0->M0_NOME) + "/" + alltrim(SM0->M0_FILIAL), oFont14)
    oPrint:Say(70, 020, "Informações do Pedido " + alltrim((cAlias)->(C5_NUM)), oFont14)

    oPrint:Say(nLinha, 020, "CODIGO", oFont12,, AZUL)
    oPrint:Say(nLinha, 200, "CLIENTE", oFont12,, AZUL)
    oPrint:Say(nLinha, 320, "PAGAMENTO" , oFont12,, AZUL)
    oPrint:Say(nLinha, 485, "EMISSÃO"   , oFont12,, AZUL)

    nLinha += 5
    oPrint:Line(nLinha, 15, nLinha, 580,, '-6')
    nLinha += 10

    oPrint:Say(nLinha, 020, alltrim((cAlias)->(C5_NUM)), oFont12,, VERMELHO)

    cString := alltrim((cAlias)->(A1_NOME))
    xQuebraCab(cString, 20, 200)

    oPrint:Say(nLinha, 320, alltrim((cAlias)->(E4_CODIGO)) + " - " + alltrim((cAlias)->(E4_DESCRI)), oFont12,, VERMELHO)
    cString := DtoC(StoD((cAlias)->(C5_EMISSAO)))
    oPrint:Say(nLinha, 485, cString, oFont12,, VERMELHO)
    nLinha += 30


    oPrint:Say(nLinha, 020, "CODIGO",   oFont12,, AZUL)
    oPrint:Say(nLinha, 200, "PRODUTO",  oFont12,, AZUL)
    oPrint:Say(nLinha, 400, "QTD.",     oFont12,, AZUL)
    oPrint:Say(nLinha, 450, "UNITÁRIO", oFont12,, AZUL)
    oPrint:Say(nLinha, 540, "TOTAL",    oFont12,, AZUL)

    nLinha += 5
    oPrint:Line(nLinha, 15, nLinha, 580,, '-6')
    nLinha += 10
Return

Static Function Info(cAlias)
    local cString := ""
    local nTotal  := 0
    
    DbSelectArea(cAlias)
    (cAlias)->(DbGoTop())

    While (cAlias)->(!EoF())
        Final(LINHA_FIM)

        cString := alltrim((cAlias)->(C6_PRODUTO))
        QuebraCorpo(cString, 20, 20)

        cString := alltrim((cAlias)->(C6_DESCRI))
        QuebraCorpo(cString, 50, 200)

        oPrint:Say(nLinha, 400, cvaltochar((cAlias)->(C6_QTDVEN)), oFont10,, VERMELHO)
        oPrint:Say(nLinha, 450, "R$ " + cvaltochar((cAlias)->(C6_PRCVEN)), oFont10,, VERMELHO)
        oPrint:Say(nLinha, 540, "R$ " + cvaltochar((cAlias)->(C6_VALOR)), oFont10,, VERMELHO)
        
        nLinha += 30
        IncProc()

        nTotal += (cAlias)->(C6_VALOR)
        (cAlias)->(DbSkip())
    End do

    oPrint:Line(nLinha, 450, nLinha, 580)
    nLinha += 10

    oPrint:Say(nLinha, 450, "TOTAL", oFont12,, AZUL)
    oPrint:Say(nLinha, 530, "R$ " + cvaltochar(nTotal), oFont12,, VERMELHO)

Return

Static Function xQuebraCab(cString, nChar, nColuna)
    local cText     := ""
    local lQuebra   := .F.
    local nLinhas   := MlCount(cString, nChar,, .F.)
    local nCount    := 0

    if nLinhas > 1
        lQuebra := .T.
        For nCount := 1 to nLinhas
            cText := MemoLine(cString, nChar, nCount)
            oPrint:Say(nLinha, nColuna, cText, oFont12,, VERMELHO)
            nLinha += 10
        Next
    else
        oPrint:Say(nLinha, nColuna, cString, oFont12,, VERMELHO)
    endif

    if lQuebra
        nLinha -= (nLinhas * 10)
    endif

Return

Static Function QuebraCorpo(cString, nChar, nColuna)
    local cText     := ""
    local lQuebra   := .F.
    local nLinhas   := MlCount(cString, nChar,, .F.)
    local nCount    := 0

    if nLinhas > 1
        lQuebra := .T.
        For nCount := 1 to nLinhas
            cText := MemoLine(cString, nChar, nCount)
            oPrint:Say(nLinha, nColuna, cText, oFont10,, VERMELHO)
            nLinha += 10
        Next
    else
        oPrint:Say(nLinha, nColuna, cString, oFont10,, VERMELHO)
    endif

    if lQuebra
        nLinha -= (nLinhas * 10)
    endif

Return

Static Function Final(nLinhaFinal)
    if nLinha > nLinhaFinal
        oPrint:EndPage()
        oPrint:StartPage()

        nLinha := LINHA_1
        Top(cAlias)
    endif
Return
