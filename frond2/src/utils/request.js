import axios from 'axios'
import store from '../store'
axios.defaults.baseURL = '/api' // 此路径为配置代理服务器时的代理路径
const service = axios.create({
  // process.env.NODE_ENV === 'development' 来判断是否开发环境
  // easy-mock服务挂了，暂时不使用了
  baseURL: '/api',
  timeout: 5000
})
service.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'
// request interceptor
service.interceptors.request.use(
  config => {
    // do something before request is sent
    console.log(store.state.token)
    if (store.getters.token) {
      // let each request carry token
      // ['X-Token'] is a custom headers key
      // please modify it according to the actual situation
      config.headers['Authorization'] = store.state.token // 这里的X-Token改为token 前后端协商
    }
    return config
  },
  error => {
    return Promise.reject(error)
  }
)

export default {
  get (url, data, responseType) { // url: 接口；路径；data: 请求参数；responseType：相应的数据类型，不传默认为json
    return new Promise((resolve, reject) => {
      axios({
        method: 'get',
        url,
        data,
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json; charset=utf-8',
          withCredentials: true
        },
        // 默认json格式，如果是下载文件，需要传 responseType:'blob'
        responseType: (responseType == null || responseType === '') ? 'json' : responseType
      }).then(response => {
        if (response.status === 200) {
          // 根据实际情况进行更改
          resolve(response)
        } else {
          reject(response)
        }
      }).catch((error) => {
        reject(error)
      })
    })
  },

  post (url, data, responseType) { // url: 接口；路径；data: 请求参数；responseType：相应的数据类型，不传默认为json
    return new Promise((resolve, reject) => {
      axios({
        method: 'post',
        url,
        data,
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json; charset=utf-8',
          withCredentials: true
        },
        // 默认json格式，如果是下载文件，需要传 responseType:'blob'
        responseType: (responseType == null || responseType === '') ? 'json' : responseType
      }).then(response => {
        if (response.status === 201 || response.status === 200) {
          // 根据实际情况进行更改
          resolve(response)
        } else {
          reject(response)
        }
      }).catch((error) => {
        reject(error)
      })
    })
  },

  patch (url, data, responseType) { // url: 接口；路径；data: 请求参数；responseType：相应的数据类型，不传默认为json
    return new Promise((resolve, reject) => {
      axios({
        method: 'patch',
        url,
        data,
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json; charset=utf-8',
          withCredentials: true
        },
        // 默认json格式，如果是下载文件，需要传 responseType:'blob'
        responseType: (responseType == null || responseType === '') ? 'json' : responseType
      }).then(response => {
        if (response.status === 200) {
          // 根据实际情况进行更改
          resolve(response)
        } else {
          reject(response)
        }
      }).catch((error) => {
        reject(error)
      })
    })
  },

  put (url, data, responseType) { // url: 接口；路径；data: 请求参数；responseType：相应的数据类型，不传默认为json
    return new Promise((resolve, reject) => {
      axios({
        method: 'put',
        url,
        data,
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json; charset=utf-8',
          withCredentials: true
        },
        // 默认json格式，如果是下载文件，需要传 responseType:'blob'
        responseType: (responseType == null || responseType === '') ? 'json' : responseType
      }).then(response => {
        if (response.status === 200) {
          // 根据实际情况进行更改
          resolve(response)
        } else {
          reject(response)
        }
      }).catch((error) => {
        reject(error)
      })
    })
  },

  delete (url, data, responseType) { // url: 接口；路径；data: 请求参数；responseType：相应的数据类型，不传默认为json
    return new Promise((resolve, reject) => {
      axios({
        method: 'delete',
        url,
        data,
        headers: {
          Accept: 'application/json',
          'Content-Type': 'application/json; charset=utf-8',
          withCredentials: true
        },
        // 默认json格式，如果是下载文件，需要传 responseType:'blob'
        responseType: (responseType == null || responseType === '') ? 'json' : responseType
      }).then(response => {
        if (response.status === 204) {
          // 根据实际情况进行更改
          resolve(response)
        } else {
          reject(response)
        }
      }).catch((error) => {
        reject(error)
      })
    })
  }
}
