<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>      
<%
  // DB연결
   String aa="jdbc:mysql://localhost:3307/java?useSSL=false";
   String bb="root";
   String cc="1234";
   Connection conn = DriverManager.getConnection(aa,bb,cc); 
   Statement stmt=conn.createStatement();
   
   // 전체 레코드의 갯수를 가져오기
 
   // 페이지가 시작되는 인덱스값이 결정되어야 된다..
   // 1page => 0, 2page=>10 ........
   int start;
   int Page;  // 현재 페이지값이 들어갈 변수
   if(request.getParameter("page")==null)
   {
     start=0; // 1page => 가장 처음 접근할때 : page값을 넘기지 않았을때
     Page=1;
   }
   else
   {
    // 사용자가 원하는 page값이 request된다.
    Page=Integer.parseInt(request.getParameter("page")); // 인덱스값을 변형
    start=(Page-1)*10; // 사용자가 원하는 페이지에 해당하는 인덱스값으로
   }
   
    String sql="select * from qna order by id desc limit "+start+",10";

    ResultSet rs=stmt.executeQuery(sql);
  
  // 많은 레코드를 한꺼번에 출력 => 가독성X
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
 <style>
   a {
     text-decoration:none;
     color:black;
   } 
   a:hover {
     text-decoration:underline;
     color:green;
   }
 </style>
</head>
<body>
  <table align=center width=600 border=1 cellspacing=0>
   <caption> <h2> 게시판  <%=Page%></h2></caption>
   <tr height=30 align=center>
     <td> 이름 </td>
     <td> 제목 </td>
     <td> 조회수 </td>
     <td> 작성일 </td>
     <td> ref </td>
     <td> depth </td>
     <td> seq </td>
   </tr>
   <%
    while(rs.next())
    {
   %>
   <tr height=20>
     <td align=center> <%=rs.getString("user")%> </td>
     <td> <a href="qna_content.jsp?id=<%=rs.getString("id")%>&page=<%=Page%>"> <%=rs.getString("title")%> </a> </td>
     <td align=center> <%=rs.getString("readnum")%> </td>
     <td align=center> <%=rs.getString("writeday")%> </td>
     <td align=center> <%=rs.getString("ref")%> </td>
     <td align=center> <%=rs.getString("depth")%> </td>
     <td align=center> <%=rs.getString("seq")%> </td>
   </tr>
  <%
    }
  %>
   <tr>
     <td colspan=7 align=right> <a href="qna.jsp"> 글쓰기 </a> </td>
   </tr>
   <tr>
     <td colspan=7 align=center style="word-spacing:10px">
  <%
       // page변수가 존재한다..
       
     int pstart;
     int pend;
      
     // 1page~10page사이에 존재한다면  pstart=1 , pend=10
     // 11page ~20page사이에 존재한다면 pstart=11 , pend=20  
     // 21page ~30page사이에 존재한다면 pstart=21 , pend=30  
     
     // 1~9를 10으로 나누면 =>   0 + "1" => "01" 정수=> 1        pstart=1
     // 11~19를 10으로 나누면 => 1 + "1" => "11" 정수=> 11       pstart=11
     // 21~29를 10으로 나무녀 => 2 + "1" => "21" 정수=> 21       pstart=21
    
     
     
     // 전체 레코드 갯수 알아오기
     sql="select count(id) as cnt from qna";
     rs=stmt.executeQuery(sql); // rs객체가 새로 만들어진다.
     rs.next();
     int total_record=rs.getInt("cnt"); // 전체레코드수
     // 레코드수를 가지고 페이지 계산하기
     int page_cnt=total_record/10; 
     if(total_record%10 != 0)
    	 page_cnt=page_cnt+1;  // 전체페이지수
     /*
     page_cnt=page_cnt+1;
     if(total_record%10 == 0)
    	 page_cnt=page_cnt-1;
     */     
     
  // 아래에 페이지 링크에 필요한 시작값 생성
     pstart=(int)Page/10;
     // 10,20,30... 은 원하는 값보다 1이 높다 => -1한다..
     if(Page%10 == 0) 
    	 pstart=pstart-1;
     pstart=Integer.parseInt(pstart+"1");
     pend=pstart+9; // 마지막 구역에서는 pstart부터 마지막페이지까지만 출력
     
     if(pend > page_cnt) // 출력될페이지값이 전체페이지값보다 크다면
        pend=page_cnt;  // 출력페이지의 끝값을 전체페이지값으로 변경
  %>
  <!-- 첫페이지는 => 1page -->
  <a href="qna_list.jsp?page=1"> 처음 </a>
  
  <!-- 페이지 출력되는 첫구역에서는 링크를 해제 -->
  <!-- 첫구역일때를 알수 있는 값 => pstart=1  -->
  <%
   if(pstart == 1)
   {
  %>
  ◀◀
  <%
   }
   else
   {
  %>
    <a href="qna_list.jsp?page=<%=pstart-1%>"> ◀◀ </a>
  <%
   }
  %>
  <!-- 현재페이지에서  -1된 페이지  이동 -->
  <!-- 현재페이지가 1페이지라면 비활성화 -->
  <%
    if(Page != 1) // 1페이지가 아니라면
    {
  %>
    <a href="qna_list.jsp?page=<%=(Page-1)%>"> ◀ </a>
  <% 
    }
    else
    {
  %>
   ◀
  <%  	
    }
  
  // 1번문제 : 현재페이지의 숫자를 빨간색으로
     String color="";
     for(int i=pstart;i<=pend;i++)
     {
    	 if(Page == i) // 현재페이지랑 출력되는 i값이 같을때
    		 color="style='color:red'";
    	 else
    		 color="";
  %>
       <a href=qna_list.jsp?page=<%=i%>" <%=color%>> <%=i%> </a>
  <%
     }
     
 
  %> <!-- 현재페이지에서  +1된 페이지  이동 -->
     <!-- 현재페이지가 마지막 페이지라면 비활성화 -->
  <%
     if(Page != page_cnt)
     {
  %>
     <a href="qna_list.jsp?page=<%=Page+1%>"> ▶ </a>
  <%
     }
     else // 마지막 페이지
     {
  %>    
     ▶
  <%
     }
  %>
    <!-- 페이지출력 마지막 구역일때는 링크가 해제 -->
    <!-- pend값하고 page_cnt값이 같으면 마지막 구역 -->
    <%
      if(pend == page_cnt)
      {
    %>
    ▶▶
    <%
      }
      else
      {
    %>
    <a href="qna_list.jsp?page=<%=pend+1%>"> ▶▶ </a>
    <%
      }
    %>
     <!-- 끝 페이지 => page_cnt -->
     <a href="qna_list.jsp?page=<%=page_cnt%>"> 끝 </a>
     
     <!-- 2번문제 : select태그를 이용하여 page이동 -->
     <!-- 전체페이지만큼 option태그를 추가 -->
     <select id=pp onchange=move_list(this.value)>
     <%
      for(int i=1;i<=page_cnt;i++)
      {
     %>
      <option value=<%=i%>> <%=i%>page </option>
     <%
      }
     %> 
     </select>
     </td>
   </tr>
  </table>
  <script>
    function move_list(val) // val=this.value; (this==select)
    {
    	location="qna_list.jsp?page="+val;
    }
    function select_init()
    {  // select태그의 option태그를 현재 페이지에 맞게 나타내기
       //document.getElementById("pp").selectedIndex=<%=Page-1%>;
       document.getElementById("pp").value=<%=Page%>;
    }
    select_init();
    </script>
</body>
</html>
<%
  rs.close();
  stmt.close();
  conn.close();
%>
