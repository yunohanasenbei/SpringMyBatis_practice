<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- パスをコンテキストルートを含めた形に変換 --%>
<spring:url value="/css" var="css" />
<spring:url value="/js" var="js" />
<spring:url value="/members" var="membersUrl" />
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
<form:form action="" method="post" modelAttribute="member">
	<form:errors path="name" cssClass="error"/>
	<p class="mt-2">氏名：<form:input path="name" /></p>

	<form:errors path="age" cssClass="error"/>
	<p class="mt-2">年齢：<form:input path="age"/></p>

	<form:errors path="address" cssClass="error"/>
	<p class="mt-2">住所：<form:input path="address"/></p>

	<p class="mt-2">会員種別：
	<form:select path="typeId" items="${types}" itemLabel="name" itemValue="id" />
	</p>

	<input class="btn btn-primary" type="submit">
</form:form>
<p class="mt-4"><a href="${membersUrl}/show">一覧に戻る</a></p>
</div>
</body>
</html>