<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.sql.*" %>      
<% // content.jsp는 하나의 레코드의 내용을 전부 보여준다...
  
  // DB연결
   String aa="jdbc:mysql://localhost:3307/amudo?useSSL=false";
   String bb="root";
   String cc="1234";
   Connection conn = DriverManager.getConnection(aa,bb,cc); 
   Statement stmt=conn.createStatement();
  // 읽어오고자 하는 레코드의 id값을 받기
   String id=request.getParameter("id");
   String Page=request.getParameter("page");
  
  // 쿼리작성 => 하나의 레코드만 읽어오는 쿼리
   String sql="select * from board where id="+id;
  // select * from board where id=3;
  // select한 결과값을 사용하려고 하면 ResultSet에 가져와야 된다.
   ResultSet rs=stmt.executeQuery(sql);
  // 하나의 레코드만 읽어온다..
   rs.next();
  
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body> <!-- 이름, 제목, 내용, 조회수, 작성일, 나이, 성별 -->
   <table width=600 border=1 cellspacing=0>
    <tr>
      <td> 제 목 </td>
      <td colspan=3> <%=rs.getString("title")%></td>
    </tr>
    <tr>
      <td> 이 름 </td>
      <td> <%=rs.getString("name")%> </td>
      <td> 조회수 </td>
      <td> <%=rs.getString("rnum")%></td>
    </tr>
    <tr height=200>
      <td> 내 용 </td>
      <td colspan=3> <%=rs.getString("content").replace("\r\n","<br>")%></td>
    </tr>
    <%
        String age="";   
        switch(rs.getInt("age"))  // 10대 ~50대 => 0,1,2,3,4
        {
          case 0: age="10대"; break;
          case 1: age="20대"; break;
          case 2: age="30대"; break;
          case 3: age="40대"; break;
          case 4: age="50대"; break;
        }
        
        String sung;
        if(rs.getInt("sung")==0)  // 0이면 남자, 1이면 여자
        	sung="남자";
        else
        	sung="여자";
%>
    <tr>
      <td> 나 이 </td>
      <td> <%=age%></td>
      <td> 성 별 </td>
      <td> <%=sung%></td>
    </tr>
    <tr>
      <td> 작성일 </td>
      <td colspan=3> <%=rs.getString("writeday")%> </td>
    </tr>
    <tr>
      <td colspan=4 align=center>
      <a href="update.jsp?id=<%=id%>"> 수정 </a>
      <a href="javascript:del()"> 삭제 </a>
      <a href="list.jsp?page=<%=Page%>"> 목록 </a>
      </td>
    </tr>
   </table>
   <!-- 댓글 출력 -->
   <%
     // 쿼리 작성(댓글)
     sql="select * from dat where b_id="+id+" order by id desc";
     rs=stmt.executeQuery(sql);
   %>
   <style>
     #del_form {
        display:inline;
        display:none;
     }
   </style>
   <script>
     function view_form(n)
     {
    	 // 폼태그를 보여주기
    	 //document.getElementById("del_form").style.display="inline";
    	 // 이문서내에서 id=del_form인 요소를 => 하나의 id만 접근
    	 
    	 // class를 이용하여 가져오기
    	 var dd=document.getElementsByClassName("del_form");
    	 dd[n].style.display="inline";
    	 
    	
     }
   </script>
   <table width=600><!-- <tr> 하나에 댓글 하나 -->
   <%
    int ckk=0;
    while(rs.next()) // 레코드가 있을때 반복문 실행
    {
   %>
    <tr> 
      <td style="border:1px solid black"> 
      댓글목록 
      <%
       String a=rs.getString("name");
       String b=rs.getString("content").replace("\r\n","<br>");
       String c=rs.getString("id");
      %>
      <a href="javascript:up_form('<%=a%>','<%=b%>',<%=c%>)" style="margin-left:250px"> 수정 </a>
      <!-- 삭제를 클릭하면 댓글을 삭제 (값)=> dat테이블 => id,pwd  -->
      <a href="javascript:view_form(<%=ckk%>)" style="margin-left:30px"> 삭제 </a>
      
      <form id=del_form class=del_form method=post action=dat_delete.jsp>
        <input type=hidden name=id value=<%=rs.getString("id")%>>
        <input type=password name=pwd placeholder="비밀번호" size=6>
        <input type=submit value=삭제>
      </form>
      
      <hr>
      <%=rs.getString("name")%> 작성일 <%=rs.getString("writeday")%><p>
      <%=b%>
      </td>
    </tr>
   <%
       ckk++; // 1씩증가
    } // dat테이블의 출력이 종료 => rs는 가장 밑으로 이동
   %> 
   </table>
   <script>
     function up_form(aa,bb,cc) // aa:이름, bb:내용, cc:id
     {
    	 document.getElementById("up_form").style.visibility="visible";
    	 document.up_form.name.value=aa;
       	 bb=bb.replace(/<br>/gi,"\r\n"); // 치환값을 리턴해주는 함수
    	 document.up_form.content.value=bb;
    	 document.up_form.id.value=cc;
     }
     function hide1()
     {
    	 document.getElementById("up_form").style.visibility="hidden";
     }
   </script>
   <style>
     #up_form {
       position:absolute;
       left:300px;
       top:200px;
       background:white;
       border:1px solid black;
       padding:10px;
       visibility:hidden;
     }
   </style>
   <!-- 댓글 수정폼 시작-->
     <form name=up_form id=up_form method=post action=dat_update_ok.jsp>
        <input type=hidden name=id>
        <input type=hidden name=page value=<%=Page%>>
       이름 <input type=text name=name size=6><p>
       내용  <textarea cols=40 rows=3 name=content></textarea> <p>
     비번  <input type=password name=pwd placeholder="비밀번호" size=6> <p>
        <input type=submit value=수정>
        <input type=button onclick="hide1()" value=닫기>
     </form>  
   <!-- 댓글 수정폼 끝 -->
   <!-- 댓글입력폼 -->   
   <script>
      function check(pp) // form => pp
      {
    	  if(pp.name.value=="") // length로 하기도 한다.
    	  {
    		 alert("이름을 적어주세요");
    		 pp.name.focus();
    		 return false;
    	  }
    	  else if(pp.content.value=="")
    		   {
    		     alert("내용을 적어주세요");
    		     pp.content.focus();
    		     return false;
    		   }
    	       else if(pp.pwd.value=="")
    	    	    {
                       alert("비밀번호를 적어주세요");
                       pp.pwd.focus();
                       return false;
    	    	    }
    	            else
    	               return true;
    	    	   
      }
   </script>
   <table width=600>
   <tr>
     <td>
       <form method=post action=dat_ok.jsp onsubmit="return check(this)">
       <input type=hidden name=page value=<%=Page%>>
       <input type=hidden name=b_id value=<%=id%>>
         이름 <input type=text name=name size=7 maxlength=10><p>
         내용 <textarea cols=40 rows=3 name=content maxlength=100></textarea> <p>
         비번 <input type=password name=pwd maxlength=10> <p>
         <input type=submit value=댓글작성>
       </form>
     </td>
   </tr>
  </table>
   
   
   <div id=delete style="display:none">
    <form method=post action=delete_ok.jsp>
      <input type=hidden name=id value=<%=id%>>
      <input type=hidden name=page value=<%=Page%>>
         비밀번호 <input type=password name=pwd>
      <input type=submit value=삭제하기>
      <input type=button onclick=hide() value=취소>
    </form>
   </div>
   <!-- 비밀번호 입력폼을 숨겼다가 위의 삭제를 클릭하면 보이기 -->
   <script>
    function del() // 비밀번호 입력폼을 보이게 하기
    {
        document.getElementById("delete").style.display="block";
        //document.all.delete.style.display="block";
    }
    function hide() // 비밀번호 입력폼을 숨기기
    {
        document.getElementById("delete").style.display="none";
        //document.all.delete.style.display="none";
    }
   </script>
   <style>
     #delete { /* 나타나는 폼을 여기서 꾸민다 */
      border:1px solid red;
      position:absolute; /* 내가 원하는 위치 */
      left:100px;
      top:100px;
      background:white;
     }
   </style>
</body>
</html>















