import { http } from '@kit.NetworkKit'


// 每一个httpRequest对应一个HTTP请求任务，不可复用
let httpRequest = http.createHttp();


// 用于订阅HTTP响应头事件
httpRequest.on('headersReceive', (header: object) => {
  console.info('header: ' + JSON.stringify(header));
})


// 用于订阅HTTP流式响应数据接收事件
let res = new ArrayBuffer(0);


let streamInfo: http.HttpRequestOptions = {
  method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
  // 开发者根据自身业务需要添加header字段
  // header: {
  //   'Content-Type': 'application/json'
  // },

  usingCache: true, // 可选，默认为true
  priority: 1, // 可选，默认为1
  connectTimeout: 60000, // 可选，默认为60000ms
  readTimeout: 60000, // 可选，默认为60000ms。若传输的数据较大，需要较长的时间，建议增大该参数以保证数据传输正常终止
  usingProtocol: http.HttpProtocol.HTTP1_1 // 可选，协议类型默认值由系统自动指定
}


// 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
httpRequest.requestInStream("EXAMPLE_URL", streamInfo).then((data: number) => {
  console.info("requestInStream OK!");
  console.info('ResponseCode :' + JSON.stringify(data));

  // 当该请求使用完毕时，调用destroy方法主动销毁
  httpRequest.destroy();
}).catch((err: Error) => {
  console.info("requestInStream ERROR : err = " + JSON.stringify(err));
});