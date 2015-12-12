<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ include file="/include/topFile.jsp" %>
<!DOCTYPE html>
<html>
<head><title>加工人员</title>
    <script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
    <!-- bootstrap css 引入 -->
	<link href="../../js/plugin/bootstrap/css/bootstrap.css" media="all" rel="stylesheet" type="text/css" />
	<!-- bootstrap Datatables样式引入 -->
	<link rel="stylesheet" href="../../js/datatablesExtends/dataTables.bootstrap.css" type="text/css"></link>
	<!-- jquery ui css 引入 -->
	<link rel="stylesheet" href="../../js/plugin/jquery-easyui-1.4.3/themes/bootstrap/easyui.css" type="text/css"></link>
	<!-- jquery-ui的JS -->
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../../js/plugin/jquery-easyui-1.4.3/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
	
	function initSbzd(){
		
		$.ajax({
            type: "post",
            url: "pcgl_getJgSbInfo.action",
            dataType: "json",
            success: function (dt) {

                for (var i = 0; i < dt.length; i++) {
                    var html = "<option value=" + dt[i].id + ">" + dt[i].sbmc + "</option>";
                    $("#jgsb").append(html);
                }

            }
        });
	}
	var gygcid = "";
	function tableInit(){
		
		var table = $('#pcglJgryJg').DataTable( {
		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
		"bLengthChange": false, 
      	"oLanguage": {
                    "sProcessing": "正在加载中......",
                    "sLengthMenu": "每页显示 _MENU_ 条记录",
                    "sZeroRecords": "对不起，查询不到相关数据！",
                    "sEmptyTable": "表中无数据存在！",
                    "sInfo": "当前显示 _START_ 到 _END_ 条，共 _TOTAL_ 条记录",
                    "sInfoFiltered": "数据表中共为 _MAX_ 条记录",
                    "sSearch": "搜索",
                    "oPaginate": {
                        "sFirst": "首页",
                        "sPrevious": "上一页",
                        "sNext": "下一页",
                        "sLast": "末页"
                    }
                },
        "aLengthMenu":[15,30],
		"ajax":"pcgl_getBomGygcJg.action",
		scrollY:        "300px",
		scrollX:        false,
		scrollCollapse: false,
		paging:         true,
		"columnDefs": [ 
            {
                "render": function ( data, type, row ) {
                    return '<div class="text-center"><a href="#" onclick="jgryJgks('+"\'"+data+"\'"+')">开始</a>&nbsp&nbsp;<a href="#" onclick="jgryJgJs('+"\'"+data+"\'"+')">结束</a></div>';
                },
                "targets": 1
            },
            { "visible": true,  "targets": [ 2 ] }
        ],
        "columns": [
             {"data": null,"sWidth": "60px"}, 
             {"data": 'id',"sWidth": "200px"}, 
             {"data": "zddmc", "sWidth": "120px"}, 
             {"data": "bmcl","sWidth": "600px"},
             {"data": "jhkssj"},
             {"data": "jhjssj","sWidth": "120px"}, 
             {"data": "gs", "sWidth": "120px"},
             {"data": "gymc", "sWidth": "120px"},
             {"data": "kjgjs", "sWidth": "120px"},
             {"data": "yjgjs", "sWidth": "120px"},
             {"data": "bfjs", "sWidth": "120px"},
             {"data": "djgjs", "sWidth": "120px"},
             {"data": "sjjs", "sWidth": "120px"}
        ]
       
	} );
	
	  /**加上序号**/
	  table.on( 'order.dt search.dt', function () {
        table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
            cell.innerHTML = i+1;
        } );
   	  } ).draw();
	}
	
	
	function jgryJgJs(data){
		
		$('#dlg').dialog('open');
		gygcid = data;
	}
	
	function saveSj(){
		
		
		var jgsb = $('#jgsb').val();
		var jgjs = $('#jgjs').val();
		
		$.ajax({
            type: "post",
            url: "pcgl_jgryJs.action",
            dataType: "text",
            data: {
                "gygcid": gygcid,
                "wcjs":jgjs,
                "sbid":jgsb
                
            },
            success: function (dt) {
	              	
            	$('#dlg').dialog('close');
            	$('#pcglJgryJg').DataTable().ajax.reload(function(){},true);
            }
        });
	}
	function jgryJgks(data){
		
		
		$.ajax({
            type: "post",
            url: "pcgl_jgryKs.action",
            dataType: "text",
            data: {
                "gygcid": data
                
            },
            success: function (dt) {

				if(dt=='success'){
				
					alert('加工开始成功,已开始计时');
				}else{
				
					alert("对不起发生错误，请联系管理员！");
				}
	              	
            }
        });
	}
	$(document).ready(function() {
	
		tableInit();
		initSbzd();
	} );
	
	</script>
</head>
<body>
<div class='container container-wrapper'>
    <div class='row' id='content-wrapper'>
        <div class='row rowTop'>
            <div class='box bordered-box ' style='margin-bottom: 0;'>
                <div class='box-header'>
                    <div class='title'>加工</div>
                    <div class='actions'><a class="btn box-remove btn-xs btn-link" href="#"><i class='icon-remove'></i>
                    </a> <a class="btn box-collapse btn-xs btn-link" href="#"><i></i> </a></div>
                </div>
                <div class='box-content box-no-padding'>
                    <div class='responsive-table'>
                        <div class='scrollable-area'>
                            <table id="pcglJgryJg" class='table table-striped table-bordered tableGrid cell-border'
                                   style='margin-bottom: 0;'>
                                <thead>
                                <tr>
                                    <th> 序号</th>
                                    <th> 操作</th>
                                    <th> 子订单</th>
                                    <th> 表面处理</th>
                                    <th> 计划开始时间</th>
                                    <th> 计划完成时间</th>
                                    <th> 额定工时</th>
                                    <th> 工艺名称</th>
                                    <th> 加工件数</th>
                                    <th> 已检件数</th>
                                    <th> 报废件数</th>
                                    <th> 待加工件数</th>
                                    <th> 送检件数</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="dlg" class="easyui-dialog" title="检验" style="width:400px;height:200px;padding:10px"
			data-options="toolbar: '#dlg-toolbar',buttons: '#dlg-buttons',closed:true">
		
	</div>
	<div id="dlg-toolbar" style="padding:10px">
		
		<span style="margin-left:40px;margin-top:40px;">完成件数：</span><input id="jgjs" width="120px"></input>
		<p style="margin-top:15px;">
		<span style="margin-left:40px;margin-top:40px;">所用设备：</span><select style="height:28px;width:175px;" id='jgsb'></select>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveSj()">送检</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#dlg').dialog('close')">取消</a>
	</div>
</div>
</body>
</html>
