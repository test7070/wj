﻿<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'tranorde_tranvcce', t_bbsTag = 'tbbs', t_content = "where=^^['','','','','','','')", afilter = [], bbsKey = ['noa'], as;
            t_sqlname = '';
            t_postname = q_name;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var i, s1;
            brwCount = -1;
            brwCount2 = 0;
            $(document).ready(function() {
                if (!q_paraChk())
                    return;

                main();
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
            });
            
            var where2,where3,where4,where5,where6
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                var t_para = new Array();
                try{
                    t_para = JSON.parse(decodeURIComponent(q_getId()[5]));
                    t_content = "where=^^['"+t_para.project+"','"+t_para.trandate+"','"+t_para.custno+"','"+t_para.cno+"','"+t_para.po+"','"+t_para.where2+"','"+t_para.where3+"')^^";
                }catch(e){
                }    
                brwCount = -1;
                mainBrow(6, t_content, t_sqlname, t_postname,r_accy);
            }

			function mainPost(){
			    q_getFormat();
                bbsMask = [];
                q_mask(bbsMask);			    
			}

            function bbsAssign() {
                _bbsAssign();
                $('#btnAddrnoes').click(function() {
                    var t_style=q_getId()[5] .split(',');
                    var t_href='http://'+location.host+location.pathname+'?'+q_getId()[0]+';'+q_getId()[1]+';'+q_getId()[2]+';'+q_getId()[3]+';'+q_getId()[4]+';'+t_style[0]+','+t_style[1]+','+t_style[2]+','+t_style[3]+','+t_style[4]+','+t_style[5].substr(0,13)+'%22'+'1'+'%22'+','+t_style[6]+','+t_style[7];           
                    location.href=t_href;
                });
                $('#btnAddrnoes1').click(function() {
                    var t_style=q_getId()[5] .split(',');
                    var t_href='http://'+location.host+location.pathname+'?'+q_getId()[0]+';'+q_getId()[1]+';'+q_getId()[2]+';'+q_getId()[3]+';'+q_getId()[4]+';'+t_style[0]+','+t_style[1]+','+t_style[2]+','+t_style[3]+','+t_style[4]+','+t_style[5].substr(0,13)+'%22'+'2'+'%22'+','+t_style[6]+','+t_style[7];            
                    location.href=t_href;
                });
                $('#btnAddrnoes2').click(function() {
                    var t_style=q_getId()[5] .split(',');
                    var t_href='http://'+location.host+location.pathname+'?'+q_getId()[0]+';'+q_getId()[1]+';'+q_getId()[2]+';'+q_getId()[3]+';'+q_getId()[4]+';'+t_style[0]+','+t_style[1]+','+t_style[2]+','+t_style[3]+','+t_style[4]+','+t_style[5].substr(0,13)+'%22'+'3'+'%22'+','+t_style[6]+','+t_style[7];
                    location.href=t_href;
                });
                $('#btnAddrnoes3').click(function() {
                    var t_style=q_getId()[5] .split(',');
                    var t_href='http://'+location.host+location.pathname+'?'+q_getId()[0]+';'+q_getId()[1]+';'+q_getId()[2]+';'+q_getId()[3]+';'+q_getId()[4]+';'+t_style[0]+','+t_style[1]+','+t_style[2]+','+t_style[3]+','+t_style[4]+','+t_style[5].substr(0,13)+'%22'+'4'+'%22'+','+t_style[6]+','+t_style[7];;         
                    location.href=t_href;
                });
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
                q_bbsCount = abbs.length;
                $('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                        var t_id = $(this).attr('id').split('_')[1];
                        if (!emp($('#txtNoa_' + t_id).val()))
                            $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });
                
                for(var i=0;i<q_bbsCount;i++){
					$('#lblNo_'+i).text((i+1));
				}
            }

		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body>
	    <div style="color: red;font-weight: bold;">※只顯示卸貨後五天的訂單資料</div>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:White; background:#003366;' >
					<td align="center" style="width:25px" ><input type="checkbox" id="checkAllCheckbox"/></td>
					<td align="center" style="width:25px;"> </td>
					<th align="center"><a id=''>運輸單號<br>訂單編號</a></th>
					<th align="center"><a id=''>品名</a></th>
					<th align="center"><a id=''>提貨時間</a></th>
					<th align="center"><a id=''>卸貨時間</a></th>
					<th align="center"><a id=''>毛重</a></th>
					<th align="center"><a id=''>數量</a></th>
					<th align="center"><a id=''>裝貨地點 </a>
					    <input class="btn"  id="btnAddrnoes" type="button" value='↓' style="font-weight: bold;"  />
					    <input class="btn"  id="btnAddrnoes1" type="button" value='↑' style="font-weight: bold;"  />
					</th>
					<th align="center"><a id=''>卸貨地點 </a>
					    <input class="btn"  id="btnAddrnoes2" type="button" value='↓' style="font-weight: bold;"  />
					    <input class="btn"  id="btnAddrnoes3" type="button" value='↑' style="font-weight: bold;"  />
					</th>
					<!--<th align="center"><a id=''>車牌</a></th>
					<th align="center"><a id=''>司機</a></th>-->
					<th align="center"><a id=''>裝貨</a></th>
					<th align="center"><a id=''>卸貨</a></th>
					<th align="center"><a id=''>拉貨</a></th>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td style="width:25px;"><input id="chkSel.*" type="checkbox"/></td>
					<td style="width:25px;"><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td style="width:150px;">
					    <input id="txtCaseno.*" type="text" style="float:left;width:98%;" readonly="readonly"/>
						<input id="txtNoa.*" type="text" style="float:left;width:70%;" />
						<input id="txtNoq.*" type="text" style="float:left;width:25%; text-align: right;"  readonly="readonly" />
					</td>
					<td style="width:120px;">
						<input id="txtProductno.*" type="text" style="display:none;"/>
						<input id="txtProduct.*" type="text" style="float:left;width:95%;" readonly="readonly" />
					</td>
					<td style="width:100px;">
                        <input id="txtDate1.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                        <input id="txtTime1.*" type="text" style="display:none;"/>
                    </td>
                    <td style="width:100px;">
                        <input id="txtDate2.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                        <input id="txtTime2.*" type="text" style="display:none;"/>
                    </td>
					
					<td style="width:90px;"><input id="txtTheight.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:90px;"><input id="txtMount.*" type="text" style="text-align:right;width:95%;" readonly="readonly"/></td>
					<td style="width:180px;">
                        <input id="txtAddrno.*" type="text" style="display:none;"/>
                        <input id="txtAddr.*" type="text" style="float:left;width:95%;" readonly="readonly"/>
                        <input id="txtAddress.*" type="text"  style="float:left;width:95%;" readonly="readonly"/>
                        <input id="txtMemo2.*" type="text" style="display:none;"/>
                    </td>
					<td style="width:180px;">
                        <input id="txtAddrno2.*" type="text" style="display:none;"/>
                        <input id="txtAddr2.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                        <input id="txtAddress2.*" type="text"  style="float:left;width:95%;" readonly="readonly"/>
                    </td>
                    <!--<td style="width:80px;"><input id="txtCarno.*" type="text" style="text-align:left;width:95%;" readonly="readonly"/></td>
                    <td style="width:80px;">
                        <input id="txtDriverno.*" type="text" style="display:none;"/>
                        <input id="txtDriver.*" type="text" style="float:left;width:95%;" readonly="readonly" />
                    </td>-->
                    <td style="width:20px;">
                        <input id="chkVchk1.*" type="checkbox" readonly="readonly"/>
                    </td>
                    <td style="width:20px;">
                        <input id="chkVchk2.*" type="checkbox" readonly="readonly"/>
                    </td>
                    <td style="width:20px;">
                        <input id="chkVchk4.*" type="checkbox" readonly="readonly"/>
                    </td>
				</tr>
			</table>
		</div>
		<div>
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>


