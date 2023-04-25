#INCLUDE 'TOTVS.CH'

#DEFINE NOME 1

/*/{Protheus.doc} User Function ByeFile
    Função para deletar os arquivos e diretórios criados anteriormente no path temporário.
    @type  Function
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function ByeFile()
    local cPath     := GetTempPath() + "Lista 13 - Ex.01\"
    local aFiles    := Directory(cPath + "*.*", "D",,, 1)
    local nCount    := 0

    if ExistDir(cPath)
        if MsgYesNo("Deseja realmente excluir a pasta?", "Atenção")
            if len(aFiles) > 0
                For nCount := 3 to len(aFiles)
                    If FErase(cPath + aFiles[nCount, NOME]) == -1
                        // Help(NIL, NIL, "Atenção!", NIL, "Houve um erro ao tentar excluir o arquivo " + aFiles[nCount, NOME], 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se você possui as permissões necessárias para realizar a exclusão e tente novamente."})

                        FwAlertError("Não foi possível excluir o arquivo " + aFiles[nCount, NOME] + ".", "Atenção!")
                    endif
                Next
            endif

            if DirRemove(cPath)
                FwAlertSuccess("Diretório excluído com sucesso.", "Concluído")
            else
                // Help(NIL, NIL, "Atenção!", NIL, "Houve um erro ao tentar excluir o diretório " + cPath, 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se você possui as permissões necessárias para realizar a exclusão e tente novamente."})

                FwAlertError("Não foi possível excluir o diretório informado!", "Atenção!")
            endif

        endif
    else
        // Help(NIL, NIL, "Atenção!", NIL, "O diretório " + cPath + " não existe!", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se as informações necessárias para realizar a exclusão estão corretas e tente novamente."})

        FwAlertError("O diretório " + cPath + " não existe!", "Atenção")

    endif
Return 
