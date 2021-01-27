<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%-- パスをコンテキストルートを含めた形に変換 --%>
<spring:url value="/css" var="css" />
<spring:url value="/js" var="js" />
<spring:url value="/members" var="membersUrl" />
<spring:url value="/logout" var="logout"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>会員一覧</title>
<link rel="stylesheet" href="${css}/bootstrap.min.css">
</head>
<body>
<div class="container">
<h1 class="mt-4">会員一覧</h1>
<c:if test="${!empty statusMessage}">
	<div class="alert alert-success mt-4">
		<c:out value="${statusMessage}" />
	</div>
</c:if>
<p><a class="mt-4 btn btn-primary" href="${membersUrl}/add">会員の追加</a></p>
<p><a class="mt-4 ml-4 btn btn-secondary" href="${logout}">ログアウト</a></p>
<table class="table">
	<tr>
		<th>ID</th>
		<th>氏名</th>
		<th>年齢</th>
		<th>住所</th>
		<th>会員種別</th>
		<th>登録日</th>
		<th colspan="2">操作</th>
	</tr>
	<c:forEach var="member" items="${members}"  >
		<tr>
			<td><c:out value="${member.id}" /></td>
			<td><c:out value="${member.name}" /></td>
			<td><c:out value="${member.age}" /></td>
			<td><c:out value="${member.address}" /></td>
			<td><c:out value="${member.typeName}" /></td>
			<td><fmt:formatDate value="${member.created}" pattern="yyyy年MM月dd日"/></td>
			<td><a class="btn btn-primary" href="${membersUrl}/edit/<c:out value="${member.id}" />">編集</a></td>
			<td><a class="btn btn-danger delete" data-toggle="modal" data-target="#confirm-modal" data-name="<c:out value="${member.name}" />"href="${membersUrl}/delete/<c:out value="${member.id}" />">削除</a></td>
		</tr>
	</c:forEach>
</table>
<%-- 2ページ以上の場合、ページネーションを表示 --%>
	<c:if test="${totalPages >= 2}">
		<div class="container">
			<ul class="pagination">
				<%-- 前のページへ --%>
				<c:choose>
					<c:when test="${page == 1}">
						<li class="page-item disabled"><a class="page-link" href="#">&laquo;</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="page-item"><a class="page-link"
							href="?page=<c:out value="${page - 1}" />">&laquo;</a></li>
					</c:otherwise>
				</c:choose>

<%-- ページ番号 --%>
	<c:forEach begin="1" end="${totalPages}" varStatus="vs">
		<%-- li開始タグ --%>
		<c:choose>
			<c:when test="${page == vs.count}">
				<li class="page-item active">
			</c:when>
			<c:otherwise>
				<li class="page-item">
			</c:otherwise>
		</c:choose>

		<%-- aタグ --%>
		<a class="page-link" href="?page=<c:out value="${vs.count}" />"> <c:out
				value="${vs.count}" />
		</a>
		<%-- li終了タグ --%>
		</li>
	</c:forEach>

<%-- 次のページへ --%>
	<c:choose>
		<c:when test="${page == totalPages}">
			<li class="page-item disabled"><a class="page-link" href="#">&raquo;</a>
			</li>
		</c:when>
		<c:otherwise>
			<li class="page-item"><a class="page-link"
				href="?page=<c:out value="${page + 1}" />">&raquo;</a>
				</li>
		</c:otherwise>
	</c:choose>
			</ul>
		</div>
	</c:if>
	<p><a href="../home">＜＜　戻る</a></p>
</div>

	<!-- Bootstrap4 Modal -->
	<div class="modal fade" id="confirm-modal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="confirm-modal">会員情報の削除</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					「<span id="delete-name"></span>」を削除します。よろしいですか？
				</div>
				<div class="modal-footer">
					<a class="btn btn-danger" id="delete-yes">はい</a>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">いいえ</button>
				</div>
			</div>
		</div>
	</div>
	<script src="${js}/jquery-3.5.1.min.js"></script>
	<script src="${js}/bootstrap.bundle.min.js"></script>
	<script>
		$(".delete").click(function() {
			$("#delete-name").text($(this).attr("data-name"));
			$("#delete-yes").attr("href", $(this).attr("href"));
		});
	</script>
</body>
</html>