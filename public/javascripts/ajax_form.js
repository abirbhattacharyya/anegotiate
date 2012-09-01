function fb_login_button_click()
{
    window.location = "/users/link_user_accounts"
}
function calculate(each,qty,total)
{
    var each_val = each
    if(isNaN(parseInt(qty)))
        qty = 1
    else
    {
        if(qty > 0)
        {
            document.getElementById(total).innerHTML = Comma((parseInt(each_val)*qty));
        }
        else
            document.getElementById(total).innerHTML = Comma((parseInt(each_val)));
    }
}
function checkLength(id)
{
    val = document.getElementById(id).value
    if(isNaN(parseInt(val)))
        document.getElementById(id).value = ''
    else
        document.getElementById(id).value = val.substring(0,2)
}

function hideframe(id)
{
    document.getElementById(id).style.display='none'
}
function showframe(id)
{
    document.getElementById(id).style.display='block'
}
function keyRestrict(e, validchars) 
{
     var key='', keychar='';
     key = getKeyCode(e);
     if (key == null) return true;
     keychar = String.fromCharCode(key);
     keychar = keychar.toLowerCase();
     validchars = validchars.toLowerCase();
     if (validchars.indexOf(keychar) != -1)
        return true;
     if ( key==null || key==0 || key==8 || key==9 || key==13 || key==27 )
        return true;
     return false;
}
function getKeyCode(e)
{
     if (window.event)
        return window.event.keyCode;
     else if (e)
        return e.which;
     else
        return null;
}

function isNumber(field)
{
    var re = /^[0-9-'.'-',']*$/;
    if (!re.test(field.value))
    {
	field.value = field.value.replace(/[^0-9-'.'-',']/g,"");
    }
    if((field.id != 'entry_zip') && (field.id != 'entry_hzip'))
    {
	Comma(field.id);
    }
}	
function Comma(number) 
{
    //var number = document.getElementById(id).value;
    number = removeCommas(number);	
    var tnumber = number;
    var roundedNumber = roundNumber(number,0);
    number = roundedNumber;	
    if (roundedNumber > tnumber)
    {
        var rnumber = roundedNumber - tnumber
    }
    else 
    {
        var rnumber = tnumber - roundedNumber
    }
    number = '' + number;
    if (number.length > 3) 
    {
        var mod = number.length % 3;
        var output = (mod > 0 ? (number.substring(0,mod)) : '');
        for (i=0 ; i < Math.floor(number.length / 3); i++) 
        {
            if ((mod == 0) && (i == 0))
                output += number.substring(mod+ 3 * i, mod + 3 * i + 3);
            else
                output+= ',' + number.substring(mod + 3 * i, mod + 3 * i + 3);
        }
		
        if((rnumber > 0) && (tnumber< 999))
        {
            output = output + "." + rnumber;
        }		
        //checkDecimals(id,output);
        //document.getElementById(id).value = output;
        return (output);
    }
    else 
    {
        if (number != "") 
        {
            var output = parseFloat(removeCommas(number));
            //checkDecimals(id,output);
            return output;
        }
    }
}
function checkDecimals(fieldName, fieldValue) 
{
    decallowed = 1;  // how many decimals are allowed?

    if (isNaN(fieldValue) || fieldValue == "" || parseInt(fieldValue)==0) 
    {
        document.getElementById(fieldName).value="";
        document.getElementById(fieldName).select();
        document.getElementById(fieldName).focus();
    }
    else 
    {
        strvalue=''+fieldValue;
        if (strvalue.indexOf('.') == -1) strvalue += ".";
        dectext = strvalue.substring(strvalue.indexOf('.')+1, strvalue.length);

        if (dectext.length > decallowed)
        {
            var strLen = strvalue.length;
            myStr = strvalue.slice(0,strLen-1);
            document.getElementById(fieldName).value = myStr;
        }
   }
}

function roundNumber(num, dec)
{
    var result = Math.round(num*Math.pow(10,dec))/Math.pow(10,dec);
    return result;
}

function removeCommas(aNum)
{
//    aNum=aNum.replace(/,/g,""); //remove any commas
 //   aNum=aNum.replace(/\s/g,""); //remove any spaces
    return aNum;
}

function charCount(id,Div,num)
{
    var str=document.getElementById(id).value;
    if((num-str.length)<0)
    {
        document.getElementById(id).value=str.substring(0,num);str=document.getElementById(id).value;
    }
    var left_char=num-str.length
    document.getElementById(Div).innerHTML=left_char+" characters are left";
}
