<HTML>
<HEAD>
	<TITLE>mySQL Test JSP page</TITLE>
	<%@ page import="java.util.*" %>
	<%@ page import="java.io.*" %>
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%@ page import="javax.naming.*" %>
</HEAD>
<BODY>

<H1>mySQL JSP Test page</H1>
<img src="images/jbosscorp_logo.png">

<H2>Pet Table Data</H2>
<TABLE>
<TR valign=top>
	<TH align=left>Name</TH>
	<TH align=left>Owner</TH>
	<TH align=left>Species</TH>
	<TH align=left>sex</TH>
</TR>
<%
InitialContext ctx;
DataSource ds;
Connection conn;
Statement stmt;
ResultSet rs;

try {
	ctx = new InitialContext();
	ds = (DataSource) ctx.lookup("java:/jboss/datasources/mydb");
	conn = ds.getConnection();
	stmt = conn.createStatement();
	rs = stmt.executeQuery("select * from pet");

	while(rs.next()) {
		String name = (String) rs.getString("name");
		String owner = (String) rs.getString("owner");
		String species = (String) rs.getString("species");
		String sex = (String) rs.getString("sex");
%>
<TR valign=top>
	<TD><%= name.replaceAll("<", "&lt;").replaceAll(">","&gt;") %></TD>
	<TD><%= owner.replaceAll("<", "&lt;").replaceAll(">","&gt;") %></TD>
	<TD><%= species.replaceAll("<", "&lt;").replaceAll(">","&gt;") %></TD>
	<TD><%= sex.replaceAll("<", "&lt;").replaceAll(">","&gt;") %></TD>
</TR>
<%
	}
} catch (SQLExceptin sqle) {
%>
	<%= sqle.getMessage() %>
<%
} catch (NamingException ne) {
%>
	<%= ne.getMessage() %>
<%
}
%>

</TABLE>

</BODY>
</HTML>
