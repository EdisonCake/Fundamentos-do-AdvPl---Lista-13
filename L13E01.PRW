#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function NewFolder
    Programa para a cria��o de uma pasta no diret�rio tempor�rio do Windows.
    @type  Function
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function NewFolder()
    local cPath := GetTempPath()
    local cFolder := "Lista 13 - Ex.01\"

    if !ExistDir(cPath + cFolder)
        if MakeDir(cPath + cFolder) == 0
            FwAlertSuccess("Diret�rio criado com sucesso!", "Conclu�do")
        else
            Help(NIL, NIL, "Aten��o!", NIL, "O diret�rio n�o p�de ser criado.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o diret�rio j� n�o foi criado anteriormente e/ou se possui as autoriza��es de administrador do sistema para a cria��o de pastas e/ou arquivos."})
        endif

    else
        Help(NIL, NIL, "Aten��o!", NIL, "O diret�rio n�o p�de ser criado.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o diret�rio j� n�o foi criado anteriormente e/ou se possui as autoriza��es de administrador do sistema para a cria��o de pastas e/ou arquivos."})
    endif
Return 
