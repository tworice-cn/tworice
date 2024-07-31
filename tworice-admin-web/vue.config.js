module.exports={
      productionSourceMap: false,
      publicPath:'./',
      devServer:{
            proxy:{
                  '/api/api/': {
                        target: process.env.VUE_APP_API_BASE_URL,
                        changeOrigin: true,
                        pathRewrite: {
                              '^/api/api/': ''
                        }
                  },
                  '/api/': {
                        target: process.env.VUE_APP_API_BASE_URL,
                        changeOrigin: true,
                        pathRewrite: {
                              '^/api/': ''
                        }
                  }
            }
      }
      // chainWebpack: config => {  // 查看打包结构
      //       config
      //        .plugin('webpack-bundle-analyzer')
      //        .use(require('webpack-bundle-analyzer').BundleAnalyzerPlugin)
      //      }
}