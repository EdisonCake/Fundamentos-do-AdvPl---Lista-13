#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function NewFile
    Função para a criação de um arquivo .txt no diretório anteriormente criado.
    @type  Function
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function NewFile()
    local cPath := GetTempPath() + "Lista 13 - Ex.01\"
    local cFile := "Exercicio_02.txt"
    local oFile := FwFileWriter():New(cPath + cFile, .T.)

    if File(cPath + cfile)
        Help(NIL, NIL, "Atenção!", NIL, "O arquivo não pôde ser criado.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o diretório existe, ou se o arquivo informado já não foi anteriormente criado e/ou se possui as autorizações de administrador do sistema para a criação de pastas e/ou arquivos."})
    else
        if !oFile:Create()
            Help(NIL, NIL, "Atenção!", NIL, "Houve um erro ao tentar criar o arquivo.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o diretório existe, ou se o arquivo informado já não foi anteriormente criado e/ou se possui as autorizações de administrador do sistema para a criação de pastas e/ou arquivos."})
        else    
            oFile:Write("Teste!")

            oFile:Close()

            if MsgYesNo("Arquivo gerado com sucesso!" + CRLF +;
            "Deseja visualizar?", "Concluído!")
                ShellExecute('OPEN', cFile, "", cPath, 1)
            endif
        endif
    endif
Return 
