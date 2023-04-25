#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function GetFile
    Função para a abertura do arquivo gerado anteriormente.
    @type  Function
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function GetFile()
    local cPath     := GetTempPath() + "Lista 13 - Ex.01\"
    local cFile     := "Exercicio_02.txt"
    local cLine     := ""
    local nCount    := 1
    local oFile     := FwFileReader():New(cPath + cFile)

    if oFile:Open()
        if !oFile:Eof()
            while oFile:HasLine()
                cLine += "Linha " + cvaltochar(nCount) + ": " + oFile:GetLine(.T.)
            end do
        endif
    else
        Help(NIL, NIL, "Atenção!", NIL, "Houve um erro ao tentar abrir o arquivo.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o arquivo existe no diretório informado e tente novamente."})
    endif

    oFile:Close()
    FwAlertInfo(cLine, "Conteúdo do Arquivo:")

Return 
