#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function NewFile
    Fun��o para a cria��o de um arquivo .txt no diret�rio anteriormente criado.
    @type  Function
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function NewFile()
    local cPath := GetTempPath() + "Lista 13 - Ex.01\"
    local cFile := "Exercicio_02.txt"
    local oFile := FwFileWriter():New(cPath + cFile, .T.)

    if File(cPath + cfile)
        Help(NIL, NIL, "Aten��o!", NIL, "O arquivo n�o p�de ser criado.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o diret�rio existe, ou se o arquivo informado j� n�o foi anteriormente criado e/ou se possui as autoriza��es de administrador do sistema para a cria��o de pastas e/ou arquivos."})
    else
        if !oFile:Create()
            Help(NIL, NIL, "Aten��o!", NIL, "Houve um erro ao tentar criar o arquivo.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o diret�rio existe, ou se o arquivo informado j� n�o foi anteriormente criado e/ou se possui as autoriza��es de administrador do sistema para a cria��o de pastas e/ou arquivos."})
        else    
            oFile:Write("Teste!")

            oFile:Close()

            if MsgYesNo("Arquivo gerado com sucesso!" + CRLF +;
            "Deseja visualizar?", "Conclu�do!")
                ShellExecute('OPEN', cFile, "", cPath, 1)
            endif
        endif
    endif
Return 
