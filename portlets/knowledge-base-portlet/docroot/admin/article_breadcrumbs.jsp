<%--
/**
 * Copyright (c) 2000-2011 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/admin/init.jsp" %>

<%
Article article = (Article)request.getAttribute(WebKeys.KNOWLEDGE_BASE_ARTICLE);
%>

<c:if test="<%= !article.isRoot() %>">
	<div class="kb-article-breadcrumbs">

		<%
		List<Article> selArticles = new ArrayList<Article>();

		long selParentResourcePrimKey = article.getResourcePrimKey();

		while (selParentResourcePrimKey != ArticleConstants.DEFAULT_PARENT_RESOURCE_PRIM_KEY) {
			Article selArticle = ArticleServiceUtil.getLatestArticle(selParentResourcePrimKey, article.getStatus());

			selArticles.add(selArticle);

			selParentResourcePrimKey = selArticle.getParentResourcePrimKey();
		}

		for (int i = selArticles.size(); i > 0; i--) {
			Article selArticle = selArticles.get(i - 1);
		%>

			<portlet:renderURL var="viewArticleURL">
				<portlet:param name="jspPage" value='<%= jspPath + "view_article.jsp" %>' />
				<portlet:param name="resourcePrimKey" value="<%= String.valueOf(selArticle.getResourcePrimKey()) %>" />
			</portlet:renderURL>

			<c:choose>
				<c:when test="<%= article.equals(selArticle) %>">
					<%= selArticle.getTitle() %>
				</c:when>
				<c:otherwise>
					<aui:a href="<%= viewArticleURL %>"><%= StringUtil.shorten(selArticle.getTitle(), 30) %></aui:a> &raquo;
				</c:otherwise>
			</c:choose>

		<%
		}
		%>

	</div>
</c:if>