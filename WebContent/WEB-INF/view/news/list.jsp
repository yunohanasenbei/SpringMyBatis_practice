<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
<title>お知らせ一覧</title>
<link rel="stylesheet" href="${css}/bootstrap.min.css">
</head>
<body>
	<div class="container">
		<h1 class="mt-4">お知らせ一覧</h1>
		<c:if test="${!empty statusMessage}">
			<div class="alert alert-success mt-4">
				<c:out value="${statusMessage}" />
			</div>
		</c:if>

		<p>
			<a class="mt-4 btn btn-primary" href="${newsUrl}/add">お知らせの追加</a> <a
				class="mt-4 btn btn-secondary" href="${logout}">ログアウト</a>
		</p>
		<table class="table">
			<tr>
				<th>ID</th>
				<th>投稿者</th>
				<th>タイトル</th>
				<th>掲載日</th>
				<th>操作</th>
			</tr>

			<c:forEach var="news" items="${newsList}">
				<tr>
					<td><c:out value="${news.id}" /></td>
					<td><c:out value="${news.author}" /></td>
					<td><c:out value="${news.title}" /></td>
					<td><fmt:formatDate value="${news.postDate}"
							pattern="yyyy年MM月dd日" /></td>
					<td><a class="btn btn-primary"
						href="${newsUrl}/show/<c:out value="${news.id}" />">詳細を見る </a></td>
				</tr>
			</c:forEach>

		</table>
	<p><a href="../home">＜＜　戻る</a></p>
	</div>
</body>
</html>