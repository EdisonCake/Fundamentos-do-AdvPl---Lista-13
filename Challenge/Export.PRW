#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Export
    Rotina personalizada para a exportação de arquivos .PDF do diretório do servidor até um diretório na máquina local.
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
        FwAlertError("Não há arquivos a serem copiados do diretório especificado.", "Erro!")
    endif

Return 
