function Setting(){
      this.systemName='二饭快速开发框架';                                    // 系统名称
      this.systemTitle='二饭快速开发框架';                                   // 系统全局标题
      this.formLabelWidth="80px";
      this.needLogin=true;                                             // 是否需要登录才能访问系统
      this.defaultTab='';                                    // 默认选中的Tab 请填写路由路径
      this.baseURL='http://127.0.0.1:88/';
}

export default new Setting();
