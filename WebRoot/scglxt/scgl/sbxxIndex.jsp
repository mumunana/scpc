<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include/topFile.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<script type="text/javascript" src="../../js/plugin/datatables/dataTables.fixedColumns.js"></script>
	</head>
	<script type="text/javascript">

	function deleteRow(id){
		
		//判断是否要删除
		//删除数据库成功后删除表格
		//1、删除数据库
		$.ajax({
		  type: "post",
		  url: "xsgl_deleteRyInfo.action",
		  dataType: "text",
		  data:{
		  	"id":id,
		  },
		  success:function(dt){
		  	alert(dt);
		  	window.location.reload(); 
		  	$("#sorting-advanced").dataTable().fnPageChange( 'previous', true );
		  }
		}); 
		
		//2、删除表格
	}
	
	function tableInit(){
	
		var table = $('#ryxx').DataTable( 
	    {
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
        aLengthMenu:[15,30],
		ajax:"scglsb_getSbTableData.action",
		scrollY:        "380px",
		scrollX:        true,
		scrollCollapse: false,
		paging:         true,
		columnDefs: [ 
            {
                "render": function ( data, type, row ) {
                	
                	return '<div class="text-center">'+
                    '<a class="btn btn-info btn-xs"  title="编辑"  href="${pageContext.request.contextPath}/scglxt/scgl/addSbInfo.jsp?flag=edit&id='+data+'"><i class="icon-edit" ></i></a>'+
                    '&nbsp; <a class="btn btn-danger btn-xs" title="删除" href="${pageContext.request.contextPath}/scglxt/scgl/scglsb_deleteSbInfo.action?id='+data+'"><i class="icon-remove"></i></a></div>';
                },
                "targets": 1
            },
            { "visible": true,  "targets": [ 2 ] }
        ],
        columns: [
        	{"data":null,"sWidth":"40px"},
        	{"data":'id',"sWidth":"80px"},
        	 { "data": "sbbz","sWidth":"120px"},
            { "data": "sblx","sWidth":"120px"},
            { "data": "sbmc" ,"sWidth":"120px"},
            { "data": "sbzt" ,"sWidth":"60px"},
            { "data": "sbszd" ,"sWidth":"120px"},
            { "data": "cgsj" ,"sWidth":"120px"},
            { "data": "bxjssj" ,"sWidth":"120px"},
            { "data": "wxjl" ,"sWidth":"120px"},
            { "data": "remark" ,"sWidth":"120px"}
        ]
       
	} );
	
	  /**加上序号**/
	  table.on( 'order.dt search.dt', function () {
        table.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
            cell.innerHTML = i+1;
        } );
   	  } ).draw();
	  new $.fn.dataTable.FixedColumns( table, {leftColumns:3});
	}
	
	/***
		初始化表格
	**/
	$(document).ready(function() {
	
		tableInit()
	} );
</script>

	<body>
		<div id='wrapper'>
			<div class='container'>
				<div class='row' id='content-wrapper'>
					<div class='col-xs-12'>
						<div class='row rowTop'>
							<div class='col-sm-12'>
								<div class='box bordered-box orange-border'
									style='margin-bottom: 0;'>
									<div class='box-header'>
										 
										<button id="form_add" class="btn btn-success btn-sm">
										<a href="${pageContext.request.contextPath}/scglxt/scgl/addSbInfo.jsp"><i class="icon-add"></i> 增加</a>
											
										</button>									
										<div class='title'>
											设备信息
										</div>
										<div class='actions'>
											<a class="btn box-remove btn-xs btn-link" href="#"><i
												class='icon-remove'></i> </a>

											<a class="btn box-collapse btn-xs btn-link" href="#"><i></i>
											</a>
										</div>
									</div>

									<div class='box-content box-no-padding'>
										<div class='responsive-table'>
											<div class='scrollable-area'>
												<table id="ryxx" class='table table-striped table-bordered' style='margin-bottom: 0;'>
													<thead>
														<tr>
															<th>
																序号
															</th>
															<th>
																操作
															</th>
															<th>
																班组
															</th>
															<th>
																类型
															</th>
															<th>
																名称
															</th>
															<th>
																状态
															</th>
															<th>
																存放地点
															</th>
															<th>
																采购时间
															</th>
															<th>
																维保时间
															</th>
															<th>
																维修记录
															</th>
															<th>
																备注
															</th>
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
				</div>
			</div>
		</div>
	</body>
</html>
