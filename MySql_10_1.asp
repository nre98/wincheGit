<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
Option Explicit
' @title		: 테스트용
' @file_name	: dbtest.asp
' @description	: 테스트
' @create_info	: 2017-01-20
Response.CharSet = "utf-8"
'Response.CharSet = "euc-kr"
%>
<%
Dim dbConnTmp    ' Connection 객체 선언
Dim cmdRs          ' Record Set 객체 선언
Dim mcnt, query
 
Dim sSeq : sSeq = request("seq")
	if sSeq = "" then sSeq = 0 end if
      

Set dbConnTmp = Server.CreateObject("ADODB.Connection")  ' ADODB
dbConnTmp.Open "Driver={MySQL ODBC 3.51 driver};Server=211.61.133.10; Database=asteriskcdrdb; Uid=ccdev; Pwd=ccdev1234;charset=euckr"  

    
if dbConnTmp.errors.count = 0 then ' 접속 시, 에러 발생 여부를 확인합니다.
    Response.Write "MySQL 접속 성공!<br>" 
    query ="SELECT uniqueid, calldate, src, dst, accountcode, clid, userfield FROM cdr WHERE (disposition='NO ANSWER' OR dcontext LIKE 'app-%') AND accountcode != '2' ORDER BY uniqueid DESC LIMIT 100"
    set cmdRs = dbConnTmp.Execute(query)
    If Not (cmdRs.Bof Or cmdRs.Eof) Then
		Do Until cmdRs.Eof
			response.write "uniqueid=="&cmdRs(0)
			response.write "calldate=="&cmdRs(1)
			response.write "src=="&cmdRs(2)
			response.write "dst=="&cmdRs(3)
			response.write "accountcode=="&cmdRs(4)
			response.write "clid=="&cmdRs(5)
            response.write "userfield=="&cmdRs(6)
            response.write "<br>"
        cmdRs.MoveNext
		Loop
	End If
    Set cmdRs = Nothing
    ''response.write "<br>=="&  cmdRs("YExtStatus") 

else

    Response.Write "MySQL 접속 실패!"

    Response.End
end if 
%>
