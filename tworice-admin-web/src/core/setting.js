function Setting(){
      this.systemName='二饭快速开发框架';                                    // 系统名称
      this.systemTitle='二饭快速开发框架';                                   // 系统全局标题
      this.formLabelWidth="80px";
      this.needLogin=true;                                             // 是否需要登录才能访问系统
      this.defaultTab='';                                    // 默认选中的Tab 请填写路由路径
      this.baseURL = process.env.VUE_APP_API_BASE_URL;
      this.loading = false;
      this.uploadAgent = process.env.VUE_APP_UPLOAD_AGENT;
      this.uploadHeader={
            token: window.localStorage.getItem("token"),
            adminID: JSON.parse(window.localStorage.getItem("admin")).id,
      }
}
export default new Setting();
