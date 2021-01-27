<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- パスをコンテキストルートを含めた形に変換 --%>
<spring:url value="/css" var="css" />
<spring:url value="/images" var="images" />
<spring:url value="/js" var="js" />
<spring:url value="/members" var="membersUrl" />
<spring:url value="/news" var="newsUrl" />
<spring:url value="/logout" var="logout" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お知らせ詳細</title>
<link rel="stylesheet" href="${css}/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h1 class="mt-4">お知らせ詳細</h1>
		<p>
			<a class="mt-4 btn btn-primary" href="${newsUrl}/show">一覧に戻る</a>
		</p>
		<table class="table">
			<tr>
				<th>ID</th>
				<td><c:out value="${news.id}" /></td>
			</tr>
			<tr>
				<th>投稿者</th>
				<td><c:out value="${news.author}" /></td>
			</tr>
			<c:if test="${!empty news.targetList}">
			<tr>
				<th>対象</th>
				<td>
				<c:forEach var="target" items="${news.targetList}">
					<p><c:out value="${target.name}" /></p>
				</c:forEach>
				</td>
			</tr>
			</c:if>
			<tr>
				<th>タイトル</th>
				<td><c:out value="${news.title}" /></td>
			</tr>
			<tr>
				<th>掲載日</th>
				<td><fmt:formatDate value="${news.postDate}" pattern="yyyy年MM月dd日"/></td>
			</tr>
			<tr>
				<th>内容</th>
				<td><c:out value="${news.detail.article}" /></td>
			</tr>
			<c:if test="${!empty news.detail.photo}">
			<tr>
				<th>イメージ画像</th>
				<td><img src="${images}/<c:out value="${news.detail.photo}" />"  alt=""></td>
			</tr>
			</c:if>
		</table>

	</div>
</body>
</html>