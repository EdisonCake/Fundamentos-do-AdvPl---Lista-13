#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function NewFolder
    Programa para a criação de uma pasta no diretório temporário do Windows.
    @type  Function
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function NewFolder()
    local cPath := GetTempPath()
    local cFolder := "Lista 13 - Ex.01\"

    if !ExistDir(cPath + cFolder)
        if MakeDir(cPath + cFolder) == 0
            FwAlertSuccess("Diretório criado com sucesso!", "Concluído")
        else
            Help(NIL, NIL, "Atenção!", NIL, "O diretório não pôde ser criado.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o diretório já não foi criado anteriormente e/ou se possui as autorizações de administrador do sistema para a criação de pastas e/ou arquivos."})
        endif

    else
        Help(NIL, NIL, "Atenção!", NIL, "O diretório não pôde ser criado.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o diretório já não foi criado anteriormente e/ou se possui as autorizações de administrador do sistema para a criação de pastas e/ou arquivos."})
    endif
Return 
