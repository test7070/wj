﻿
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
           if (location.href.indexOf('?') < 0) {
				location.href = location.href + "?;;;;" + ((new Date()).getUTCFullYear() - 1911);
			}
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_tran_wj');
            });
            function q_gfPost() {
               $('#q_report').q_report({
                        fileName : 'z_tran_wj',
                        options : [  {
                        type : '0', //[1]
                        name : 'accy',
                        value : q_getId()[4]
					},{//1
						type : '1',//[2][3]
						name : 'date'
					},{//2
						type : '6',//[4]
						name : 'Mon'
					},{//3
						type : '2', //[5][6]
						name : 'carno',
						dbf : 'car2',
						index : 'carno,driverno',
						src : 'car2_b.aspx'
					},{//4
						type : '2', //[7][8]
						name : 'Driver',
						dbf : 'driver',
						index : 'noa,namea',
						src : 'driver_b.aspx'
					},{
                        type : '8',//[9]
                        name : 'xshow',
                        value : '1@已派車'.split(',')
                    },{
                        type : '8',//[10]
                        name : 'xenda',
                        value : '1@已完工'.split(',')
                    },{
                        type : '6',//[11]
                        name : 'xnoa',
                    },{//[12]
						type : '5', 
						name : 'xtype',
						value:'#non@全部,029-001@北區,029-002@中區,029-003@南區,029-004@移倉'.split(',')

					},{//[13][14]
						type : '1',
						name : 'date2'

					},{
                        type : '8',//[15]
                        name : 'xshowprice',
                        value : '1@顯示運費'.split(',')
                    }]
                    });
                q_popAssign();
				 $('#txtMon').mask('999/99');
	             $('#txtMon').datepicker();
                 $('#txtDate1').mask('999/99/99');
	             $('#txtDate1').datepicker();
	             $('#txtDate2').mask('999/99/99');
	             $('#txtDate2').datepicker();  
               
                var t_noa=typeof(q_getId()[5])=='undefined'?'':q_getId()[5];
                t_noa  =  t_noa.replace('noa=','');
                $('#txtNoa1').val(t_noa);
                $('#txtNoa2').val(t_noa);
                    var t_date,t_year,t_month,t_day;
	                t_date = new Date();
	                t_date.setDate(1);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate1').val(t_year+'/'+t_month+'/'+t_day);
	                
	                t_date = new Date();
	                t_date.setDate(35);
	                t_date.setDate(0);
	                t_year = t_date.getUTCFullYear()-1911;
	                t_year = t_year>99?t_year+'':'0'+t_year;
	                t_month = t_date.getUTCMonth()+1;
	                t_month = t_month>9?t_month+'':'0'+t_month;
	                t_day = t_date.getUTCDate();
	                t_day = t_day>9?t_day+'':'0'+t_day;
	                $('#txtDate2').val(t_year+'/'+t_month+'/'+t_day);
			 }
	                

            function q_boxClose(s2) {
            }
            function q_gtPost(s2) {
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
    ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
    ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
    ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
       <div id="q_menu"></div>
       <div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
           <div id="container">
               <div id="q_report"></div>
           </div>
           <div class="prt" style="margin-left: -40px;">
               <!--#include file="../inc/print_ctrl.inc"-->
           </div>
       </div>
   </body>
</html>
           
          
