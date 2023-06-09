#INCLUDE 'TOTVS.CH'

#DEFINE NOME 1

/*/{Protheus.doc} User Function CopyPaste
    Fun��o que criar� uma nova pasta no diret�rio do Protheus e copiar� o arquivo gerado anteriormente.
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
                        Help(NIL, NIL, "Aten��o!", NIL, "Houve um erro ao tentar copiar o arquivo.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o arquivo existe no diret�rio informado e/ou se o diret�rio � v�lido e tente novamente."})
                    endif
                Next    
            endif

        else

            For nCount := 1 to nSize
                    if !CPYT2S(cOrigin + aFiles[nCount, NOME], cDestination)
                        Help(NIL, NIL, "Aten��o!", NIL, "Houve um erro ao tentar copiar o arquivo.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o arquivo existe no diret�rio informado e/ou se o diret�rio � v�lido e tente novamente."})
                    endif
                Next
        endif
    else
        Help(NIL, NIL, "Aten��o!", NIL, "Diret�rio vazio.", 1, 0, NIL, NIL, NIL, NIL, NIL, {"Verifique se o arquivo existe no diret�rio informado e/ou se o diret�rio � v�lido e tente novamente."})
    endif
Return 
