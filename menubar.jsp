<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.kh.member.model.vo.Member" %>
<%
	// Member 타입 변수에 session의 loginUser 담기
	Member loginUser = (Member)session.getAttribute("loginUser");
	// > 로그인 전 menubar.jsp 로딩시 : loginUser => null
	// > 로그인 성공 후 menubar.jsp 로딩시 : loginUser => 로그인한 회원의 정보들이 담겨있는 객체
	// > 이 페이지를 include하는 곳은 이 loginUser라는 멤버객체를 마음껏 쓸 수있다!
	String contextPath = request.getContextPath(); 

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #loginForm, #userInfo{float:right;}
    #userInfo a{color:black; text-decoration:none; font-size:12px;}

    .navWrap{background-color:black;}
    .menu{
        display:table-cell;
        height:50px;
        width:150px;
        }
    .menu a{
        text-decoration:none;
        color:white;
        font-size:20px;
        line-height:50px;
        font-weight:bold;
        display:block;
        width:100%;
        height:100%;
    }
    .menu a:hover{background:darkgray}
</style>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

	<script>
		var msg = "<%= session.getAttribute("alertMsg") %>"; // 알람창으로 출력할 메세지
		// var msg = "메세지"   / "null";
		
		if(msg != "null"){
			alert(msg);
			// session에 한 번 담아둔 건 내가 지우기 전 까지 계속 남아있다 (메뉴바 포함된 매 페이지가 열릴때마다 alert 계속 뜰 것)
			// 알람창 띄워준 후에 session에 담긴 메세지 지워야함!!
			<% session.removeAttribute("alertMsg");%>
		}
		
	</script>

	<h1 align="center">Welcome JSP World</h1>

    <div class="loginArea">

		<!-- loginUser 값의 null 유무에 따라 로그인전, 로그인 후 화면 정하기 -->
		<% if(loginUser == null){ %>
        <!-- 1. 로그인 전에 보여지는 로그인 form -->
        <!-- 이제부터는 "/jsp" 대신 request.getContextPath() 로  작성-->
        <!-- method="post" : 입력한 값 url에 노출x -->        
        <form action="<%= contextPath %>/login.me" id="loginForm" method="post">
            <table>

                <tr>
                    <th><label for="userId">아이디 : </label></th>
                    <td><input type="text" name="userId" id="userId" required></td>
                </tr>
                <tr>
                    <th><label for="userPwd">비밀번호 : </label></th>
                    <td><input type="password" name="userPwd" id="userPwd" required></td>
                </tr>
                <tr>
                    <th colspan="2">
                        <button type="submit">로그인</button>
                        <button type="button" onclick="enrollPage();">회원가입</button>
                    </th>
                    <script>
                    	function enrollPage(){
                    		//loacation.href="/jsp/views/member/memberEnrollForm.jsp";
                    		// 웹 애플리케이션의 디렉토리 구조가 url에 노출되면 보안에 위험
                    		
                    		// 단순한 정적인 페이지 이동이라고 해도 반드시 servlet요청후 forwarding 방식으로 응답
                    		// => url에 servlet매핑값만 노출된다!
                    		location.href = "<%= request.getContextPath() %>/enrollForm.me";
                    	}
                    </script>
                </tr>
            </table>   

        </form>
        
		<% }else { %>
        <!-- 2. 로그인 성공 후 div -->
        
        <div id="userInfo">
            <b><%= loginUser.getUserName() %>님 </b>의 방문을 환영합니다. <br><br>

            <div align="center">
                <a href="<%= contextPath %>/myPage.me">마이페이지</a>
                <a href="<%= contextPath %>/logout.me">로그아웃</a>
            </div>
        </div>
        <% } %>

    </div>

    <br clear="both"> <br>


    <div class="navWrap" align="center">
        <!-- (.menu>a)*4 -->
        <div class="menu"><a href="<%=contextPath%>">HOME</a></div>
        <div class="menu"><a href="<%=contextPath%>/list.no">공지사항</a></div>
        <div class="menu"><a href="">일반게시판</a></div>
        <div class="menu"><a href="">사진게시판</a></div>

    </div>

</body>
</html>