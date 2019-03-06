#include 'protheus.ch'
#include 'parmtype.ch'
#include 'topconn.ch'

/*
** Programa para gerar o Layout 4.2 do Ato Declarat๓rio Executivo da Cordena็ใo Geral de Fiscaliza็ใo SRF No15
*/
User function FiscCli()
	If ApMsgYesNo("<p>Layouts gerados</p><b><p>Layout 4.2 Fornecedores e Clientes</p><p>Layout 4.9.1 Fornecedores e Clientes</p><p>Layout 4.7.1 Arquivo de Cadastro de Bens</p></b>","Ato Declarat๓rio Executivo da Cordena็ใo Geral de Fiscaliza็ใo SRF No15")
		RunApp()
	EndIf
Return

Static Function RunApp()

	Private DtIniQuery := "20150101"
	Private DtFimQuery := "20151231"
	Private DirTrab	   := "C:\TEMP\SRF\"
	Private FTrabCli   := "SRF4.2_C_2015.txt"
	Private FTrabFor   := "SRF4.2_F_2015.txt"
	Private FTrabCad   := "SRF4.9.1_CAD_2015.txt"
	Private FTrabBen   := "SRF4.7.1_BEM_2015.txt"

	Private FPathCli   :=DirTrab+FTrabCli
	Private FPathFor   :=DirTrab+FTrabFor
	Private FPathCad   :=DirTrab+FTrabCad
	Private FPathBem   :=DirTrab+FTrabBen

	// Cria diret๓rio de trabalho
	MakeDir(DirTrab)

	//apaga os Arquivos antigos
	If File(FPathCli)
		fErase(FPathCli)
	EndIf

	If File(FPathFor)
		fErase(FPathFor)
	EndIf

	If File(FPathCad)
		fErase(FPathCad)
	EndIf
	
	If File(FPathBem)
		fErase(FPathBem)
	EndIf
	//Gera Arquivo Cliente
	Processa({||RunCli()},"Processando Clientes...","Gerando dados...")
	//Gera Arquivo de Fornecedor
	Processa({||RunFor()()},"Processando Fornecedor...","Gerando dados...")
	//Gera o cadastro
	Processa({||GravaCad()()},"Processando Cadastros...","Gerando dados...")	
	//Gera arquivo de Bens
	Processa({||GravaAtf()()},"Processando Bens...","Gerando dados...")

return

/*
Gera o cadstro de Bens
*/
static function GravaAtf()
	local Query:=""
	Local Buff:=""
	
	
	Query+=" SELECT	N1_FILIAL,  "
	Query+=" 		N1_CBASE,   "
	Query+=" 		N1_ITEM,    "
	Query+=" 		N1_DESCRIC, "
	Query+=" 		N1_NFISCAL, "
	Query+=" 		N1_NSERIE,  "
	Query+=" 		N1_FORNEC,  "
	Query+=" 		N1_LOJA,    "
	Query+=" 		N1_AQUISIC, "
	Query+=" 		N1_VLAQUIS, "
	Query+=" 		N3_CCONTAB, "
	Query+=" 		N3_CDEPREC, "
	Query+=" 		N1_NSERIE,  "
	Query+=" 		N1_NFISCAL, "
	Query+=" 		N1_VLAQUIS, "
	Query+=" 		N1_CHAPA,   "
	Query+=" 		N3_TXDEPR1, "
	Query+=" 		N3_VRDACM1, "
	Query+=" 		N3_VRDBAL1, "
	Query+=" 		N3_DTBAIXA,  "
	Query+=" 		N3_DINDEPR  "
	Query+=" FROM SN1010 AS SN1"
	Query+=" 	JOIN SN3010 AS SN3 ON N3_FILIAL=N1_FILIAL AND N3_CBASE=N1_CBASE AND N3_ITEM=N1_ITEM "
	Query+=" WHERE "
	Query+=" SN1.D_E_L_E_T_=''"
	Query+=" AND SN3.D_E_L_E_T_='' "
	Query+=" AND N1_FILIAL IN ('1001','1002','1003')"
	Query+=" and N1_AQUISIC BETWEEN '20150101' AND '20151231'"

	If Select("TATF")>0
		TATF->(DbCloseArea())
	EndIf

	TcQuery Query New Alias"TATF"
	DbSelectArea("TATF")
	DbGotop()
	Count to N
	
	ProcRegua(N)
	DbGotop()

	If Eof()
		Return
	EndIf
	nHandle := fCreate(FPathBem,0)
	
	If nHandle<0
		conout( "Erro ao criar arquivo - FERROR " + str(FError(),4) )
		Return
	EndIf
	ik:=1
	
	While !TATF->(Eof())
		IncProc(ik)
		Buff:=""
		
		Buff+=Padr(TATF->N1_CBASE+TATF->N1_ITEM,20)
		Buff+=Padr("1",1)
		Buff+=Padr(TATF->N1_CBASE+TATF->N1_ITEM,20)
		Buff+=Padr(TATF->N1_DESCRIC,45)
		Buff+=Padr(TATF->N3_CCONTAB,28)
		Buff+=Padr(TATF->N3_CDEPREC,28)
		Buff+=FormatData(N1_AQUISIC)
		Buff+=Padr("NF",3)
		Buff+=Padr(TATF->N1_NSERIE,5)
		Buff+=Padr(TATF->N1_NFISCAL,12)
		Buff+=STRZERO(TATF->N1_VLAQUIS*100,17)
		Buff+=STRZERO(TATF->N1_VLAQUIS*100,17)
		Buff+=Padr(TATF->N1_CHAPA,12)
		Buff+=FormatData(TATF->N3_DINDEPR)
		Buff+=StrZero(TATF->N3_TXDEPR1*100,5)
		Buff+=StrZero(TATF->N3_VRDBAL1*100,17)
		Buff+=StrZero(TATF->N3_VRDACM1*100,17)
		Buff+=FormatData(TATF->N3_DTBAIXA)
		
		Buff+=CRLF
		
		fWrite(nHandle,Buff)
		TATF->(Dbskip())
		ik++
	End
	
	TATF->(DbCloseArea())
	fClose(nHandle)	
return

/*
** Gera Arquivo de Cliente
*/
Static Function RunCli()
	local Query:=""
	Local Buff:=""

	Query+=" select  A1_CONTA, "
	Query+=" A1_COD+A1_LOJA AS CODIGO, "
	Query+=" E1_TIPO, "
	Query+=" E1_PREFIXO,E1_NUM,E1_PARCELA,E1_CLIENTE,E1_LOJA,E1_FILIAL,E1_VALOR, "
	Query+=" E1_EMISSAO, "
	Query+=" E1_VENCREA,  "
	Query+=" SE1.R_E_C_N_O_ "
	Query+=" from SE1010 AS SE1	 "
	Query+=" JOIN SA1010 AS SA1 ON LEFT(E1_FILIAL,2)=A1_FILIAL AND E1_CLIENTE=A1_COD AND E1_LOJA=A1_LOJA "
	Query+=" WHERE  "
	Query+=" E1_EMISSAO BETWEEN '"+DtIniQuery+"' AND '"+DtFimQuery+"' "
	Query+=" AND SE1.D_E_L_E_T_='' "
	Query+=" AND E1_FILIAL IN ('1001','1002','1003') AND E1_TIPO IN ('FT','RA','NCC','NF')"
	query+=" ORDER BY E1_PREFIXO,E1_NUM,E1_PARCELA "
	If Select("TCLI")>0
		TCLI->(DbCloseArea())
	EndIf

	TcQuery Query New Alias"TCLI"
	DbSelectArea("TCLI")
	DbGotop()
	Count to N
	ProcRegua(N)
	DbGotop()

	If Eof()
		Return
	EndIf

	nHandle := fCreate(FPathCli,0)

	If nHandle<0
		conout( "Erro ao criar arquivo - FERROR " + str(FError(),4) )
		Return
	EndIf
	ik:=1
	While !TCLI->(Eof())

		IncProc(ik)

		CodCli:='SA1'+LEFT(TCLI->E1_FILIAL,2)+TCLI->CODIGO
		
		//Grava em arquivo o TiT
		GravaArq(TCLI->A1_CONTA,CodCli,;
						'','',TCLI->E1_VALOR,;
						'C',TCLI->E1_TIPO,;
						TCLI->E1_PREFIXO,TCLI->E1_NUM,TCLI->E1_PARCELA,TCLI->E1_VALOR,;
						TCLI->E1_EMISSAO,TCLI->E1_VENCREA,'')

		//Busca as Baixas
		DbSelectArea("SE5")
		DbSetOrder(7)//E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_SEQ, R_E_C_N_O_, D_E_L_E_T_
		DbSeek(TCLI->E1_FILIAL+TCLI->E1_PREFIXO+TCLI->E1_NUM+TCLI->E1_PARCELA+TCLI->E1_TIPO+TCLI->E1_CLIENTE+TCLI->E1_LOJA)
		
		//Grava a Baixa
		While !SE5->(Eof()) .and. TCLI->(E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO+E1_CLIENTE+E1_LOJA)==SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)
			
			IF !(SE5->E5_TIPODOC $ "VL,RA,BA,CP")
				SE5->(DbSkip())
				Loop
			ENDIF
			
			GravaArq(TCLI->A1_CONTA,CodCli,;
			DTOS(SE5->E5_DTDISPO),SE5->E5_HISTOR,SE5->E5_VALOR,;
			'R',TCLI->E1_TIPO,;
			TCLI->E1_PREFIXO,TCLI->E1_NUM,TCLI->E1_PARCELA,TCLI->E1_VALOR,;
			TCLI->E1_EMISSAO,TCLI->E1_VENCREA,;
			'')
			SE5->(DbSkip())
		End

		TCLI->(DbSkip())
		ik++
	End

	fClose(nHandle)
Return

/*
** Gera Arquivo de Fornecedor
*/
Static Function RunFor()
	local Query:=""
	Local Buff:=""

	Query+=" select  A2_CONTA, "
	Query+=" A2_COD+A2_LOJA AS CODIGO, "
	Query+=" E2_TIPO, "
	Query+=" E2_PREFIXO,E2_NUM,E2_PARCELA,E2_FORNECE,E2_LOJA,E2_FILIAL,E2_VALOR, "
	Query+=" E2_EMISSAO, "
	Query+=" E2_VENCREA,  "
	Query+=" SE2.R_E_C_N_O_ "
	Query+=" from "+RetSqlName("SE2")+" AS SE2	 "
	Query+=" JOIN "+RetSqlName("SA2")+" AS SA1 ON LEFT(E2_FILIAL,2)=A2_FILIAL AND E2_FORNECE=A2_COD AND E2_LOJA=A2_LOJA "
	Query+=" WHERE  "
	Query+=" E2_EMISSAO BETWEEN '"+DtIniQuery+"' AND '"+DtFimQuery+"' "
	Query+=" AND SE2.D_E_L_E_T_='' "
	Query+=" AND E2_FILIAL IN ('1001','1002','1003') AND E2_TIPO IN ('NDF','BOL','NF','FT','PA' ) 
	query+=" AND A2_CONTA<>'' AND NOT (A2_EST<>'EX' AND A2_CGC='') "
	query+="Order by E2_PREFIXO,E2_NUM,E2_PARCELA"

	If Select("TCLI")>0
		TCLI->(DbCloseArea())
	EndIf

	TcQuery Query New Alias"TCLI"
	DbSelectArea("TCLI")
	DbGotop()
	Count to N
	ProcRegua(N)
	DbGotop()

	If Eof()
		Return
	EndIf

	nHandle := fCreate(FPathfor,0)

	If nHandle<0
		conout( "Erro ao criar arquivo - FERROR " + str(FError(),4) )
		Return
	EndIf
	ik:=1
	While !TCLI->(Eof())

		IncProc(ik)

		CodFor:='SA2'+LEFT(TCLI->E2_FILIAL,2)+TCLI->CODIGO
		
		//Grava em arquivo o TIT
		GravaArq(TCLI->A2_CONTA,CodFor,;
					'','',TCLI->E2_VALOR,;
					'C',TCLI->E2_TIPO,;
					TCLI->E2_PREFIXO,TCLI->E2_NUM,TCLI->E2_PARCELA,TCLI->E2_VALOR,;
					TCLI->E2_EMISSAO,TCLI->E2_VENCREA,'')

		//Busca as Baixas
		DbSelectArea("SE5")
		DbSetOrder(7)//E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_SEQ, R_E_C_N_O_, D_E_L_E_T_
		DbSeek(TCLI->E2_FILIAL+TCLI->E2_PREFIXO+TCLI->E2_NUM+TCLI->E2_PARCELA+TCLI->E2_TIPO+TCLI->E2_FORNECE+TCLI->E2_LOJA)
		
		//Grava a Baixa
		While !SE5->(Eof()) .and. TCLI->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)==SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA)
		
			IF !(SE5->E5_TIPODOC $ "VL,PA,BA,CP")
				SE5->(DbSkip())
				Loop
			ENDIF
		
			GravaArq(TCLI->A2_CONTA,CodFor,;
			DTOS(SE5->E5_DTDISPO),SE5->E5_HISTOR,SE5->E5_VALOR,;
			'R',TCLI->E2_TIPO,;
			TCLI->E2_PREFIXO,TCLI->E2_NUM,TCLI->E2_PARCELA,TCLI->E2_VALOR,;
			TCLI->E2_EMISSAO,TCLI->E2_VENCREA,;
			'')
			SE5->(DbSkip())
		End

		TCLI->(DbSkip())
		ik++
	End

	fClose(nHandle)
Return

/*
**Grava o arquivo
*/
static function GravaArq(ContaContab,CodPart,DtaOperac,Hist,ValOperac,TipoOper,TipoDoc,_PREFIXO,_NUM,_PARCELA,ValorDoc,Emissao,VencRea,NumArquivo)
	Buff:=""
	Buff+=PadR(ContaContab,28)
	Buff+=PadR(CodPart,14)
	Buff+=FormatData(DtaOperac)
	Buff+=PadR(TAKECHAR(Hist),50)
	Buff+=STRZERO(ValOperac*100,17) 
	Buff+=PadR(TipoOper,1) //	TipoOperacao
	Buff+=PadR(TipoDoc,3)
	Buff+=u_FormatT2(_PREFIXO,_NUM,_PARCELA,12)
	Buff+=STRZERO(ValorDoc*100,17)
	Buff+=FormatData(Emissao)
	Buff+=FormatData(VencRea)
	Buff+=PadR('',12)
	Buff+=CRLF

	fWrite(nHandle,Buff)
return

/*
** Gera o cadastro ce cliente e fornecedor
*/
Static Function GravaCad()
	Local Query:=""
	Local Buff:=""

	Query+= " SELECT  A1_PRICOM ,'SA1'as Tabela,LEFT(A1_FILIAL,2)+ A1_COD+A1_LOJA AS CODIGO,"
	Query+= " A1_CGC,  "
	Query+= " A1_INSCR,"
	Query+= " A1_INSCRM,"
	Query+= " A1_NOME,"
	Query+= " A1_END,"
	Query+= " A1_BAIRRO,"
	Query+= " A1_MUN,"
	Query+= " A1_EST,"
	Query+= " CASE WHEN YA_CODGI='105' THEN '' ELSE YA_DESCR END AS PAIS,"
	Query+= " A1_CEP"
	Query+= " FROM "+RetSqlName("SA1")+" AS SA1"
	Query+= " JOIN "+RetSqlName("SYA")+" AS SYA  WITH(NOLOCK) ON YA_CODGI=A1_PAIS "
	Query+= " WHERE SA1.D_E_L_E_T_='' "
	

	Query+= " UNION ALL"

	Query+= " SELECT '' A1_PRICOM ,'SA2'as Tabela ,LEFT(A2_FILIAL,2)+A2_COD+A2_LOJA AS CODIGO,"
	Query+= " A2_CGC,"
	Query+= " A2_INSCR,"
	Query+= " A2_INSCRM,"
	Query+= " A2_NOME,"
	Query+= " A2_END,"
	Query+= " A2_BAIRRO,"
	Query+= " A2_MUN,"
	Query+= " A2_EST,"
	Query+= " CASE WHEN YA_CODGI='105' THEN '' ELSE YA_DESCR END AS PAIS,"
	Query+= " A2_CEP"
	Query+= " FROM "+RetSqlName("SA2")+" AS SA2"
	Query+= " JOIN "+RetSqlName("SYA")+" AS SYA  WITH(NOLOCK) ON YA_CODGI=A2_PAIS "
	Query+= " WHERE SA2.D_E_L_E_T_=''  AND A2_CONTA<>'' AND NOT (A2_EST<>'EX' AND A2_CGC='') "

	If Select("TCAD")>0
		TCAD->(DbCloseArea())
	EndIf

	TcQuery Query New Alias"TCAD"
	DbSelectArea("TCAD")
	DbGotop()

	If Eof()
		Return
	EndIf

	Count to N
	ProcRegua(N)
	DbGotop()

	nHandle := fCreate(FPathCad,0)
	If nHandle<0
		conout( "Erro ao criar arquivo - FERROR " + str(FError(),4) )
		Return
	EndIf

	While !TCAD->(Eof())
		Buff:=""
		
		DataAt:=TCAD->A1_PRICOM
		
		If Empty(DataAt)
			DataAt:=DTOS(DATE())
		EndIf
		
		Buff+=FormatData(DataAt)
		Buff+=PadR(TCAD->Tabela+TCAD->CODIGO,14)
		Buff+=PadR(TCAD->A1_CGC,14)
		Buff+=PadR(takechar(ALLTRIM(TCAD->A1_INSCR)),14)
		Buff+=PadR(takechar(TCAD->A1_INSCRM),14)
		Buff+=PadR(TAKECHAR(TCAD->A1_NOME),70)
		Buff+=PadR(TAKECHAR(TCAD->A1_END),60)
		Buff+=PadR(takechar(TCAD->A1_BAIRRO),20)
		Buff+=PadR(takechar(TCAD->A1_MUN),20)
		Buff+=PadR(TCAD->A1_EST,2)
		Buff+=PadR(TCAD->PAIS,20)
		Buff+=PadR(TCAD->A1_CEP,8)
		Buff+=CRLF

		fWrite(nHandle,Buff)
		TCAD->(dbSkip())
	End

	fClose(nHandle)
	TCAD->(DbCloseArea())
return


static function GetfirstMov(cod,loj, fil, tab)
	
return

/*
** Formata da data em DDMMAAAA
*/
static function FormatData(dataQuery)
	If !empty(dataQuery)
		ano:= SubStr(dataQuery,1,4)
		mes:= SubStr(dataQuery,5,2)
		dia:= SubStr(dataQuery,7,2)
	Else
		ano:= space(4)
		mes:= space(2)
		dia:= space(2)
	EndIf
return (dia+mes+ano)

Static Function TAKECHAR(_cDesc,_NoRemove)
	DEFAULT _NoRemove:=" "
	default _cDesc:=" "
	
	//ษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออป
	//บPrograma  ณ          บAutor  ณDaniel Pitthan      บ Data ณ  04/29/09   บ
	//ฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออน
	//บDesc.     ณ Remove qualquer tipo de caracter especial de acordo com    บ
	//บ          ณ a tabela ASCII                                             บ
	//ศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ
	/*บ*/		//Caracteres--> !''#$%&()*+,-./                          	/*บ*/
				For i:=1 to 31                                         
					If !(chr(i)$_NoRemove) 								
					_cDesc:=StrTran(_cDesc,chr(i),"")                 
				EndIf               	   							
	/*บ*/		Next                                                      	/*บ*/
	/*บ*/		For i:=33 to 47                                         	/*บ*/
	/*บ*/			If !(chr(i)$_NoRemove) 								   	/*บ*/
	/*บ*/				_cDesc:=StrTran(_cDesc,chr(i),"")                 	/*บ*/
	/*บ*/			EndIf               	   								/*บ*/
	/*บ*/		Next                                                      	/*บ*/
	/*บ*/										                         	/*บ*/
	/*บ*/		//Caracteres--> :;<=>?@			                          	/*บ*/
	/*บ*/		For i:=58 to 64                                           	/*บ*/
	/*บ*/			If !(chr(i)$_NoRemove)                                	/*บ*/
	/*บ*/				_cDesc:=StrTran(_cDesc,chr(i),"")                 	/*บ*/
	/*บ*/			EndIf                 									/*บ*/
	/*บ*/		Next                                                      	/*บ*/
	/*บ*/										                         	/*บ*/
	/*บ*/		//Caracteres--> [\]^_`			                          	/*บ*/
	/*บ*/		For i:=91 to 96                                           	/*บ*/
	/*บ*/			If !(chr(i)$_NoRemove)                                 	/*บ*/
	/*บ*/		   		_cDesc:=StrTran(_cDesc,chr(i),"")                 	/*บ*/
	/*บ*/			EndIf                 	   								/*บ*/
	/*บ*/		Next                                                      	/*บ*/
	/*บ*/										                         	/*บ*/
	/*บ*/		//Caracteres--> {|}~ DEL		                          	/*บ*/
	/*บ*/		For i:=123 to 255                                         	/*บ*/
	/*บ*/			If !(chr(i)$_NoRemove)                                	/*บ*/
	/*บ*/				_cDesc:=StrTran(_cDesc,chr(i),"")                 	/*บ*/
	/*บ*/			EndIf                									/*บ*/
	/*บ*/		Next       													/*บ*/
	/*บ*/										                         	/*บ*/
	/***/       _cDesc:=StrTran(_cDesc,chr(12),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(10),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(13),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(150),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(180),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(218),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(226),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(96),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(240),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(220),"")							/***/ 
	/***/       _cDesc:=StrTran(_cDesc,chr(170),"")							/***/ 
	/*บ*/		_cDesc:=NoAcento(_cDesc)                                   	/*บ*/
	//ศอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

Return(TRIM(_cDesc))

static FUNCTION NoAcento(cString)
	Local cChar  := ""
	Local nX     := 0
	Local nY     := 0
	Local cVogal := "aeiouAEIOU"
	Local cAgudo := "แ้ํ๓๚"+"มษอำฺ"
	Local cCircu := "โ๊๎๔๛"+"ยสฮิÛ"
	Local cTrema := "ไ๋๏๖ü"+"ฤหฯึÜ"
	Local cCrase := "เ่์๒๙"+"ภศฬาู"
	Local cTio   := "ใ๕"
	Local cCecid := "็ว"

	For nX:= 1 To Len(cString)
		cChar:=SubStr(cString, nX, 1)
		IF cChar$cAgudo+cCircu+cTrema+cCecid+cTio+cCrase
			nY:= At(cChar,cAgudo)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
			EndIf
			nY:= At(cChar,cCircu)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
			EndIf
			nY:= At(cChar,cTrema)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
			EndIf
			nY:= At(cChar,cCrase)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr(cVogal,nY,1))
			EndIf
			nY:= At(cChar,cTio)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr("ao",nY,1))
			EndIf
			nY:= At(cChar,cCecid)
			If nY > 0
				cString := StrTran(cString,cChar,SubStr("cC",nY,1))
			EndIf
		Endif
	Next
	For nX:=1 To Len(cString)
		cChar:=SubStr(cString, nX, 1)
		If Asc(cChar) < 32 .Or. Asc(cChar) > 123
			cString:=StrTran(cString,cChar,"")
		Endif
	Next nX
Return cString