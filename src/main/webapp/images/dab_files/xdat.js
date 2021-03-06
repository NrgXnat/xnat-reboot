/*
 * xnat-web: plugin-resources/webapp/xnat/images/dab_files/xdat.js
 * XNAT http://www.xnat.org
 * Copyright (c) 2005-2017, Washington University School of Medicine and Howard Hughes Medical Institute
 * All Rights Reserved
 *
 * Released under the Simplified BSD.
 */

//DO NOT EDIT THIS FILE, IT MAY BE OVER-WRITTEN.

var supported = (document.getElementById || document.all); 

if (supported)
{
	document.write("<STYLE TYPE='text/css'>");
	document.write(".para {display: none}");
	document.write("</STYLE>");

	var max = 7;
	var shown = new Array();
	for (var i=1;i<=max;i++)
	{
		shown[i+1] = false;
	}
}

function popupWSize(url,h,w)
{
	if (! window.focus)return true;
	window.open(url, "", "width=" + w + ",height=" + h + ",status=yes,resizable=yes,scrollbars=yes,toolbar=yes");
	return false;
}

function popupWithProperties(mylink, windowname, WinProperties)
{
	if (! window.focus)return true;
	var href;
	if (typeof(mylink) == 'string')
	{
   		href=mylink;
	}else
	{
  	 	href=mylink.href;
	}

   	if (href.indexOf('popup_params/') != -1)
   	{
   		var index = href.indexOf('popup_params/') + 13;
   		WinProperties = href.substring(index);
   		href = href.substring(0,href.indexOf('popup_params/'));
   	}
	window.open(href, '', WinProperties);
	return false;
}


function popup(mylink, windowname)
{
	if (! window.focus)return true;
	var href;
	if (typeof(mylink) == 'string')
   		href=mylink;
	else
   		href=mylink.href;
	window.open(href, windowname, 'width=600,height=800,status=yes,resizable=yes,scrollbars=yes,toolbar=yes');
	return false;
}


function IsNumeric(sText)
{
   var ValidChars = "0123456789.";
   var IsNumber=true;
   var Char;

 
   for (i = 0; i < sText.length && IsNumber == true; i++) 
      { 
      Char = sText.charAt(i); 
      if (ValidChars.indexOf(Char) == -1) 
         {
         IsNumber = false;
         }
      }
   return IsNumber;
   
}
   

//FUNCTION USED TO TOGGLE SPANS VISIBILITY
function blocking(i)
{
	if (!supported)
	{
        xmodal.message('Unsupported Browser Link', 'This link does not work in your browser.');
		return;
	}
	var plusLocation = serverRoot+ "/images/plus.jpg";
	var minusLocation = serverRoot+ "/images/minus.jpg";
	
	imgShow = (shown[i]) ? minusLocation : plusLocation;

	var imgCode = 'IMG' + i;
	
	if (document.getElementById)
	{
	 	//COMMON 
		var current = document.getElementById('span'+i).style.display;
		if (current == 'block')
		{
			document.getElementById('span'+i).style.display = 'none';
			document.images[imgCode].src= plusLocation;
		}else{
			document.getElementById('span'+i).style.display = 'block';
			document.images[imgCode].src= minusLocation;
		}
	}
	else if (document.all)
	{
		var current = document.all['span'+i].style.display;
		if (current == 'block')
		{
			document.all['span'+i].style.display = 'none';
			document.images[imgCode].src= plusLocation;
		}else{
			document.all['span'+i].style.display = 'block';
			document.images[imgCode].src= minusLocation;
		}
	}
	
	return false;
}

//REDIRECTION SCRIPTS
//SHOW ITEM REPORT
function rpt(exptId,displayElement,searchField)
{
	if (! window.focus)return true;
	var link = serverRoot+ "/app/action/DisplayItemAction/popup/true";
	link = link + "/search_value/" + exptId.toString() + "/search_element/" + displayElement.toString() + "/search_field/" + searchField;
	window.open(link, '','width=725,height=800,status=yes,resizable=yes,scrollbars=yes,toolbar=yes');
	return false;
}

//SHOW ITEM EDIT PAGE
function edit(exptId,displayElement,searchField)
{
	if (! window.focus)return true;
	var link = serverRoot+ "/app/action/EditItemAction/popup/true";
	link = link + "/search_value/" + exptId.toString() + "/search_element/" + displayElement.toString() + "/search_field/" + searchField;
	window.open(link, '','width=600,height=800,status=yes,resizable=yes,scrollbars=yes,toolbar=yes');
	return false;
}

//SHOW EMAIL SCREEN
function email(toAddress)
{
	if (! window.focus)return true;
	var link = serverRoot+ "/app/template/XDATScreen_email.vm";
	link = link + "/emailTo/" + toAddress;
	window.location = link;
	return false;
}

//SHOW ITEM XML
function displayXML(searchValue,displayElement,searchField)
{
	if (! window.focus)return true;
	var link = serverRoot+ "/app/action/DisplayXMLAction/popup/true";
	link = link + "/search_value/" + searchValue.toString() + "/search_element/" + displayElement.toString() + "/search_field/" + searchField;
	window.open(link, '','width=600,height=800,status=yes,resizable=yes,scrollbars=yes,toolbar=yes');
	return false;
}

/**
 * DHTML date validation script. Courtesy of SmartWebby.com (http://www.smartwebby.com/dhtml/)
 */
// Declaring valid date character, minimum year and maximum year
var dtCh= "/";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr){
	if (dtStr=="")
	{
		return true;
	}
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strMonth=dtStr.substring(0,pos1)
	var strDay=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
        xmodal.message('Date Validation', 'The date format should be : mm/dd/yyyy');
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
        xmodal.message('Date Validation', 'Please enter a valid month.');
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
        xmodal.message('Date Validation', 'Please enter a valid day.');
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
        xmodal.message('Date Validation', 'Please enter a valid 4 digit year between '+minYear+' and '+maxYear+'.');
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
        xmodal.message('Date Validation', 'Please enter a valid date.');
		return false
	}
return true
}
