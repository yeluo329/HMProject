import { webview } from '@kit.ArkWeb';
import { promptAction } from '@kit.ArkUI';

class linkClass {
  messageFromHtml(value: string) {
    AlertDialog.show({
      message: '恭喜你中奖:' + value
    , confirm: {
        value: '确认',
        action: () => {
        }
      }
    })
  }

  haha() {
    promptAction.showToast({ message: 'haha', duration: 6000 })
  }
}

@Entry
@Component
struct TestWebPage {
  webController: webview.WebviewController = new webview.WebviewController();
  @State linkClass: linkClass = new linkClass();
  @State message: string = 'Hello World';

  build() {
    Stack() {
      Image($r('app.media.background'))
        .width('100%')
        .height('40%')

      Column() {
        Web({ src: $rawfile('local/index.html'), controller: this.webController })
          .aspectRatio(1)
          .zoomAccess(false)
          .width('93.3%')
          .javaScriptAccess(true)//运行js脚本
          .javaScriptProxy({
            object: this.linkClass,
            name: 'linkObj',
            methodList: ['haha', 'messageFromHtml'],
            controller: this.webController
          })
          .margin({ top: 80 })



        Button('开始抽奖')
          .margin({ top: 10 })
          .onClick(() => {
            this.webController.runJavaScript('startDraw()')
          })


      }

    }
  }
}