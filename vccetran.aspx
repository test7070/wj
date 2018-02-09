
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            q_tables = 's';
            var q_name = "borr";
            var q_readonly = ['txtNoa','txtWorker', 'txtWorker2'];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [['txtN01', 10, 0, 0],['txtN02', 10, 2, 1],['txtN03', 10, 2, 1]];
            var bbmMask = [];
            var bbsMask = [['txtBdate', '999/99/99'],['txtEdate', '999/99/99']];
			
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            aPop = new Array(
			['txtV01', 'lblCno', 'acomp', 'noa,acomp', 'txtV01,txtV02', 'acomp_b.aspx'],
            ['txtCustno', 'lblAddr_js', 'cust', 'noa,nick', 'txtCustno,txtCust', 'cust_b.aspx'],
			['txtAddrno_', 'btnAddr_', 'addr2_wj', 'custno,addr,b.address', 'txtAddrno_,txtAddr_,txtAcc1_', 'addr2_b2.aspx'],
			['txtAddrno2_', 'btnAddr2_', 'addr2_wj', 'custno,addr,b.address', 'txtAddrno2_,txtAddr2_,txtAcc2_', 'addr2_b2.aspx'],
			['txtCarno_', 'btnCarno_', 'car2', 'a.noa', 'txtCarno_', 'car2_b.aspx'],
			['txtCardealno_', 'btnCardealno_', 'car2', 'a.noa', 'txtCardealno_', 'car2_b.aspx']
			);

            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }
            var t_weight=0;

            function mainPost() {
                q_mask(bbmMask);
                $('#txtDatea').datepicker();
                $('#textBdate').datepicker();
                $('#textEdate').datepicker();
                document.title = '中油理貨作業';
                var t_where = "where=^^ 1=1 ^^";
                q_gt('chgitem', t_where, 0, 0, 0, "");

                $('#btnImport').click(function() {
                    t_custno=$('#txtCustno').val();
                    t_po=$('#txtVccno').val();
                    t_date=$('#txtDatea').val();
                    var t_where = "(Edate between '"+q_cdn(t_date,-1)+"' and '"+q_cdn(t_date,1)+"') and (custno like '007%') and (conn='"+t_po+"' or len('"+t_po+"')=0)";
                    q_box("tranvccewj_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'tranvcceimport', "100%", "100%", "");
                });
                $('#txtAddrno').change(function() {
                     var t_where = "where=^^ noa in(select max(noa) from addr2 where sdate<='"+$('#txtDatea').val()+"' and custno in (select noa from cust) group by custno,cust)^^ stop=999";
                     q_gt('addr2', t_where, 0, 0, 0, "addr2");
                });
                $('#txtDatea').change(function() {
                     var t_where = "where=^^ noa in(select max(noa) from addr2 where sdate<='"+$('#txtDatea').val()+"' and custno in (select noa from cust) group by custno,cust)^^ stop=999";
                     q_gt('addr2', t_where, 0, 0, 0, "addr2");
                });
                $('#txtLat').change(function() {
                     var t_where = "where=^^ po='"+$('#txtLat').val()+"' ^^ stop=999";
                     q_gt('view_tranorde', t_where, 0, 0, 0, "view_tranorde");
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case 'tranvcceimport':
                            if (q_cur > 0 && q_cur < 4) {
                                b_ret = getb_ret();
                                if (!b_ret || b_ret.length == 0)
                                    return;
									 ret = q_gridAddRow(bbsHtm, 'tbbs'
									,'txtBdate,txtCheckno,txtAddrno,txtAddr,txtAcc1,txtCarno,txtM01,txtEdate,txtAddrno2,txtAddr2,txtAcc2,txtCardealno,txtM02,txtAddr3,txtN01,txtN02,txtEf,txtN03,txtMemo'
									,b_ret.length, b_ret
									,'bdate,noa,addrno,addr,address,carno,driver,edate,addrno2,addr2,address2,carno,driver,product,mount,weight,unit,,'
								    ,'txtBdate,txtCheckno,txtAddrno,txtAddr,txtAcc1,txtCarno,txtM01,txtEdate,txtAddrno2,txtAddr2,txtAcc2,txtCardealno,txtM02,txtAddr3,txtN01,txtN02,txtEf,txtN03,txtMemo');	
									wtt(b_ret.length);
                             }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }
			function wtt(a) {
				for(var i =0;i<a;i++){
				var weight = $('#txtN02_'+i).val().replace(",", "");
				var ton = weight/1000
					$('#txtN02_'+i).val(ton);
				}
			}
            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'chgitem':
                        var as = _q_appendData("chgitem", "", true);
                        var t_chgitem='@';
                        for ( i = 0; i < as.length; i++) {
                            t_chgitem+=","+as[i].item;
                        }
                        q_cmbParse("combProduct", t_chgitem,'s');
                        var t_where = "where=^^ 1=1 ^^";
                        q_gt('calctype',t_where, 0, 0, 0, "");
                        break;
                    case 'calctype':
                        var as = _q_appendData("calctype", "", true);
                        var t_calctype='@';
                        for ( i = 0; i < as.length; i++) {
                            t_calctype+=","+as[i].namea;
                        }
                        q_cmbParse("combCalctype", t_calctype,'s');
                        break;
                    case 'addr2':
                            var as = _q_appendData("addr2", "", true);
                            if(as[0]!=undefined){
                                var addr2s = _q_appendData("addr2s", "", true);
                                for (var j = 0; j< q_bbsCount; j++) {
                                    for (var i = 0; i < addr2s.length; i++) {
                                        if(addr2s[i].addrno==$('#txtAddrno_'+j).val() && addr2s[i].carno==$('#txtTypea_'+j).val() && dec(addr2s[i].rate)<=dec(q_div(t_weight,1000)) && dec(addr2s[i].rate2)>=dec(q_div(t_weight,1000)) && dec(addr2s[i].lat)<=$('#txtLat_'+j).val() && dec(addr2s[i].lng)>=$('#txtLat_'+j).val()){
                                            $('#txtVolume_'+j).val(addr2s[i].value);
                                            $('#txtTotal_'+j).val(round(dec(q_mul(q_div($('#txtWeight_'+j).val(),1000),addr2s[i].value)),0));
                                        }
                                    }
                                }
                            }
                            t_weight=0;
                            break;
                    case 'view_tranvcces':
                            var as = _q_appendData("view_tranvcces", "", true);
                            if(as[0]!=undefined){
                                $('#chk1').prop('checked',true);
                            }
                            t_weight=0;
                            break;
                    case 'view_tranorde':
                            var as = _q_appendData("view_tranorde", "", true);
                            if(as[0]!=undefined){
                                $('#txtAddrno').val(as[0].addrno);
                                $('#txtAddr').val(as[0].addr);
                                $('#txtAddress').val(as[0].boat);
                                $('#txtCno').val(as[0].cno);
                                $('#txtAcomp').val(as[0].acomp);
                            }
                            t_weight=0;
                            break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function q_popPost(s1) {
            }

            function btnOk() {
                if(q_cur ==1){
                    $('#txtWorker').val(r_name);
                }else if(q_cur ==2){
                    $('#txtWorker2').val(r_name);
                }else{
                    alert("error: btnok!");
                }
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                //q_box('tranvcce_wj_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }
			
			
			function refreshBbs() {
                for(var i=0;i<q_bbsCount;i++){
                    if($('#chkChk1_'+i).prop('checked')){
						var a = $('#txtAddr_'+i).val();
						$('#txtAddr_'+i).val(a+'(取消)')
                    }
					else {
						var a = $('#txtAddr_'+i).val();
						$('#txtAddr_'+i).val(a.replace(/\(取消\)/, ""))
					}
                }
            }
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                        continue;
                        $('#txtAddrno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnAddr_'+n).click();
                        })
                        $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnAddr2_'+n).click();
                        });
						$('#txtCarno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnCarno_'+n).click();
                        });
						$('#txtCardealno_' + i).bind('contextmenu', function(e) {
                            /*滑鼠右鍵*/
                            e.preventDefault();
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnCardealno_'+n).click();
                        });
				}
				_bbsAssign();
				refreshBbs();
			}

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtTrandate').val(q_date());
                $('#txtDatea').val(q_date()).focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
            }

            function btnPrint() {
            	q_box("z_vccetran.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'trans_mul', "95%", "95%", q_getMsg("popPrint"));
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function bbsSave(as) {
                if (!as['calctype'] && !as['custno'] && !as['cust'] && !as['addrno2'] && !as['addrno'] && !as['addr'] && !as['addr2'] && !as['carno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['cno'] = abbm2['cno'];
                as['acomp'] = abbm2['acomp'];
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
                t_where="where=^^ noa=(select ordeno from view_trans where ordeno='"+$('#txtNoa').val()+"' group by ordeno)^^ stop=999";
                q_gt('view_tranvcces', t_where, 0, 0, 0, "view_tranvcces");
				refreshBbs();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                    $('#txtDatea').datepicker('destroy');
                    $('#btnImport').attr('disabled','disabled');
                    $('#btnImport_trans').removeAttr('disabled');
                }else{
                    $('#txtDatea').datepicker();
                    $('#btnImport').removeAttr('disabled');
                    $('#btnImport_trans').attr('disabled','disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
                //q_box('tranvcce_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.vccetran2tranvcce_wj':
                        var as = _q_appendData("tmp0", "", true, true);
                        alert(as[0].msg);
                        break;
                    default:
                        break;
                }
            }

		</script>
		<style type="text/css">
            #dmain {
                overflow: auto;
            }
            .dview {
                float: left;
                width: 400px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 750px;
                /*margin: -1px;
                 border: 1px black solid;*/
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 12%;
            }
            .tbbm .tr2, .tbbm .tr3, .tbbm .tr4 {
                background-color: #FFEC8B;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 2400px;
            }
            .tbbs a {
                font-size: medium;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            select {
                font-size: medium;
            }
            .font1 {
                font-family: "細明體", Arial, sans-serif;
            }
            #tableTranordet tr td input[type="text"] {
                width: 80px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
	<div id="divImport" style="position:absolute; top:250px; left:600px; display:none; width:400px; height:200px; background-color: #cad3ff; border: 5px solid gray;">
            <table style="width:100%;">
                <tr style="height:1px;">
                    <td style="width:150px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                    <td style="width:80px;"></td>
                </tr>
                <tr style="height:35px;">
                    <td><span> </span><a style="float:right; color: blue; font-size: medium;">出車日期</a></td>
                    <td colspan="4">
                    <input id="textBdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    <span style="float:left;display:black;height:100%;width:30px;">~</span>
                    <input id="textEdate"  type="text" style="float:left; width:100px; font-size: medium;"/>
                    </td>
                </tr>
                <tr style="height:35px;">
                    <td><span> </span><a style="float:right; color: blue; font-size: medium;">出車車號</a></td>
                    <td colspan="4">
                    <input id="textCarno"  type="text" style="float:left; width:100px; font-size: medium;"/>
                </tr>
                <tr style="height:35px;">
                    <td> </td>
                    <td><input id="btnImport_trans" type="button" value="匯入"/></td>
                    <td></td>
                    <td></td>
                    <td><input id="btnCancel_import" type="button" value="關閉"/></td>
                </tr>
            </table>
        </div>
		<div id="toolbar">
  <div id="q_menu"></div>
  <div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <input id="btnXchg" type="button" style="display:none;background:url(../image/xchg_24.png) no-repeat;width:28px;height:26px"/>
  <a id='lblQcopy' style="display:none;"></a>
  <input id="chekQcopy" type="checkbox" style="display:none;"/>
  <input id="btnIns" type="button"/>
  <input id="btnModi" type="button"/>
  <input id="btnDele" type="button"/>
  <input id="btnSeek" type="button"/>
  <input id="btnSeeka" type="button" style="display:none"/>
  <input id="btnPrint" type="button"/>
  <input id="btnPrevPage" type="button"/>
  <input id="btnPrev" type="button"/>
  <input id="btnNext" type="button"/>
  <input id="btnNextPage" type="button"/>
  <input id="btnOk" type="button" disabled="disabled" />
  <input id="btnOka" type="button" disabled="disabled" style="display:none" />
  <input id="btnCancel" type="button" disabled="disabled"/>&nbsp;&nbsp;
  <input id="btnAuthority" type="button" />&nbsp;&nbsp;
  <span id="btnSign" style="text-decoration: underline;"></span>&nbsp;&nbsp;
  <span id="btnAsign" style="text-decoration: underline;"></span>&nbsp;&nbsp;
  <span id="btnLogout" style="text-decoration: underline;color:orange;"></span>&nbsp;&nbsp;
  <input id="pageNow" type="text"  style="position: relative;text-align:center;"  size="2"/> /
  <input id="pageAll" type="text"  style="position: relative;text-align:center;"  size="2"/>
    <select id="combLang"  style="display:none"><option value ="0">中</option>
      <option value ="1">EN</option>
      <option value ="2">簡</option>
      <option value ="3">VN</option>
    </select>
  </div>
  <div id="q_acDiv"></div>
</div>
		<div id="dmain" >
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:5%"><a id="vewChk"> </a></td>
						<td align="center" style="display:none;"><a> </a></td>
						<td align="center" style="width:20%"><a>日期</a></td>
						<td align="center" style="width:20%"><a>運輸單號</a></td>
					</tr>
					<tr>
						<td>
						<input id="chkBrow.*" type="checkbox"/>
						</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='vccno'>~vccno</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr class="tr0" style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl" > </a></td>
						<td>
						<input id="txtNoa" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblDatea" class="lbl" > </a></td>
						<td>
						<input id="txtDatea" type="text" class="txt c1" />
						</td>		
					</tr>
					<tr>
                        <td><span> </span><a id="lblCno" class="lbl btn" >公司</a></td>
                        <td colspan="3">
                            <input type="text" id="txtV01" class="txt" style="float:left;width:40%;"/>
                            <input type="text" id="txtV02" class="txt" style="float:left;width:60%;"/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblAddr_js" class="lbl btn">客戶</a></td>
                        <td colspan="4">
                            <input type="text" id="txtCustno" class="txt" style="width:30%;float: left; " />
                            <input type="text" id="txtCust" class="txt" style="width:70%;float: left; " />
                        </td> 
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblpo" class="lbl">運輸單號</a></td>
                        <td colspan="2"><input type="text" id="txtVccno" class="c1 txt"/></td>
                    </tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl" > </a></td>
						<td colspan="5"><textarea id="txtMemo" style="height:40px;" class="txt c1"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl" > </a></td>
						<td>
						<input id="txtWorker" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblWorker2" class="lbl" > </a></td>
						<td>
						<input id="txtWorker2" type="text" class="txt c1" />
						</td>
						<td></td>
                        <td><input id="btnImport" type="button" value="派車匯入" style="width:100%;"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' >
			<table id="tbbs" class='tbbs' style="width:1800px;">
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:25px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"><a>項次</a></td>
					<td align="center" style="width:30px;"><a>裝車日期</a></td>
					<td align="center" style="width:30px;"><a>裝車地點</a></td>
					<td align="center" style="width:30px;"><a>裝車車號</a></td>
					<td align="center" style="width:30px;"><a>卸貨日期</a></td>
					<td align="center" style="width:30px;"><a>運達地點</a></td>
					<td align="center" style="width:30px;"><a>卸貨車號</a></td>
					<td align="center" style="width:30px;"><a>品名</a></td>
					<td align="center" style="width:30px;"><a>數量</a></td>
					<td align="center" style="width:30px;"><a>單位</a></td>
					<td align="center" style="width:30px;"><a>載重量(噸)</a></td>
					<td align="center" style="width:30px;"><a>備註</a></td>
					<td align="center" style="width:30px;"><a>取消</a></td>
					
				</tr>
				<tr class="data" style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td>
					<input type="text" id="txtBdate.*" style="width: 95%;"/>
					<input type="text" id="txtCheckno.*" style="display:none;"/>
					</td>
					<td>
                        <input type="text" id="txtAddrno.*" style="width:33%;" />
                        <input type="text" id="txtAddr.*" style="width:60%;" />
                        <input type="text" id="txtAcc1.*" style="width:97%;" />
                        <input type="button" id="btnAddr.*" style="display:none;">
                    </td>

					<td>
					<input type="text" id="txtCarno.*" style="width:42%;" />
					<input type="text" id="txtM01.*" style="width:42%;" />
					<input type="button" id="btnCarno.*" style="display:none;">
					</td>
                    <td>
					<input type="text" id="txtEdate.*" style="width: 95%;"/></td>
					<td>
                        <input type="text" id="txtAddrno2.*" style="width:33%;" />
                        <input type="text" id="txtAddr2.*" style="width:60%;" />
                        <input type="text" id="txtAcc2.*" style="width:97%;" />
                        <input type="button" id="btnAddr2.*" style="display:none;">
                    </td>
					<td>
					<input type="text" id="txtCardealno.*" style="width:42%;" />
					<input type="text" id="txtM02.*" style="width:42%;" />
					<input type="button" id="btnCardealno.*" style="display:none;">
					</td>
                    <td><input type="text" id="txtAddr3.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtN01.*" style="width:95%;" /></td>
					<td><input type="text" id="txtEf.*" style="width:95%;" /></td>
					<td><input type="text" id="txtN02.*" style="width:95%;"/></td>
					<td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
					<td align="center"><input id="chkChk1.*" type="checkbox"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden"/>
	</body>
</html>
