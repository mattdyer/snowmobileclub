<cfquery name="getTxID" datasource="#APPLICATION.datasource#">
SELECT  txn_id AS lastTxID
FROM tblPayments 
WHERE ID = (Select MAX(ID) FROM tblPayments)
</cfquery>
<!--- Some varibles are not sent with every post. Set default values. --->
<cfparam name="FORM.PAYMENT_STATUS" default="Nope" >
<cfparam name="FORM.QUANTITY" default="1" >
<cfparam name="FORM.CONTACT_PHONE" default="" >
<cfparam name="FORM.MEMO" default="" >
<cfparam name="FORM.PAYER_ID" default="" >
<cfparam name="FORM.ITEM_NUMBER" default="" >
<cfparam name="clubAffil" default="1917" >
<cfparam name="FORM.OPTION_SELECTION1" default="1" >

<!--- PayPal will send you information to the link you place above (The file you will now create) as POST form submission. That data will be available for you to do as you wish.... this tutorial will demonstrate how you use that data to finalize an order and allow the customer to download the software they've purchased.

Create a string with values you will pass back to PayPal for verification. --->
<!-- read post from PayPal system and add 'cmd' -->
<cfset str="cmd=_notify-validate">
<cfloop INDEX="TheField" list="#FORM.FieldNames#">
  <cfset str = str & "&#LCase(TheField)#=#URLEncodedFormat(Form[TheField])#">
</cfloop>
<cfif IsDefined("FORM.payment_date")>
  <cfset str = str & "&payment_date=#URLEncodedFormat(Form.payment_date)#">
</cfif>
<cfif IsDefined("FORM.subscr_date")>
  <cfset str = str & "&subscr_date=#URLEncodedFormat(Form.subscr_date)#">
</cfif>
<cfif IsDefined("FORM.auction_closing_date")>
  <cfset str = str & "&subscr_date=#URLEncodedFormat(Form.auction_closing_date)#">
</cfif>
<!-- post back to PayPal system to validate -->
<cfhttp URL="https://www.paypal.com/cgi-bin/webscr?#str#" METHOD="GET" RESOLVEURL="false">
</cfhttp>
<!-- check notification validation -->
<cfif #CFHTTP.FileContent# is "VERIFIED">
  <!-- check that payment_status=Completed -->
  <cfif #FORM.PAYMENT_STATUS# eq "Completed">
    <!-- check that receiver_email is your email address -->
    <!--- Troubleshooting code sends all FORM elements to the developer. Remarked out for production --->
     <cfmail from="#APPLICATION.webmaster#" to="#APPLICATION.testEmail#" subject="Form Variables Troubleshooting" type="html">#CFHTTP.FileContent#
      <cfloop list="FORM" index="i">
          <h5> <cfoutput>#i#</cfoutput> VARIABLES </h5>
          <cftry>
            <cfswitch expression="#i#">
              <cfcase value="session">
              <!--- lock the session scoped variables --->
              <cflock timeout="10" type="READONLY" scope="SESSION">
                <cfdump var="#evaluate(i)#">
              </cflock>
              </cfcase>
              <cfcase value="application">
              <!--- also should lock the application scoped variables --->
              <cflock timeout="10" type="READONLY" scope="APPLICATION">
                <cfdump var="#evaluate(i)#">
              </cflock>
              </cfcase>
              <cfdefaultcase>
              <cfdump var="#evaluate(i)#">
              </cfdefaultcase>
            </cfswitch>
            <cfcatch>
              <p>An error occurred while trying to display <strong><cfoutput>#i#</cfoutput></strong> variables.</p>
            </cfcatch>
          </cftry>
        </cfloop>
      </cfmail>
    <cfif #FORM.RECEIVER_EMAIL# eq "#APPLICATION.sellerEmail#">
      <!-- check that txn_id has not been previously processed -->
      <cfif #getTxID.lastTxID# NEQ #FORM.TXN_ID# AND #FORM.TXN_TYPE# NEQ "subscr_signup" >
        <!-- process payment -->
        <cfquery name="insertPayment" datasource="#APPLICATION.datasource#">
                INSERT INTO tblPayments(
                                        payer_email,
                                        item_number,
                                        item_name,
                                        quantity,
                                        payment_status,
                                        payment_date,
                                        payment_gross,
                                        payment_fee,
                                        txn_id,
                                        txn_type,
                                        payment_type,
                                        payer_id
                                        )
                              VALUES(
                                        '#FORM.PAYER_EMAIL#',
                                        '#FORM.ITEM_NUMBER#',
                                        '#FORM.ITEM_NAME#',
                                        '#FORM.QUANTITY#',
                                        '#FORM.PAYMENT_STATUS#',
                                        #CreateODBCDateTime(Now())#,
                                        '#FORM.MC_GROSS#',
                                        '#FORM.MC_FEE#',
                                        '#FORM.TXN_ID#',
                                        '#FORM.TXN_TYPE#',
                                        '#FORM.PAYMENT_TYPE#',
                                        '#FORM.PAYER_ID#'
                                        )
               </cfquery>
        <!--- Add/Update Member record --->
        <!--- See if this payer is already a member --->
<cfquery name="getPayer" datasource="#APPLICATION.datasource#">
SELECT ID, payerID
FROM tblMembers
WHERE payerID = <cfqueryparam value="#FORM.payer_ID#" cfsqltype="cf_sql_char">
</cfquery>
        <!--- If they are not already in the member table, then ADD --->
        <cfif getPayer.RecordCount EQ 0>
          <cfquery name="insertCustomer" datasource="#APPLICATION.datasource#">
                    INSERT INTO tblMembers(
                                                        FirstName,
                                                        LastName,
                                                        Email,
                                        				Phone,
                                                        Address,
                                                        City,
                                                        State,
                                                        Zip,
                                        				payerID,
                                                        Cntry,
                                                        NumSnowmobilers
                                                        )
                                             VALUES(
                                                        '#FORM.first_name#',
                                                        '#FORM.last_name#',
                                                        '#FORM.payer_email#',
                                        				'#FORM.CONTACT_PHONE#',
                                                        '#FORM.address_street#',
                                                        '#FORM.address_city#',
                                                        '#FORM.address_state#',
                                                        '#FORM.address_zip#',
                                        				'#FORM.PAYER_ID#',
                                                        '#FORM.ADDRESS_COUNTRY_CODE#',
                                                        #FORM.OPTION_SELECTION1#
                                                        )
        </cfquery>
          <cfelse>
          <!--- If already in the member table, UPDATE their record --->
          <cfquery datasource="#APPLICATION.datasource#">
	UPDATE tblMembers
	SET FirstName = '#FORM.first_name#',
		LastName = '#FORM.last_name#',
		NumSnowmobilers = #FORM.OPTION_SELECTION1#,
		Address = '#FORM.address_street#',
		City = '#FORM.address_city#',
		State = '#FORM.address_state#',
		Zip = '#FORM.address_zip#',
		Cntry = '#FORM.ADDRESS_COUNTRY_CODE#',
		Phone = '#FORM.CONTACT_PHONE#',
		Email = '#FORM.payer_email#'
	WHERE tblMembers.payerID = '#FORM.payer_ID#'
	</cfquery>
        </cfif>
        <!-- Now send the customer an email, thanking them for their order and with further information about their purchase: -->
        <!--- Send user an email to the customer--->
        <!--- <p>Please follow this link back to our website and provide us with a little more information about you <a href="<cfoutput>#APPLICATION.homeURL#</cfoutput>/tblMemU.cfm?payerID=#FORM.PAYER_ID#">http://www.M-S-A.org</a></p> --->
        <cfmail from="#APPLICATION.salesEmail#" to="#FORM.payer_email#" subject="Your MSA Membership" type="html">
          Dear #Trim(FORM.first_name)# #trim(FORM.last_name)#,<br/>
          Thank you for your support of #APPLICATION.companyName#.<br/>
          This email is to acknowledge your payment of <cfoutput>#LSCurrencyFormat(FORM.MC_GROSS)#</cfoutput> for your family/group of #FORM.OPTION_SELECTION1# snowmobiler(s).
          <p>
          <cfif #Trim(FORM.CONTACT_PHONE)# EQ "">
            We noticed that you did not provide a telephone number during the PayPal checkout. We certainly understand why you would be reluctant.<br/>
            If you would like for #APPLICATION.companyName# to have it, you can simply reply to this email and include it.
            </p>
          </cfif>
          <p>Thanks again, and happy sledding.</p>
          <cfif #FORM.MEMO# NEQ "">
            Your instructions to us: #FORM.MEMO#
          </cfif>
          <p>If you have any questions or comments, please contact us at #APPLICATION.custSvcEmail# or just reply to this email.
          <p>Visit us at <a href="<cfoutput>#APPLICATION.homeURL#</cfoutput>">#APPLICATION.homeURL#.</a></p>
        </cfmail>
        <!--- Now send yourself an email alerting that there was a sale done --->
        <cfmail from="#APPLICATION.salesEmail#" to="greg@ssb-ca.com" subject="Someone Joined MSA From The Website!" type="html">
          <strong>#Trim(FORM.first_name)# #Trim(FORM.last_name)#</strong> purchased one #FORM.ITEM_NAME# enrollment/renewal for <cfoutput>#LSCurrencyFormat(FORM.MC_GROSS)#</cfoutput>
          for his/her group of <strong>#FORM.OPTION_SELECTION1#</strong> snowmobilers.
          <p> <a href="mailto:#FORM.address_street#">#FORM.payer_email#</a></p>
          #Trim(FORM.address_street)#<br/>
#Trim(FORM.address_city)#, #Trim(FORM.address_state)# #FORM.address_zip#           <br/>
#FORM.ADDRESS_COUNTRY_CODE#           <br/>
#FORM.CONTACT_PHONE#
          <cfif #FORM.MEMO# NEQ "">
            <p>Your instructions to us: #FORM.MEMO#</p>
          </cfif>
        </cfmail>
      </cfif>
    </cfif>
  </cfif>
  <cfelseif #CFHTTP.FileContent# is "INVALID">
  <!--  Something that was purchased was invalid, either the order or the information provided. This is usually good to log in case someone is trying to purchase with stolen card numbers, etc. Here simply place a QUERY tag that insert the data above into a database. Email for investigation -->
  <cfmail from="#APPLICATION.webmaster#" to="#APPLICATION.testEmail#" subject="Invalid attempt" type="html">
    #CFHTTP.FileContent# order was attempted on th eMSA website by #Trim(FORM.first_name)# #trim(FORM.last_name)#
    <cfloop list="FORM" index="i">
      <h5> <cfoutput>#i#</cfoutput> VARIABLES </h5>
      <cftry>
        <cfswitch expression="#i#">
          <cfcase value="session">
          <!--- lock the session scoped variables --->
          <cflock timeout="10" type="READONLY" scope="SESSION">
            <cfdump var="#evaluate(i)#">
          </cflock>
          </cfcase>
          <cfcase value="application">
          <!--- also should lock the application scoped variables --->
          <cflock timeout="10" type="READONLY" scope="APPLICATION">
            <cfdump var="#evaluate(i)#">
          </cflock>
          </cfcase>
          <cfdefaultcase>
          <cfdump var="#evaluate(i)#">
          </cfdefaultcase>
        </cfswitch>
        <cfcatch>
          <p>An error occurred while trying to display <strong><cfoutput>#i#</cfoutput></strong> variables.</p>
        </cfcatch>
      </cftry>
    </cfloop>
  </cfmail>
  <cfelse>
  <!-- This usually means that something went wrong along the way, you can use this area to log it and keep for your records. -->
  <cfmail from="#APPLICATION.webmaster#" to="#APPLICATION.testEmail#" subject="Something went wrong" type="html">
    An order was placed by: #CFHTTP.FileContent# - SOMETHING WENT WRONG with an #APPLICATION.companyName# PayPal attempt<br />
    <cfloop list="FORM" index="i">
      <h5> <cfoutput>#i#</cfoutput> VARIABLES </h5>
      <cftry>
        <cfswitch expression="#i#">
          <cfcase value="session">
          <!--- lock the session scoped variables --->
          <cflock timeout="10" type="READONLY" scope="SESSION">
            <cfdump var="#evaluate(i)#">
          </cflock>
          </cfcase>
          <cfcase value="application">
          <!--- also should lock the application scoped variables --->
          <cflock timeout="10" type="READONLY" scope="APPLICATION">
            <cfdump var="#evaluate(i)#">
          </cflock>
          </cfcase>
          <cfdefaultcase>
          <cfdump var="#evaluate(i)#">
          </cfdefaultcase>
        </cfswitch>
        <cfcatch>
          <p>An error occurred while trying to display <strong><cfoutput>#i#</cfoutput></strong> variables.</p>
        </cfcatch>
      </cftry>
    </cfloop>
  </cfmail>
</cfif>
</body></html>