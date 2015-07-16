package com.project.scgl.action;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.logging.Log;

import com.project.base.service.SelectDataService;
import com.project.commonModel.util.Request;
import com.project.commonModel.util.Response;
import com.project.util.JsonObjectUtil;
import com.project.xsgl.action.XsglAction;
public class SbglAction {

	private static Log log = org.apache.commons.logging.LogFactory.getLog(XsglAction.class);
	private SelectDataService selectDataService;
	public SelectDataService getSelectDataService() {
		return selectDataService;
	}
	public void setSelectDataService(SelectDataService selectDataService) {
		this.selectDataService = selectDataService;
	}
	
	/**
	 * 获取设备列表
	 */
	public void getSbTableData(){
		String sql = "select sb.id,sblx.mc sblx,sbmc, cast(cgsj as char) cgsj, cast(bxjssj as char) bxjssj,sbszd,sbzt.mc sbzt,wxjl,remark from scglxt_t_sb sb,scglxt_tyzd sblx,scglxt_tyzd sbzt where sbzt.id = dqzt and sblx.id = sblx";
		log.info("设备信息查询sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		json = "{\"data\":"+json+"}";
		
		Response.write(json);
	}
	
	/**
	 * 添加设备
	 */
	public String addSbInfo(){
		
		String sbid = RandomStringUtils.randomNumeric(20);
		String sblx = Request.getParameter("sblx");
		String sbmc = Request.getParameter("sbmc");
		String sbcgsj = Request.getParameter("cgsj");
		String sbbxjssj = Request.getParameter("wbjz");
		String sbszd = Request.getParameter("cfdd");
		String sbzt = Request.getParameter("sbzt");
		String sbwxjl = Request.getParameter("wxjl");
		String sbremark = Request.getParameter("bz");
		String sql = "insert into scglxt_t_sb (id,sblx,sbmc,cgsj,bxjssj,sbszd,dqzt,wxjl,remark) values ('"+sbid+"'" +
				",'"+sblx+"','"+sbmc+"','"+sbcgsj+"','"+sbbxjssj+"','"+sbszd+"','"+sbzt+"','"+sbwxjl+"','"+sbremark+"')";
		log.info("设备信息添加sql"+sql);
		
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "sbsuccess";
		}else{
			
			return "sbfault";
		}
	}
	
	/**
	 * 添加设备
	 */
	public String updateSbInfo(){
		
		String sbid = Request.getParameter("id");
		String sblx = Request.getParameter("sblx");
		String sbmc = Request.getParameter("sbmc");
		String sbcgsj = Request.getParameter("cgsj");
		String sbbxjssj = Request.getParameter("wbjz");
		String sbszd = Request.getParameter("cfdd");
		String sbzt = Request.getParameter("sbzt");
		String sbwxjl = Request.getParameter("wxjl");
		String sbremark = Request.getParameter("bz");
		String sql = "update scglxt_t_sb set sblx='"+sblx+"',sbmc='"+sbmc+"',cgsj = "+sbcgsj+",bxjssj='"+sbbxjssj+"'" +
				"sbszd = '"+sbszd+"',sbzt = '"+sbzt+"','"+sbwxjl+"',remark = '"+sbremark+"' where id = '"+sbid+"'";
		
		log.info("设备信息更新sql"+sql);
		int i = this.selectDataService.update(sql);
		
		if(i>0){
			
			return "sbsuccess";
		}else{
			
			return "sbfault";
		}
	}
	
	/**
	 * 删除设备
	 */
	public String deleteSbInfo(){
		
		String sbid = Request.getParameter("id");
		String sql = "delete from scglxt_t_sb  where id = '"+sbid+"'";
		
		log.info("删除设备信息sql"+sql);
		int i = this.selectDataService.update(sql);
		if(i>0){
			
			return "sbsuccess";
		}else{
			
			return "sbfault";
		}
	}
	
	/**
	 * 删除设备
	 */
	public void getSbZdInfo(){
		
		String xh = Request.getParameter("xh");
		String sbid = "";
		String sql = "select id ,mc from scglxt_tyzd where xh like  '"+xh+"__%'";
		
		log.info("查询设备字典数据sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
	
	/**
	 * 删除设备
	 */
	public void getSbInfoById(){
		
		String id = Request.getParameter("id");
		String sbid = "";
		String sql = "select sb.id, sblx,sbmc, cast(cgsj as char) cgsj, cast(bxjssj as char) bxjssj,sbszd,dqzt sbzt,wxjl,remark bz from scglxt_t_sb sb where id = '"+id+"'";
		
		log.info("查询设备字典数据sql"+sql);
		List list = this.selectDataService.queryForList(sql);
		String json = JsonObjectUtil.list2Json(list);
		Response.write(json);
	}
}