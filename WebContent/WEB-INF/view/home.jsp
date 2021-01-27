<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員管理システム</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div class="text-center mt-4">
		<h1>会員管理システム</h1>
		<c:choose>
		<c:when test="${!empty sessionScope.loginId}">
		<a class="btn btn-primary btn-lg mt-4 mr-2" href="members/show">会員一覧</a>
		<a class="btn btn-primary btn-lg mt-4 ml-2" href="news/show">お知らせ一覧</a>
		</c:when>
			<c:otherwise>
				<form:form class="mt-4" action="" method="post"
					modelAttribute="admin">
					<form:errors path="loginId" cssClass="error" />
					<p class="mt-2">
						ログインID:
						<form:input path="loginId" />
					</p>
					<p>
						パスワード：
						<form:password path="loginPass" />
					</p>
					<input class="btn btn-primary" type="submit" value="ログイン">
				</form:form>
			</c:otherwise>
		</c:choose>
	</div>
</body>
</html>