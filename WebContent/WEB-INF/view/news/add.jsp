<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<%-- パスをコンテキストルートを含めた形に変換 --%>
<spring:url value="/css" var="css" />
<spring:url value="/js" var="js" />
<spring:url value="/members" var="membersUrl" />
<spring:url value="/news" var="newsUrl" />
<spring:url value="/logout" var="logout" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><c:out value="${title}" /></title>
<link rel="stylesheet" href="${css}/bootstrap.min.css">
<link rel="stylesheet" href="${css}/style.css">
</head>
<body>
	<div class="container">
		<h1 class="my-4"><c:out value="${title}" /></h1>
		<form:form action="" method="post" modelAttribute="newsForm"
					enctype="multipart/form-data">
			<form:errors path="title" cssClass="error"/>
				<p class="mt-2">タイトル: <form:input path="title"/></p>

			<form:errors path="postDate" cssClass="error"/>
				<p class="mt-2">掲載日: <form:input path="postDate" type="date"/></p>

			<p class="news_target">対象を限定する場合は☑:
			<form:checkboxes path="targetIdList" items="${memberTypeList}"
								itemValue="id" itemLabel="name"/>
			</p>

			<form:errors path="article" cssClass="error"/>
				<p class="mt-2">内容: <br>
				<form:textarea path="article" cols="40" rows="5"/></p>
			<form:errors path="upfile" cssClass="error"/>
			<p>イメージ画像:<form:input type="file" path="upfile"/></p>
			<input class="btn btn-primary" type="submit">
		</form:form>
	<p class="mt-4"><a href="${newsUrl}/show">一覧に戻る</a></p>
	</div>
</body>
</html>