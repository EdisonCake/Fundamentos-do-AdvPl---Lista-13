#INCLUDE 'TOTVS.CH'

#DEFINE NOME 1

/*/{Protheus.doc} User Function CopyPaste
    Função que criará uma nova pasta no diretório do Protheus e copiará o arquivo gerado anteriormente.
    @type  Function CopyPaste
    @author Edison Cake
    @since 24/04/2023
    /*/
User Function CopyPaste()
    local cOrigin       := GetTempPath() + "Lista 13 - Ex.01\"
    local cDestination  := "\Lista 13\"
    local aFiles        := Directory(cOrigin + "exercicio_02.txt", "D",,, 1)
    local nCount        := 0
    local nSize         := Len(aFiles)

    if nSize > 0
        if !ExistDir(cDestination)
            If MakeDir(cDestination) == 0
                For nCount := 1 to nSize
                    if !CPYT2S(cOrigin + aFiles[nCount, NOME], cDestination)
                        Help(NIL, NIL, "Atenção!", NIL, "Houve um erro ao tentar copiar o arquivo.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o arquivo existe no diretório informado e/ou se o diretório é válido e tente novamente."})
                    endif
                Next    
            endif

        else

            For nCount := 1 to nSize
                    if !CPYT2S(cOrigin + aFiles[nCount, NOME], cDestination)
                        Help(NIL, NIL, "Atenção!", NIL, "Houve um erro ao tentar copiar o arquivo.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o arquivo existe no diretório informado e/ou se o diretório é válido e tente novamente."})
                    endif
                Next
        endif
    else
        Help(NIL, NIL, "Atenção!", NIL, "Diretório vazio.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o arquivo existe no diretório informado e/ou se o diretório é válido e tente novamente."})
    endif
Return 
