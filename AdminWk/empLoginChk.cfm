

<!--- Make sure we have Username and Password --->
<CFPARAM NAME="Form.userName" TYPE="string" default="">
<CFPARAM NAME="Form.Userpword" TYPE="string" default="">
<cfparam name="Form.UserLogin" default="">
<!--- Find record with this Username/Password --->
<!--- If no rows returned, password not valid --->
<CFQUERY NAME="GetUser" DATASOURCE="fsa1">
SELECT  *
FROM Users
WHERE Username = '#Form.userName#' AND Pword = '#Form.Userpword#'</CFQUERY>

<!--- If the email and password are correct --->
<CFIF GetUser.RecordCount EQ 1>
  <!--- Remember user's logged-in status, plus --->
  <!--- EmployeeID, First Name, Last Name and Role in structure --->
  <CFSET SESSION.Auth = StructNew()>
  <CFSET SESSION.Auth.IsLoggedIn = "Yes">
  <CFSET SESSION.Auth.Role = GetUser.role>
  <CFSET SESSION.Auth.EmployeeID  = GetUser.ID>
  <CFSET SESSION.Auth.FirstName  = GetUser.FirstName>
  <CFSET SESSION.Auth.LastName  = GetUser.LastName>

  <!--- Now that user is logged in, send them --->
  <!--- to whatever page makes sense to start --->
  <CFLOCATION URL="#CGI.SCRIPT_NAME#?#CGI.QUERY_STRING#">
<cfelse>
</CFIF>