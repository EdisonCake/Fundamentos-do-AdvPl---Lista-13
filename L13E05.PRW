#INCLUDE 'TOTVS.CH'

#DEFINE NOME 1

/*/{Protheus.doc} User Function ByeFile
    Fun��o para deletar os arquivos e diret�rios criados anteriormente no path tempor�rio.
    @type  Function
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function ByeFile()
    local cPath     := GetTempPath() + "Lista 13 - Ex.01\"
    local aFiles    := Directory(cPath + "*.*", "D",,, 1)
    local nCount    := 0

    if ExistDir(cPath)
        if MsgYesNo("Deseja realmente excluir a pasta?", "Aten��o")
            if len(aFiles) > 0
                For nCount := 3 to len(aFiles)
                    If FErase(cPath + aFiles[nCount, NOME]) == -1
                        // Help(NIL, NIL, "Aten��o!", NIL, "Houve um erro ao tentar excluir o arquivo " + aFiles[nCount, NOME], 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se voc� possui as permiss�es necess�rias para realizar a exclus�o e tente novamente."})

                        FwAlertError("N�o foi poss�vel excluir o arquivo " + aFiles[nCount, NOME] + ".", "Aten��o!")
                    endif
                Next
            endif

            if DirRemove(cPath)
                FwAlertSuccess("Diret�rio exclu�do com sucesso.", "Conclu�do")
            else
                // Help(NIL, NIL, "Aten��o!", NIL, "Houve um erro ao tentar excluir o diret�rio " + cPath, 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se voc� possui as permiss�es necess�rias para realizar a exclus�o e tente novamente."})

                FwAlertError("N�o foi poss�vel excluir o diret�rio informado!", "Aten��o!")
            endif

        endif
    else
        // Help(NIL, NIL, "Aten��o!", NIL, "O diret�rio " + cPath + " n�o existe!", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se as informa��es necess�rias para realizar a exclus�o est�o corretas e tente novamente."})

        FwAlertError("O diret�rio " + cPath + " n�o existe!", "Aten��o")

    endif
Return 
