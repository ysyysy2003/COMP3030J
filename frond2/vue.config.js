const path = require('path')
const { port, title } = require('./project-setting')

const resolve = (...args) => path.resolve(__dirname, ...args)

module.exports = {
  devServer: {
    port: port || 6688,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Request-Method': 'GET, POST, PUT, DELETE, PATCH',
      'Access-Control-Request-Headers': '*',
    },
    hot:true,
    cors: true,
    open: true,
    // host : "0.0.0.0",
    proxy: {
      '/api': {
        target: 'http://127.0.0.1:8000/',   //代理接口
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/api/, '')
      }
    }
  },

  configureWebpack: {
    name: title,
  },

  chainWebpack(config) {
    config.module
      .rule('svg')
      // vue-cli配置了svg解析规则，让该规则对src/assets/icons目录不起作用
      .exclude
      .add(resolve('src/assets/icons'))
      .end()

    config.module.rule('md')
      .test(/\.md/)
      .use('vue-loader')
      .loader('vue-loader')
      .end()
      .use('vue-markdown-loader')
      .loader('vue-markdown-loader/lib/markdown-compiler')
      .options({
        raw: true
      })

    // 配置svg生成icon的规则
    config.module
      .rule('icons')
      .test(/\.svg$/)
      .include
      .add(resolve('src/assets/icons'))
      .end()
      .use('svg-sprite-loader')
      .loader('svg-sprite-loader')
      .options({
        symbolId: 'icon-[name]',
      })
      .end()

    config.plugin('html')
      .tap(args => {
        args[0].title = title
        return args
      })
  },
}
