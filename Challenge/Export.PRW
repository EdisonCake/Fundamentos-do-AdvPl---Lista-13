#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Export
    Rotina personalizada para a exporta��o de arquivos .PDF do diret�rio do servidor at� um diret�rio na m�quina local.
    @type  Function
    @author Edison Cake
    @since 25/04/2023
    /*/
User Function Export()
    local cOrigin       := "\Pedidos de Venda\"
    local cDestination  := "C:\Vendas Protheus\"
    local aFiles        := Directory(cOrigin + "*.pdf", "D",,, 1)
    local nCount        := 0
    local nSize         := Len(aFiles)

    if nSize > 0
        if !ExistDir(cDestination)
            If MakeDir(cDestination) == 0
                For nCount := 1 to nSize
                    if !CPYS2T(cOrigin + aFiles[nCount, 1], cDestination)
                        FwAlertError("Houve um erro ao tentar copiar o arquivo para o local especificado.", "Erro!")
                    endif
                Next    
            endif

        else

            For nCount := 1 to nSize
                    if !CPYS2T(cOrigin + aFiles[nCount, 1], cDestination)
                        FwAlertError("Houve um erro ao tentar copiar o arquivo para o local especificado.", "Erro!")
                    endif
                Next
        endif
    else
        FwAlertError("N�o h� arquivos a serem copiados do diret�rio especificado.", "Erro!")
    endif

Return 
