import axios from 'axios'

const success = res => res

const error = err => {
        return Promise.reject(err)
    }


axios.interceptors.response.use(success, error)

axios.defaults.headers.common = {
    "Content-Type": "application/json"
  }
  