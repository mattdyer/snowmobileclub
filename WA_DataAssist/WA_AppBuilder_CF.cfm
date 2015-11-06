<cfscript>
/*-----------------------------------------------------------------------------
-	This file contains proprietary and confidential information from WebAssist.com
-	corporation.  Any unauthorized reuse, reproduction, or modification without
-	the prior written consent of WebAssist.com is strictly prohibited.
-
-	Copyright 2005-2007 WebAssist.com Corporation.  All rights reserved.
------------------------------------------------------------------------------*/

function WA_AB_getLoopedFieldName(tName, loopInde) {
  if (Len(tName) EQ 0) {
    return tName;
  }
  if (Len(tName) EQ 1 OR Right(tName, 1) NEQ "_") {
    tName = tName & "_";
  }
  return tName & loopInde;
}

function WA_AB_getLoopedFieldValue(loopedFieldName, counterVal) {
  loopedFieldName = WA_AB_getLoopedFieldName(loopedFieldName, counterVal);
  if (loopedFieldName NEQ "" AND (IsDefined("Form." & loopedFieldName) OR IsDefined("URL." & loopedFieldName))) {
    return IIf(IsDefined("Form." & loopedFieldName), "Form." & loopedFieldName, "URL." & loopedFieldName);
  }
  return "";
}

function WA_AB_checkLoopedFieldsExist(loopedFields, counterVal) {
  for (n=1; n LTE ArrayLen(loopedFields); n=n+1) {
    loopedFieldName = WA_AB_getLoopedFieldName(loopedFields[n], counterVal);
    if (loopedFieldName NEQ "" AND (IsDefined("Form." & loopedFieldName) OR IsDefined("URL." & loopedFieldName))) {
      return true;
    }
  }
  return false;
}

function WA_AB_checkLoopedFieldsNotBlank(loopedFields, counterVal) {
  if (NOT WA_AB_checkLoopedFieldsExist(loopedFields, counterVal)) {
    return false;
  }
  for (n=1; n LTE ArrayLen(loopedFields); n=n+1) {
    if (WA_AB_getLoopedFieldValue(loopedFields[n], counterVal) NEQ "") {
      return true;
    }
  }
  return false;
}

function WA_AB_returnPreSelectValue(PreSelectArray, optionValue) {
  for (n=1; n LTE ArrayLen(PreSelectArray); n=n+1) {
    if (PreSelectArray[n] EQ optionValue) {
      return optionValue;
    }
  }
  return optionValue & "DONOTSELECT";
}

function WA_AB_generateInsertParams(fieldNameList, columnTypeList, fieldValueList, ignoreIndex)  {
  obj = ArrayNew(1);
  obj[1] = "";
  obj[2] = "";
  obj[3] = "";
  for (i=1; i LTE ArrayLen(fieldNameList); i=i+1)  {
    if (i NEQ ignoreIndex)  {
      formVal = fieldValueList[i];
      WA_typesArray = ListToArray(columnTypeList[i],",");
      delim =  "";
      altVal = "" ;
      emptyVal = "";
  	  if (WA_typesArray[1] NEQ "none") delim = WA_typesArray[1];
  	  if (WA_typesArray[2] NEQ "none") altVal = WA_typesArray[2];
  	  if (WA_typesArray[3] NEQ "none") emptyVal = WA_typesArray[3];
  	  if (formVal EQ "" OR formVal EQ "undefined") {
        formVal = emptyVal;
      } 
      else {
        if (altVal NEQ "") {
          formVal = altVal;
        }
        else   {
          if (delim EQ "'")  {
            formVal = "'" & Replace(formVal,"'","''","all") & "'";
          }  
          else if (delim EQ "") {
	   	    //numeric
		    if (NOT IsNumeric(formVal)) {
			  formVal = "0";
		    }
	      }
	      else	{
            formVal = delim & WA_AB_clearOutSQLKeywords(formVal) & delim;
  		  }
        }
      }
  	  if (obj[1] NEQ "")  {
  	    obj[1] = obj[1] & ",";
        obj[2] = obj[2] & ",";
        obj[3] = obj[3] & ", ";
  	  }
      obj[1] = obj[1] & fieldNameList[i];
      obj[2] = obj[2] & formVal;
      obj[3] = obj[3] & fieldNameList[i] & " = " & formVal;
    }
  }
  return obj;
}

function WA_AB_generateWhereClause(fieldNameList, columnTypeList, fieldValueList, comparisonList)  {
  sqlWhereClause = "";
  for (i=1; i LTE ArrayLen(fieldNameList); i=i+1)  {
      formVal = fieldValueList[i];
      WA_typesArray = ListToArray(columnTypeList[i],",");
      delim =  "";
      altVal = "" ;
      emptyVal = "";
	  if (WA_typesArray[1] NEQ "none") delim = WA_typesArray[1];
	  if (WA_typesArray[2] NEQ "none") altVal = WA_typesArray[2];
	  if (WA_typesArray[3] NEQ "none") emptyVal = WA_typesArray[3];
      if (formVal EQ "" OR formVal EQ "undefined") {
        formVal = emptyVal;
      }
      else  {
        if (altVal NEQ "") {
          formVal = altVal;
        }
        else {
          if (delim EQ "'") {
            formVal = "'" & Replace(formVal,"'","''","all");
            if (comparisonList[i] EQ " LIKE ")  { formVal = formVal & "%"; }
            formVal = formVal & "'";
          }
          else if (delim EQ "") {
	   	    //numeric
		    if (NOT IsNumeric(formVal)) {
			  formVal = "0";
		    }
	      } 
	      else {
           formVal = delim & WA_AB_clearOutSQLKeywords(formVal) & delim;
		  }
        }
      }
	    if (i NEQ 1) sqlWhereClause = sqlWhereClause & " AND ";
      if (NOT(delim EQ "" AND Find("()",formVal) GT 0))  {
        if (formVal EQ "NULL")  {
          sqlWhereClause = sqlWhereClause & fieldNameList[i] & " IS " & formVal;
        }
        else  {
          sqlWhereClause = sqlWhereClause & fieldNameList[i] & comparisonList[i] & formVal;
        }
      }
  }
  return sqlWhereClause;
}

function StringToArray(theStr)  {
  obj = ArrayNew(1);
  obj[1] = theStr;
  return obj;
}

function WA_ListToArray(list,delims)  {
  obj = ArrayNew(1);
  tempList = list;
  while (Find(delims,tempList) NEQ 0)  {
    if (Find(delims,tempList) EQ 1)  {
      obj[ArrayLen(obj)+1] = "";
    }
    else  {
      obj[ArrayLen(obj)+1] = Left(tempList,Find(delims,tempList)-1);
    }
	if (len(templist) - Find(delims,tempList) EQ 0)  {
	  tempList = "";
	}
	else  {
      tempList = Right(templist,len(templist) - Find(delims,tempList));
	}
  }
  obj[ArrayLen(obj)+1] = tempList;
  return obj;
}

function WA_AB_cleanUpColumnName(colName) {
	if (Find(";", colName)) {
		colName = Left(colName, Find(";", colName));
	}
	if (Find("(", colName)) {
		colName = Left(colName, Find("(", colName));
	}
	if (Find("=", colName)) {
		colName = Left(colName, Find("=", colName));
	}
	return colName;
}

function WA_AB_cleanUpEquality(tEquality) {
	if (Trim(tEquality) NEQ "=") {
		return WA_AB_cleanUpColumnName(tEquality);
	}
	return tEquality;
}

function WA_AB_clearOutSQLKeywords(tString) {
	if (Find("select", LCase(tString))) {
		return "";
	}
	if (Find("drop", LCase(tString))) {
		return "";
	}
	if (Find("alter", LCase(tString))) {
		return "";
	}
	if (Find("create", LCase(tString))) {
		return "";
	}
	if (Find("update", LCase(tString))) {
		return "";
	}
	if (Find("insert", LCase(tString))) {
		return "";
	}
	if (Find("delete", LCase(tString))) {
		return "";
	}
	if (Find("'", LCase(tString))) {
		return "";
	}
	if (Find("##", LCase(tString))) {
		return "";
	}
	return tString;
}
</cfscript>
<cffunction name="WA_AB_doManageRelationalTable">
  <cfargument type="array" name="WA_valuesList" />
  <cfargument type="string" name="WA_appliedString" />
  <cfargument type="array" name="WA_appliedList" />
  <cfargument type="string" name="WA_connection" />
  <cfargument type="string" name="WA_table" />
  <cfargument type="string" name="WA_userName" />
  <cfargument type="string" name="WA_password" />
  <cfargument type="string" name="WA_masterKeyField" />
  <cfargument type="string" name="WA_masterKeyType" />
  <cfargument type="string" name="WA_masterKeyValue" />
  <cfargument type="string" name="WA_masterKeyComp" />
  <cfargument type="string" name="WA_joinedKeyField" />
  <cfargument type="string" name="WA_joinedKeyType" />
  <cfargument type="string" name="WA_joinedKeyComp" />
  <cfargument type="string" name="WA_fieldNamesStr" />
  <cfargument type="string" name="WA_columnTypesStr" />
  <cfset WA_fieldNames = ListToArray(WA_fieldNamesStr, "|") />
  <cfset WA_columns = ListToArray(WA_columnTypesStr, "|") />
  <cfset WA_formerString = "" />
  <cfset WA_formerList = ArrayNew(1) />
  <cfset WA_insertIDs = "" />
  <cfset WhereObj = WA_AB_generateWhereClause(ListToArray(WA_masterKeyField,"^"), ListToArray(WA_masterKeyType,"^"), ListToArray(WA_masterKeyValue,"^"), ListToArray(WA_masterKeyComp,"^")) />
  <cfset WA_Sql = "SELECT #WA_masterKeyField#, #WA_joinedKeyField# FROM #WA_table# WHERE #PreserveSingleQuotes(WhereObj)# ORDER BY #WA_joinedKeyField#" />
  <cfif WA_userName NEQ "">
    <cfif WA_password NEQ "">
      <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" username="#WA_userName#" password="#WA_password#">#WA_Sql#</cfquery>
    <cfelse>
      <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" username="#WA_userName#">#WA_Sql#</cfquery>
    </cfif>
  <cfelseif WA_password NEQ "">
    <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" password="#WA_password#">#WA_Sql#</cfquery>
  <cfelse>
    <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#">#WA_Sql#</cfquery>
  </cfif>
  <cfif (WA_mrtJoinRS.RecordCount GT 0) >
    <cfloop query="WA_mrtJoinRS">
      <cfset WA_formerString = WA_formerString & "^" & Evaluate("WA_mrtJoinRS." & WA_joinedKeyField) & "^" />
      <cfset ArrayAppend(WA_formerList, Evaluate("WA_mrtJoinRS." & WA_joinedKeyField)) />
    </cfloop>
  </cfif>
  <cfloop index="n" from="1" to="#ArrayLen(WA_formerList)#">
    <cfif (Find("^" & WA_formerList[n] & "^", WA_appliedString) EQ 0)>
      <cfset WhereObj = WA_AB_generateWhereClause(ListToArray(WA_masterKeyField&"^"&WA_joinedKeyField,"^"), ListToArray(WA_masterKeyType&"^"&WA_joinedKeyType,"^"), ListToArray(WA_masterKeyValue&"^"&WA_formerList[n],"^"), ListToArray(WA_masterKeyComp&"^"&WA_joinedKeyComp,"^")) />
      <cfset WA_Sql = "DELETE FROM #WA_table# WHERE #PreserveSingleQuotes(WhereObj)#" />
      <cfif WA_userName NEQ "">
        <cfif WA_password NEQ "">
          <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" username="#WA_userName#" password="#WA_password#">#WA_Sql#</cfquery>
        <cfelse>
          <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" username="#WA_userName#">#WA_Sql#</cfquery>
        </cfif>
      <cfelseif WA_password NEQ "">
        <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" password="#WA_password#">#WA_Sql#</cfquery>
      <cfelse>
        <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#">#WA_Sql#</cfquery>
      </cfif>
    </cfif>
  </cfloop>
  <cfloop index="n" from="1" to="#ArrayLen(WA_appliedList)#">
    <cfif (Find("^" & WA_appliedList[n] & "^", WA_formerString) EQ 0) >
      <cfset WA_insertIDs = WA_insertIDs & "^" & WA_appliedList[n] & "^" />
    </cfif>
  </cfloop>
  <cfloop index="n" from="1" to="#ArrayLen(WA_valuesList)#">
    <cfset WA_fieldValues = ListToArray(Replace(Replace(WA_valuesList[n][2], "^JOINID^", WA_valuesList[n][1], "all"), "^MASTERID^", WA_masterKeyValue, "all"), "|") />
    <cfif (Find("^" & WA_valuesList[n][1] & "^", WA_insertIDs) EQ 0) >
      <cfif (Replace(Replace(WA_valuesList[n][2], "^JOINID^", ""), "^MASTERID^", "") NEQ "|") >
        <cfset updateParamsObj = WA_AB_generateInsertParams(WA_fieldNames, WA_columns, WA_fieldValues, -1) />
        <cfset updateParamsObj3 = updateParamsObj[3]/>
        <cfset WhereObj = WA_AB_generateWhereClause(ListToArray(WA_masterKeyField&"^"&WA_joinedKeyField,"^"), ListToArray(WA_masterKeyType&"^"&WA_joinedKeyType,"^"), ListToArray(WA_masterKeyValue&"^"&WA_valuesList[n][0],"^"), ListToArray(WA_masterKeyComp&"^"&WA_joinedKeyComp,"^")) />
        <cfset WA_Sql = "UPDATE #WA_table#  SET #PreserveSingleQuotes(updateParamsObj3)# WHERE #PreserveSingleQuotes(WhereObj)#" />
        <cfif WA_userName NEQ "">
          <cfif WA_password NEQ "">
            <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" username="#WA_userName#" password="#WA_password#">#WA_Sql#</cfquery>
          <cfelse>
            <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" username="#WA_userName#">#WA_Sql#</cfquery>
          </cfif>
        <cfelseif WA_password NEQ "">
          <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" password="#WA_password#">#WA_Sql#</cfquery>
        <cfelse>
          <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#">#WA_Sql#</cfquery>
        </cfif>
      </cfif>
    <cfelse>
      <cfset insertParamsObj = WA_AB_generateInsertParams(WA_fieldNames, WA_columns, WA_fieldValues, -1) />
      <cfset insertParamsObj2 = insertParamsObj[2]/>
      <cfset WA_Sql = "INSERT INTO #WA_table# (#insertParamsObj[1]#) VALUES (#PreserveSingleQuotes(insertParamsObj2)#)" />
      <cfif WA_userName NEQ "">
        <cfif WA_password NEQ "">
          <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" username="#WA_userName#" password="#WA_password#">#WA_Sql#</cfquery>
        <cfelse>
          <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" username="#WA_userName#">#WA_Sql#</cfquery>
        </cfif>
      <cfelseif WA_password NEQ "">
        <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#" password="#WA_password#">#WA_Sql#</cfquery>
      <cfelse>
        <cfquery name="WA_mrtJoinRS" datasource="#WA_connection#">#WA_Sql#</cfquery>
      </cfif>
    </cfif>
  </cfloop>
</cffunction>