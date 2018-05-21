<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />

		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
			
            var q_name = "ucc";
            var q_readonly = ['txtWorker'];
            var bbmNum = [['txtSprice',10,0],['txtPrice',10,0]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 20;
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(['txtVccacc1', 'lblVccacc1', 'acc', 'acc1,acc2', 'txtVccacc1,txtVccacc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno], ['txtRc2acc1', 'lblRc2acc1', 'acc', 'acc1,acc2', 'txtRc2acc1,txtRc2acc2', "acc_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + "; ;" + r_accy + '_' + r_cno]);
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
                $('#txtNoa').focus();
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }///  end Main()

            function mainPost() {
                q_mask(bbmMask);
                $('#txtNoa').change(function(e){   	
					if($('#txtNoa').val().length>0){
						var t_where = "where=^^ noa in(select MAX(noa) from ucc where noa like '"+ $('#txtNoa').val() +"%')^^"
                        q_gt('ucc', t_where, 0, 0, 0, "uccno");
					}
                });
				$('#txtVccacc1').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
                });
				$('#txtRc2acc1').change(function(e) {
                    if($(this).val().length==4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val()+'.');	
                    }else if($(this).val().length>4 && $(this).val().indexOf('.')==-1){
                    	$(this).val($(this).val().substring(0,4)+'.'+$(this).val().substring(4));	
                    }
                });
				$('#btnUploadimg').click(function() {
					t_where = "noa='" + $('#txtNoa').val() + "'";
					q_box("uploadimg.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'uploadimg', "680px", "650px", q_getMsg('btnUploadimg'));
				});

            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + 'dc_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                    break;
					case 'uploadimg':
					var t_where = "where=^^noa='" + $('#txtNoa').val() + "'^^";
					q_gt('ucc', t_where, 0, 0, 0, "uploadimg_noa", r_accy);
					break;
                }   /// end Switch
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case "uccno":
                        var as = _q_appendData("ucc", "", true);
                        if (as.length > 0 && as[0].noa.indexOf("-")>=0){
                            var cno = as[0].noa.substr(as[0].noa.indexOf("-")+1,as[0].noa.length - as[0].noa.indexOf("-"));
                            $('#txtNoa').val($('#txtNoa').val() + '-' + right('000' +(parseInt(cno)+1).toString(),3));
                        }
                        t_where="where=^^ noa='"+$('#txtNoa').val().toUpperCase()+"'^^";
                        q_gt('ucc', t_where, 0, 0, 0, "checkUccno_change", r_accy);
                        break;
                	case 'checkUccno_change':
                		var as = _q_appendData("ucc", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].product);
                        }
                		break;
                	case 'checkUccno_btnOk':
                		var as = _q_appendData("ucc", "", true);
                        if (as[0] != undefined){
                        	alert('已存在 '+as[0].noa+' '+as[0].product);
                            Unlock();
                            return;
                        }else{
                        	wrServer($('#txtNoa').val());
                        }
                		break;

                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
					case 'uploadimg_noa':
						var as = _q_appendData("ucc", "", true);
						if (as[0] != undefined) {
							abbm[q_recno]['images'] = as[0].images;
							$('#txtImages').val(as[0].images);
						}
						$('.images').html('');
						if(!emp($('#txtImages').val())&&!emp($('#txtNoa').val())){
							imagename=$('#txtImages').val().split(';');
							imagename.sort();
							var imagehtml="<table width='1260px'><tr>";
							for (var i=0 ;i<imagename.length;i++){
								if(imagename[i]!='')
									imagehtml+="<td><img id='images_"+i+"' style='cursor: pointer;' width='200px' src='../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[i]+"?"+new Date()+"'> </td>"
							}
							imagehtml+="</tr></table>";
							$('.images').html(imagehtml);
							
							for (var i=0 ;i<imagename.length;i++){
								$('#images_'+i).click(function() {
									var n = $(this).attr('id').split('_')[1];
									t_where = "noa='" + $('#txtNoa').val() + "'";
									q_box("../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[n]+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
								});
							}
						}
					break;

                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box(q_name+'dc_s.aspx', q_name + 'dc_s', "550px", "400px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                refreshBbm();
                $('#txtNoa').focus();
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                refreshBbm();
                $('#txtNoa').attr('readonly','readonly');
                $('#txtItem').focus();
            }

            function btnPrint() {
 				q_box('z_uccdc.aspx', '', "90%", "600px", q_getMsg("popPrint"));
            }
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }
            function btnOk() {
            	Lock(); 
            	$('#txtNoa').val($.trim($('#txtNoa').val()));   	
                $('#txtWorker').val(r_name);
                
                if(q_cur==1){
                	t_where="where=^^ noa='"+$('#txtNoa').val()+"'^^";
                    q_gt('ucc', t_where, 0, 0, 0, "checkUccno_btnOk", r_accy);
                }else{
                	wrServer($('#txtNoa').val());
                }
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }
			var imagename='';
            function refresh(recno) {
                _refresh(recno);
                refreshBbm();
				
				$('.images').html('');
				if(!emp($('#txtImages').val())&&!emp($('#txtNoa').val())){
					imagename=$('#txtImages').val().split(';');
					imagename.sort();
					var imagehtml="<table width='1260px'><tr>";
					for (var i=0 ;i<imagename.length;i++){
						if(imagename[i]!='')
							imagehtml+="<td><img id='images_"+i+"' style='cursor: pointer;' width='200px' src='../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[i]+"?"+new Date()+"'> </td>"
					}
					imagehtml+="</tr></table>";
					$('.images').html(imagehtml);
					
					for (var i=0 ;i<imagename.length;i++){
						$('#images_'+i).click(function() {
							var n = $(this).attr('id').split('_')[1];
							t_where = "noa='" + $('#txtNoa').val() + "'";
							q_box("../images/upload/"+replaceAll($('#txtNoa').val(),'/','CHR(47)')+'_'+imagename[n]+"?;;;;;"+new Date(), 'image', "85%", "85%", "");
						});
					}
				}

            }
			function refreshBbm(){
            	if(q_cur==1){
            		$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
            	}else{
            		$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
            	}
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
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
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
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
                width: 550px;
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
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
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
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain'>
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewNoa'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewItem'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewVccacc1'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewRc2acc1'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='noa' style="text-align: center;">~noa</td>
						<td id='product' style="text-align:left;">~product</td>
						<td id='vccacc1' style="text-align:left;">~vccacc1</td>
						<td id='rc2acc1' style="text-align:left;">~rc2acc1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblItem2' class="lbl"> 品 名 </a></td>
						<td colspan="3"><input id="txtProduct" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUnit2' class="lbl"> 載運單位 </a></td>
						<td><input id="txtUnit"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lbltvolume' class="lbl"> 材 積 </a></td>
						<td><input id="txtTvolume"  type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblLevel' class="lbl"> 危險等級 </a></td>
						<td><input id="txtTypea" type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lbldoc' class="lbl"> 攜帶文件 </a></td>
						<td><input id="txtNamea" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUweight2' class="lbl"> 單位毛重(KG) </a></td>
						<td><input id="txtUweight" type="text"  class="txt c1 num"/></td>
						<td><span> </span><a id='lblSpec2' class="lbl"> 物品規格(長寬高) </a></td>
						<td>
						<input id="txtlengthb" type="text" class="txt c1 num" style="width:33%;"/>
						<input id="txtwidth" type="text" class="txt c1 num" style="width:33%;"/>
						<input id="txtheight" type="text" class="txt c1 num" style="width:33%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblUweight2' class="lbl"> 單位淨重(KG) </a></td>
						<td><input id="txtPrice2" type="text"  class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo2" class="lbl"> 品名注意事項 </a></td>
						<td colspan="3"><input id="txtMemo"  type="text" class="txt c1" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblVccacc1" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtVccacc1" type="text" style="float:left; width:35%;"/>
							<input id="txtVccacc2" type="text" style="float:left; width:65%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSprice' class="lbl"> </a></td>
						<td><input id="txtSprice" type="text"  class="txt num c1"/>	</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblRc2acc1" class="lbl btn" > </a></td>
						<td colspan="3">
							<input id="txtRc2acc1" type="text" style="float:left; width:35%;"/>
							<input id="txtRc2acc2" type="text" style="float:left; width:65%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblPrice' class="lbl"> </a></td>
						<td><input id="txtPrice" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1" /></td>
						<td>
						<input id="btnUploadimg" type="button" value="圖片上傳"/>
						<input type="hidden" id="txtImages" class="txt c1"/>
						</td>
					</tr>
					<input type="hidden" id="txtImages" class="txt c1"/>
				</table>
			</div>
		</div>
		<div class='images' style="float: left;"> </div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
