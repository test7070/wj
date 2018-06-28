<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title></title>
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
            q_tables = 't';
            var q_name = "tranorde";
            var q_readonly = ['txtNoa','txtWorker', 'txtWorker2','txtBoat'];
            var q_readonlys = ['txtAddress'];
            var bbsNum = new Array(['txtLengthb', 10, 2, 1],['txtWidth', 10, 2, 1],['txtHeight', 10, 2, 1],['txtVolume', 10, 2, 1],['txtWeight', 10, 2, 1],['txtTheight', 10, 0, 1],['txtTvolume', 10, 0, 1],['txtMount', 10, 0, 1],['txtPrice', 10, 2, 1],['txtMoney', 10, 0, 1],['txtTotal', 10, 0, 1],['txtTotal2', 10, 0, 1],['txtTotal3', 10, 0, 1]);
            var bbsMask = new Array(['txtTrandate', '999/99/99'],['txtDate1', '999/99/99'],['txtDate2', '999/99/99'],['txtTime1', '99:99'],['txtTime2', '99:99']);
            var bbtMask = new Array(); 
            var bbmNum = new Array(['txtTweight2', 10, 0, 1]);
            var bbmMask = new Array(['txtDatea', '999/99/99'],['txtDate1', '999/99/99'],['txtDate2', '999/99/99'],['txtTime1', '99:99'],['txtTime2', '99:99']);
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_alias = '';
            q_desc = 1;
            //q_xchg = 1;
            brwCount2 = 9;
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp,nick,memo2', 'txtCustno,txtComp,txtNick,txtMemo', 'cust_b.aspx'] 
                ,['txtAddrno', 'lblAddr_js', 'addr2_wj', 'custno,cust,address', 'txtAddrno,txtAddr,txtBoat', 'addr2_b2.aspx']
                ,['txtProductno_', 'btnProduct_', 'ucc', 'noa,product,unit,typea,namea,uweight,price2', 'txtProductno_,txtProduct_,txtUnit_,txtTypea_,txtProductno2_,txtVolume_,txtWeight_', 'ucc_b.aspx']
                ,['txtAddrno_', 'btnAddr1_', 'addr2_wj', 'custno,addr,b.siteno,b.address', 'txtAddrno_,txtAddr_,txtDriver_,txtAddress_', 'addr2_b2.aspx']
                ,['txtAddrno2_', 'btnAddr2_', 'addr2_wj', 'custno,addr,b.address,b.memo,b.siteno', 'txtAddrno2_,txtAddr2_,txtAddress2_,txtMemo_,txtContainerno1_', 'addr2_b2.aspx']
                ,['txtCno', 'lblCno', 'acomp', 'noa,acomp', 'txtCno,txtAcomp', 'acomp_b.aspx']
				,['txtDriverno_', 'btnDriverno_', 'tgg', 'noa,nick', 'txtDriverno_,txtCarno_', 'tgg_b.aspx']
                );
            $(document).ready(function() {
                var t_where = '';
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });
            
            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var cuft=0,t_mount=0,t_Price2=0,t_weight=0;
                for(var i=0;i<q_bbsCount;i++){
                    if($('#txtComp').val().indexOf('科思創')>-1){//科思創   淨重/單位淨重=數量 毛重/數量=單位毛
                        $('#txtMount_'+i).val(round(q_div(q_float('txtTvolume_'+i), q_float('txtWeight_'+i)),0));
                        $('#txtVolume_'+i).val(round(q_div(q_float('txtTheight_'+i), q_float('txtMount_'+i)),0));
                    }else{//單位淨重*數量=淨重   單位毛重*數量=毛重
                        if($('#txtTheight_'+i).val()==0){
                            $('#txtTheight_'+i).val(round(q_mul(q_float('txtVolume_'+i), q_float('txtMount_'+i)),0));
                        }
                        if($('#txtTvolume_'+i).val()==0){
                            $('#txtTvolume_'+i).val(round(q_mul(q_float('txtWeight_'+i), q_float('txtMount_'+i)),0));
                        }
                    }
                    
					if($('#txtUnit_'+i).val()=='板'){
						if($('#txtProduct2_'+i).val()=='墊板使用費')
							$('#txtTotal3_'+i).val(-q_mul(q_float('txtMount_'+i),20));
					}
					//$('#txtMoney_'+i).val(round(q_mul(q_div(q_float('txtTheight_'+i),1000),q_float('txtPrice_'+i)),0));
                    //$('#txtTotal_'+i).val(round(q_mul(q_div(q_float('txtTheight_'+i),1000),q_float('txtWidth_'+i)),0));
					$('#txtTotal_'+i).val(q_add(q_float('txtMoney_'+i),q_float('txtTotal3_'+i)));
                    if($('#txtDate1').val().length>0 && $('#txtDate1_'+i).val().length==0){
                        $('#txtDate1_'+i).val($('#txtDate1').val());
                        $('#txtTime1_'+i).val($('#txtTime1').val());
                    }
                    t_mount=q_add(t_mount,q_float('txtMount_'+i))  
                    t_weight=q_add(t_weight,q_float('txtTheight_'+i))  
                    t_Price2=q_add(t_Price2,q_float('txtTvolume_'+i)) 
                }
                $('#txtTweight2').val(t_weight);
                $('#txtMount').val(t_mount);
                $('#txtPrice2').val(t_Price2);
            }
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }
            function mainPost() {
                q_mask(bbmMask);
                var t_where = "where=^^ 1=1 ^^";
                q_gt('chgitem', t_where, 0, 0, 0, "");
                $('#btnPrice').click(function(e) {
                   if(q_cur == 1 || q_cur == 2){
                        var t_where = "where=^^ addrno='"+$('#txtCustno').val()+"' ^^ stop=999";
                        q_gt('addr2s', t_where, 0, 0, 0, "addr2s", r_accy, 1);
                        sum();
                   }
                });
                
                $('#txtCustno').change(function(e){sum();});
                
                $('#btnApv').click(function() {
                    if ($("#chkIsapv").prop("checked")) {
                        alert('已核准!!');
                        return;
                    }
                    if (!emp($('#txtNoa').val())) {
                        var t_noa=$('#txtNoa').val();
                        
                        q_func('qtxt.query.tranorde_apv', 'tranorde_wj.txt,tranorde_apv,' 
                            + encodeURI(t_noa)+';'+encodeURI(r_userno)+';'+encodeURI(r_name)+';'+encodeURI(r_accy),r_accy,1);
                    }
                    $('#chkEnda').prop('checked', true);
                    
                    for (var i = 0; i < brwCount; i++) {
                        if($('#vtnoa_'+i).text()!=''){
                             if($('#vtnoa_'+i).text()==$('#txtNoa').val()){
                                 $('#vtenda_'+i).text('v');
                             }
                        }
                        $('#chkBrow_'+i).focus();
                     }
                });
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.tranorde_apv':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0].msg.length!=0) {
                            alert(as[0].msg);
                        }
                        break;
                    default:
                        break;
                }
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
                b_pop = '';
            }

            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
				//q_cmbParse("combUnit_"+i, ',噸,片,顆,車,櫃,桶,板');
				q_cmbParse("combUnit2_"+i, ',噸,片,顆,車,櫃,桶,板');
				q_cmbParse("combOtype_"+i,',板車,聯結車,大貨車');
                    $('#lblNo_' + i).text(i + 1);
                    if($('#btnMinus_' + i).hasClass('isAssign'))
                        continue;
                    $('#txtProductno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnProduct_'+n).click();
                    });
                    $('#txtAddrno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr1_'+n).click();
                    });
                     $('#txtAddrno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnAddr2_'+n).click();
                    });
                    $('#txtDriverno_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                        $('#btnDriverno_'+n).click();
                    });
					var doc = $('#txtProductno2_' + i).val()
					$('#txtProductno2_' + i).bind('contextmenu', function(e) {
                        /*滑鼠右鍵*/
                        e.preventDefault();
                        var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
						if(doc.length>0)
							$('#btnDoc_'+n).click();
                    });
                    $('#txtPrice_'+i).change(function(e){sum();});
                    $('#txtLengthb_'+i).change(function(e){sum();});
                    $('#txtWidth_'+i).change(function(e){sum();});
                    $('#txtHeight_'+i).change(function(e){sum();});
                    $('#txtTypea_' + i).focusout(function (){
                        var s1 = $(this).val();
                            if (s1.length == 1 && s1 == "=") {
                                t_IdSeq = -1;  /// 要先給  才能使用 q_bodyId()
                                q_bodyId($(this).attr('id'));
                                b_seq = t_IdSeq;
                                if (b_seq > 0) {
                                    var i = b_seq - 1;
                                    var s1 = $('#txtTypea_' + i).val();
                                    $('#txtTypea_' + b_seq).val(s1);
                                    var s2 = $('#txtProductno_' + i).val();
                                    $('#txtProductno_' + b_seq).val(s2); 
                                    var s3 = $('#txtProduct_' + i).val();
                                    $('#txtProduct_' + b_seq).val(s3);
                                    var s4 = $('#txtLengthb_' + i).val();
                                    $('#txtLengthb_' + b_seq).val(s4);
                                    var s5 = $('#txtWidth_' + i).val();
                                    $('#txtWidth_' + b_seq).val(s5); 
                                    var s6 = $('#txtHeight_' + i).val();
                                    $('#txtHeight_' + b_seq).val(s6);
                                    var s7 = $('#txtVolume_' + i).val();
                                    $('#txtVolume_' + b_seq).val(s7);
                                    var s8 = $('#txtWeight_' + i).val();
                                    $('#txtWeight_' + b_seq).val(s8); 
                                    var s9 = $('#txtTheight_' + i).val();
                                    $('#txtTheight_' + b_seq).val(s9); 
                                    var s10 = $('#txtTvolume_' + i).val();
                                    $('#txtTvolume_' + b_seq).val(s10);
                                    var s11 = $('#txtAddrno2_' + i).val();
                                    $('#txtAddrno2_' + b_seq).val(s11);
                                    var s12 = $('#txtAddr2_' + i).val();
                                    $('#txtAddr2_' + b_seq).val(s12);
                                    var s13 = $('#txtAddress_' + i).val();
                                    $('#txtAddress_' + b_seq).val(s13);
                                    var s14 = $('#txtTrandate_' + i).val();
                                    $('#txtTrandate_' + b_seq).val(s14);
                                    var s15 = $('#txtMemo_' + i).val();
                                    $('#txtMemo_' + b_seq).val(s15);
                                    var s16 = $('#txtAddrno_' + i).val();
                                    $('#txtAddrno_' + b_seq).val(s16);
                                    var s17 = $('#txtAddr_' + i).val();
                                    $('#txtAddr_' + b_seq).val(s17);
                                    var s18 = $('#txtDriver_' + i).val();
                                    $('#txtDriver_' + b_seq).val(s18);
                                    var s19 = $('#txtContainerno1_' + i).val();
                                    $('#txtContainerno1_' + b_seq).val(s19);
                                    var s20 = $('#txtAddress2_' + i).val();
                                    $('#txtAddress2_' + b_seq).val(s20);
                                    var s21 = $('#txtCalctype_' + i).val();
                                    $('#txtCalctype_' + b_seq).val(s21);
                                    var s22 = $('#txtDate1_' + i).val();
                                    $('#txtDate1_' + b_seq).val(s22);
                                    var s23 = $('#txtDate2_' + i).val();
                                    $('#txtDate2_' + b_seq).val(s23);
                                    var s24 = $('#txtTime1_' + i).val();
                                    $('#txtTime1_' + b_seq).val(s24);
                                    var s25 = $('#txtTime2_' + i).val();
                                    $('#txtTime2_' + b_seq).val(s25);
                                    var s26 = $('#txtContainerno2_' + i).val();
                                    $('#txtContainerno2_' + b_seq).val(s26);
                                    var s27 = $('#txtUnit_' + i).val();
                                    $('#txtUnit_' + b_seq).val(s27);
                                    var s28 = $('#txtUnit2_' + i).val();
                                    $('#txtUnit2_' + b_seq).val(s28);
                                    var s29 = $('#txtTranno_' + i).val();
                                    $('#txtTranno_' + b_seq).val(s29);
                                    var s30 = $('#txtOtype_' + i).val();
                                    $('#txtOtype_' + b_seq).val(s30);
                                    var s31 = $('#txtMount_' + i).val();
                                    $('#txtMount_' + b_seq).val(s31);
                                }
                            }
                    });
                    $('#txtTypea_' + i).focus(function () {
                            if (!$(this).val())
                                q_msg($(this), '=號複製上一筆摘要');
                    });
                    
                    $('#txtWeight_' + i).change(function() {
                        sum();
                    });
                    
                    $('#txtVolume_' + i).change(function() {
                        sum();
                    });
                    
                    $('#txtWidth_' + i).change(function() {
                        sum();
                    });
                    
                    $('#txtTvolume_' + i).change(function() {
                        sum();
                    });
                    
					$('#txtTotal3_' + i).change(function() {
                        sum();
                    });
                    
                    $('#txtTheight_' + i).change(function() {
                        sum();
                    });
					
					$('#txtProduct2_' + i).change(function() {
                        sum();
                    });
                    
                    $('#txtMount_' + i).change(function() {
                        sum();
                    });
					
					$('#txtUnit_' + i).change(function() {
                        sum();
                    });
					
                    $('#combProduct_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if(q_cur==1 || q_cur==2)
                                $('#txtProduct2_'+b_seq).val($('#combProduct_'+b_seq).find("option:selected").text());
                    });
					$('#combUnit_' + i).change(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(q_cur==1 || q_cur==2)
							$('#txtUnit_'+b_seq).val($('#combUnit_'+b_seq).find("option:selected").text());
                    });
					$('#combUnit2_' + i).change(function() {
						t_IdSeq = -1;
						q_bodyId($(this).attr('id'));
						b_seq = t_IdSeq;
						if(q_cur==1 || q_cur==2)
							$('#txtUnit2_'+b_seq).val($('#combUnit2_'+b_seq).find("option:selected").text());
                    });
                    $('#combOtype_' + i).change(function() {
                        t_IdSeq = -1;
                        q_bodyId($(this).attr('id'));
                        b_seq = t_IdSeq;
                        if(q_cur==1 || q_cur==2)
                            $('#txtOtype_'+b_seq).val($('#combOtype_'+b_seq).find("option:selected").text());
                    });
                    
                    $('#combCalctype_' + i).change(function() {
                            t_IdSeq = -1;
                            q_bodyId($(this).attr('id'));
                            b_seq = t_IdSeq;
                            if(q_cur==1 || q_cur==2)
                                $('#txtCalctype_'+b_seq).val($('#combCalctype_'+b_seq).find("option:selected").text());
                    });
                }
                _bbsAssign();
                $('#tbbs').find('tr.data').children().hover(function(e){
                    $(this).parent().css('background','#F2F5A9');
                },function(e){
                    $(this).parent().css('background','#cad3ff');
                });
            }
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if($('#btnMinus__' + i).hasClass('isAssign'))
                        continue;
                }
                _bbtAssign();
            }
            function bbsSave(as) {
                if (!as['calctype'] && !as['addrno2'] && !as['addr2']  && !as['addrno'] && !as['addr'] && !as['productno'] && !as['product'] && !as['product2']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                as['addrno3']= abbm2['cno'] ;
                as['addr3'] = abbm2['acomp'];
                as['conn'] = abbm2['custno'];
                as['tel'] = abbm2['comp'];
                as['caseno'] = abbm2['po'];
                return true;
            }
            
            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tranorde_wj_s.aspx', q_name + '_s', "500px", "600px", q_getMsg("popSeek"));
            }
            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#chkEnda').prop('checked',false);
                $('#txtDatea').focus();
                /*for (var i = 0; i < q_bbsCount; i++) {
                    $('#txtOtype_'+i).val('板車');
                }*/
            }
            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                sum();
                $('#txtDatea').focus();
            }
            function btnPrint() {
                //q_box('z_tranorde_js.aspx?' + r_userno + ";" + r_name + ";" + q_time + ";" + $('#txtNoa').val() + ";" + r_accy, '', "95%", "95%", q_getMsg("popPrint"));
                q_box("z_tranorde_js.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'tranorde_js', "95%", "95%", q_getMsg("popPrint"));
            }
            
            function btnOk() {
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    Unlock(1);
                    return;
                }
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
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }
            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }
            
            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }
            function refresh(recno) {
                _refresh(recno);
                
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                    $('#txtDatea').datepicker('destroy');
                }else{
                    $('#txtDatea').datepicker();
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
                    case 'addr2s':
                                var addr2s = _q_appendData("addr2s", "", true);
                                        for (var i = 0; i < q_bbsCount; i++) {
                                            for (var j = 0; j < addr2s.length; j++) {
                                                var t_weight=dec(q_div($('#txtTweight2').val(),1000));
                                                var t_weight2=dec(q_div($('#txtPrice2').val(),1000));
                                                var t_Mount=dec($('#txtMount').val());
                                                if($('#txtUnit2_'+i).val()=='噸' && addr2s[j].wname=='毛重'
                                                && addr2s[j].lat==$('#txtContainerno2_'+i).val()
                                                && addr2s[j].addr==$('#txtOtype_'+i).val()  
                                                && addr2s[j].lng==$('#txtContainerno1_'+i).val() 
                                                && addr2s[j].carno==$('#txtTypea_'+i).val()
                                                && addr2s[j].address==$('#txtDriver_'+i).val()
                                                && t_weight<=addr2s[j].rate2 && t_weight>=addr2s[j].rate){
                                                    $('#txtPrice_'+i).val(addr2s[j].value);
                                                    $('#txtMoney_'+i).val(round(dec(q_mul(q_div($('#txtTheight_'+i).val(),1000),addr2s[j].value)),0));
                                                }
                                                else if($('#txtUnit2_'+i).val()=='噸' && addr2s[j].wname=='淨重' 
                                                && addr2s[j].lat==$('#txtContainerno2_'+i).val()
                                                && addr2s[j].addr==$('#txtOtype_'+i).val()
                                                && addr2s[j].lng==$('#txtContainerno1_'+i).val() 
                                                && addr2s[j].carno==$('#txtTypea_'+i).val()
                                                && addr2s[j].address==$('#txtDriver_'+i).val()
                                                && t_weight2<=addr2s[j].rate2 && t_weight2>=addr2s[j].rate){
                                                        $('#txtPrice_'+i).val(addr2s[j].value);
                                                        $('#txtMoney_'+i).val(round(dec(q_mul(q_div($('#txtTvolume_'+i).val(),1000),addr2s[j].value)),0));
                                                }
                                                else if($('#txtUnit2_'+i).val()!='噸' && addr2s[j].unit==$('#txtUnit2_'+i).val() 
                                                && addr2s[j].lat==$('#txtContainerno2_'+i).val() 
                                                && addr2s[j].lng==$('#txtContainerno1_'+i).val() 
                                                && addr2s[j].addr==$('#txtOtype_'+i).val()
                                                && addr2s[j].carno==$('#txtTypea_'+i).val()
                                                && addr2s[j].address==$('#txtDriver_'+i).val()
                                                && t_mount<=addr2s[j].mount2 && t_mount>=addr2s[j].mount){
                                                    $('#txtPrice_'+i).val(addr2s[j].value);
                                                    $('#txtMoney_'+i).val(round(dec(q_mul($('#txtMount_'+i).val(),addr2s[j].value)),0));
                                                }
                                        }
                                  }
                            t_weight=0;
                            t_weight2=0;
                            t_mount=0;
                            break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
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
            .tbbm .trX {
                background-color: #FFEC8B;
            }
            .tbbm .trY {
                background-color: pink;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 40%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
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
                width: 3050px;
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
            #tableTranordet tr td input[type="text"]{
                width:80px;
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
    <body 
    ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    >
        <!--#include file="../inc/toolbar.inc"-->
        <div id='dmain' >
            <div class="dview" id="dview">
                <table class="tview" id="tview">
                    <tr>
                        <td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
                        <td align="center" style="width:120px; color:black;display:none"><a>電腦單號</a></td>
                        <td align="center" style="width:120px; color:black;"><a>運輸單號</a></td>
                        <td align="center" style="width:130px; color:black;"><a>客戶</a></td>
                        <td align="center" style="width:95px; color:black;"><a>日期</a></td>
                        <td align="center" style="width:50px; color:black;"><a>結案</a></td>
                    </tr>
                    <tr>
                        <td><input id="chkBrow.*" type="checkbox"/></td>
                        <td id='noa' style="text-align: center;display:none">~noa</td>
                        <td id='po' style="text-align: center;">~po</td>
                        <td id='nick' style="text-align: center;">~nick</td>
                        <td id='datea' style="text-align: center;">~datea</td>
                        <td id='enda' style="text-align: center;">~enda</td>
                    </tr>
                </table>
            </div>
            <div class='dbbm'>
                <table class="tbbm"  id="tbbm">
                    <tr class="tr0" style="height:1px;">
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td> </td>
                        <td class="tdZ"> </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblNoa" class="lbl"> </a></td>
                        <td colspan="2"><input type="text" id="txtNoa" class="txt c1"/></td>
                        <td><span> </span><a id="lblDatea" class="lbl"> </a></td>
                        <td><input type="text" id="txtDatea" class="txt c1"/></td>
                        <td> </td>
                        <td><input id="chkEnda" type="checkbox"/>
                            <span> </span><a id='lblEnda_wj'>結案</a>
                        </td>
                        <td><input id="btnApv" type="button" value="結案"/></td></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCno" class="lbl btn">運輸公司</a></td>
                        <td colspan="6">
                            <input type="text" id="txtCno" class="txt" style="width:30%;float: left; " />
                            <input type="text" id="txtAcomp" class="txt" style="width:70%;float: left; " />
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
                        <td colspan="6">
                            <input type="text" id="txtCustno" class="txt" style="width:30%;float: left; " />
                            <input type="text" id="txtNick" class="txt" style="width:70%;float: left; " />
                            <input type="text" id="txtComp" class="txt" style="display:none; " />
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lbl" class="lbl">運輸單號</a></td>
                        <td colspan="2"><input id="txtPo" type="text"  class="txt c1"/></td>
                        <td><span> </span><a class="lbl">提貨日期</a></td>
                        <td colspan="2">
                            <input type="text" id="txtDate1" class="txt" style="width:60%;float: left; "/>
                            <input type="text" id="txtTime1" class="txt" style="width:40%;float: left; "/>
                        </td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblCbconn" class="lbl">承辦人</a></td>
                        <td colspan="2"><input id="txtCbconn" type="text"  class="txt c1"/></td>
                        <td><span> </span><a id="lblCbtel" class="lbl">連絡電話</a></td>
                        <td colspan="2"><input id="txtCbtel" type="text"  class="txt c1"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lbl" class="lbl">總毛重</a></td>
                        <td colspan="2"><input id="txtTweight2" type="text"  class="txt c1 num"/></td>
                        <td><span> </span><a id="lbl" class="lbl">總淨重</a></td>
                        <td colspan="2"><input id="txtPrice2" type="text"  class="txt c1 num"/></td>
						<td></td>
                        <td><input id="btnPrice" type="button" value="單價計算" style="width:100%;"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lbl" class="lbl">總數量</a></td>
                        <td colspan="2"><input id="txtMount" type="text"  class="txt c1 num"/></td>
                    </tr>
                    <tr>
                        <td><span> </span><a id="lblMemo" class="lbl"> </a></td>
                        <td colspan="6">
                            <textarea id="txtMemo" class="txt c1" style="height:75px;"> </textarea>
                        </td>
                    </tr>

                    <tr>
                        <td><span> </span><a id="lblWorker" class="lbl"> </a></td>
                        <td colspan="2"><input id="txtWorker" type="text"  class="txt c1"/></td>
                        <td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
                        <td colspan="2"><input id="txtWorker2" type="text"  class="txt c1"/></td>
                    </tr>
                </table>
            </div>
        </div>
        <div class='dbbs' >
            <table id="tbbs" class='tbbs' >
                <tr style='color:white; background:#003366;' >
                    <td align="center" style="width:25px"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
                    <td align="center" style="width:20px;"> </td>
                    <td align="center" style="width:120px"><a>類別</a></td>
					<td align="center" style="width:90px"><a>出單日期</a></td>
					<td align="center" style="width:120px"><a>送(提)貨單號</a></td>
					<td align="center" style="width:90px"><a>提貨日期</a></td>
                    <td align="center" style="width:250px"><a>提貨地點<br>起點-計價區域/地點</a></td>
					<td align="center" style="width:90px"><a>卸貨日期</a></td>
					<td align="center" style="width:250px"><a>收貨人<br>迄點-計價區域/地點</a></td>
					<td align="center" style="width:80px"><a>計價車種</a></td>
					<td align="center" style="width:65px"><a>車趟<br/>(1去2回)</a></td>
					<td align="center" style="width:80px"><a>計價單位</a></td>
					<td align="center" style="width:250px"><a>品名<br>承載單位</a></a></td>
                    <td align="center" style="width:120px"><a>危險等級<br>攜帶文件</a></td>
                    <td align="center" style="width:80px"><a>單位毛<br/>重(KG)</a></td>
                    <td align="center" style="width:70px"><a>單位淨<br/>重(KG)</a></td>
                    <td align="center" style="width:100px"><a>毛重(KG)</a></td>
                    <td align="center" style="width:100px"><a>淨重(KG)</a></td>
                    <td align="center" style="width:70px"><a>數量</a></td>
                    <td align="center" style="width:70px"><a>單價</a></td>
                    <td align="center" style="width:80px"><a>運費</a></td>
					<td align="center" style="width:120px"><a>加減項品名</a></td>
					<td align="center" style="width:100px;"><a>支付廠商</a></td>
					<td align="center" style="width:120px"><a>加減項金額</a></td>
					<td align="center" style="width:120px"><a>應收運費</a></td>
					<td align="center" style="width:80px"><a>人工裝費</a></td>
					<td align="center" style="width:80px"><a>管理收入</a></td>
					<td align="center" style="width:120px"><a>應付運費</a></td>
                    <td align="center" style="width:100px"><a>批號</a></td>
                    <td align="center" style="width:100px"><a>備註</a></td>
					<td align="center" style="width:100px"><a>注意事項</a></td>
                </tr>
                <tr class="data" style='background:#cad3ff;'>
                    <td align="center">
                        <input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
                        <input type="text" id="txtNoq.*" style="display:none;"/>
                    </td>
                    <td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    <td>
                        <input type="text" id="txtCalctype.*" type="text" class="txt c1" style="width: 80%;"/>
                        <select id="combCalctype.*" class="txt" style="width: 17px;"> </select>
                    </td>
					<td><input type="text" id="txtTrandate.*" style="width:95%;" /></td>
					<td><input type="text" id="txtTranno.*" style="width:95%;" /></td>
					<td align="center">
                        <input type="text" id="txtDate1.*" style="width:95%;" />
                        <input type="text" id="txtTime1.*" style="width:50%;" />
                    </td>
                    <td>
                        <input type="text" id="txtAddrno.*" style="width:30%;" />
                        <input type="text" id="txtAddr.*" style="width:60%;" />
                        <input type="text" id="txtDriver.*" style="width:96%;" />
                        <input type="text" id="txtAddress.*" style="width:96%;" />
                        <input type="button" id="btnAddr1.*" style="display:none;">
                    </td>
					<td align="center">
                        <input type="text" id="txtDate2.*" style="width:95%;" />
                        <input type="text" id="txtTime2.*" style="width:50%;" />
                    </td>
					<td>
                        <input type="text" id="txtAddrno2.*" style="width:30%;" />
                        <input type="text" id="txtAddr2.*" style="width:63%;" />
                        <input type="text" id="txtContainerno1.*" style="width:96%;" />
                        <input type="text" id="txtAddress2.*" style="width:96%;" />
                        <input type="button" id="btnAddr2.*" style="display:none;">
                        <input type="text" id="txtCaseno.*" style="display:none;">
                        <input type="text" id="txtAddrno3.*" style="display:none;">
                        <input type="text" id="txtAddr3.*" style="display:none;">
                        <input type="text" id="txtConn.*" style="display:none;">
                        <input type="text" id="txtTel.*" style="display:none;">
                    </td>
                    <td><input type="text" id="txtOtype.*" style="width:65%;" />
                        <select id="combOtype.*" class="txt" style="width: 15px;"> </select>
                    </td>
                    <td><input type="text" id="txtContainerno2.*" style="width:95%;" /></td>
                    <td>
                    <input type="text" id="txtUnit2.*" class="num" style="width:55%;" />
                    <select id="combUnit2.*" class="txt" style="width: 20px;"> </select>
                    </td>
                    <td>
                        <input type="text" id="txtProductno.*" style="width:30%;" />
                        <input type="text" id="txtProduct.*" style="width:63%;" />
                        <input type="text" id="txtUnit.*" style="width:96%;" />
                        <input type="button" id="btnProduct.*" style="display:none;">
                    </td>
                    <td>
    					<input type="text" id="txtTypea.*" style="width:95%;" />
    					<input id="chkChk1.*" type="checkbox"/>
    					<input type="text" id="txtProductno2.*" style="width:70%;" />
					</td>
                    <td><input type="text" id="txtVolume.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtWeight.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtTheight.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtTvolume.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtMount.*" class="num" style="width:95%;" /></td>
                    <td><input type="text" id="txtPrice.*" class="num" style="width:95%;" /></td>
                    <td><input type="text" id="txtMoney.*" class="num" style="width:95%;" /></td>
					<td>
                        <input type="text" id="txtProduct2.*" type="text" class="txt c1" style="width: 75%;"/>
                        <select id="combProduct.*" class="txt" style="width: 20px;"> </select>
                    </td>
					<td>
					<input type="text" id="txtDriverno.*" style="width:95%;"/>
					<input type="text" id="txtCarno.*" style="width:95%;"/>
					<input type="button" id="btnDriverno.*" style="display:none;">
					</td>
					<td><input type="text" id="txtTotal3.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtTotal.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtWidth.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtHeight.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtTotal2.*" class="num" style="width:95%;" /> </td>
                    <td><input type="text" id="txtUno.*" style="width:95%;" /></td>
                    <td><input type="text" id="txtMemo.*" style="width:95%;" /></td>
					<td><input type="text" id="txtMemo2.*" style="width:95%;" /></td>
					<td><input id="btnDoc.*" type=button onclick=window.open("https://flora2.epa.gov.tw/MainSite/") style="display:none;"></td>
                    <td bgcolor="white">&nbsp;</td>
            </table>
        <input id="q_sys" type="hidden" />
        <div id="dbbt" style="position: absolute;top:250px; left:450px; display:none;width:400px;">
            <table id="tbbt">
                <tbody>
                    <tr class="head" style="color:white; background:#003366;">
                        <td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
                        <td style="width:20px;"> </td>
                    </tr>
                    <tr class="detail">
                        <td>
                            <input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
                            <input class="txt" id="txtNoq..*" type="text" style="display:none;"/>
                        </td>
                        <td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>