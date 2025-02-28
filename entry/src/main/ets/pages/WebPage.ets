import { webview } from '@kit.ArkWeb';
import { CommonConstant as Const } from '../common/Constant'
import { promptAction, router } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';

class LinkClass {
  messageFromHtml(value: string) {
    AlertDialog.show({
      message: '恭喜您抽中:' + value,
      confirm: {
        value: '确定', action: () => {

        }
      },
      cancel: () => {

      }
    })
  }

  haha() {
    promptAction.showToast({ message: 'ljz', duration: 6000 })
  }
}

const TITLE: string = '以上为HTML页面';

@Entry
@Component
struct WebPage {
  webController: webview.WebviewController = new webview.WebviewController()
  @State linkObj: LinkClass = new LinkClass();
  @State params: object = router.getParams();
  @State progressVal: number = 0;
  @State isLoading: boolean = true;
  @State intervalLoading: number = -1;

  aboutToAppear(): void {
    this.intervalLoading = setInterval(() => {
      this.progressVal = this.progressVal >= 100 ? 0 : (this.progressVal + 10)
    }, 100)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {

      Image($r('app.media.background'))
        .width('100%')
        .height('38.7%')

      Row() {
        Column() {
          Row() {
            Image($rawfile('local/img/ic_public_back.png'))
              .width('5.6%')
              .height('32%')
              .margin({ left: '7.2%' })
              .onClick(() => {
                promptAction.showToast({ message: '点击' })
                // router.back();
              })
            Text('抽奖应用')
              .fontSize(20)
              .width('82.2%')
              .height('50%')
              .fontColor('#000000')
              .margin({ left: '5%' })

          }.height('7.2%')

          // Web component loading H5.
          Web({ src: $rawfile('local/index.html'), controller: this.webController })
            .zoomAccess(false)
            .width('93.3%')
            .aspectRatio(1)
            .onErrorReceive((event) => {
              if (event?.error.getErrorInfo() === 'ERR_INTERNET_DISCONNECTED') {
                promptAction.showToast({
                  message: '网络加载失败',
                  duration: Const.WEB_CONSTANT_DURATION
                });
              }
            })
            .onProgressChange((event) => {
              if (event?.newProgress === Const.WEB_CONSTANT_PROGRESS_MAX) {
                this.isLoading = false;
                clearInterval(this.intervalLoading);
                this.intervalLoading = -1;
              }
            })
            .javaScriptProxy({
              object: this.linkObj,
              name: 'linkObj',
              methodList: ['messageFromHtml', 'haha'],
              controller: this.webController
            })


          Column() {
            Text(TITLE)
              .fontSize(Const.WEB_CONSTANT_TEXT_VALUE_FONT_SIZE)
              .textAlign(TextAlign.Center)
              .fontColor("#182431")
              .height(Const.WEB_CONSTANT_TEXT_VALUE_HEIGHT)
              .fontWeight(Const.WEB_CONSTANT_TEXT_VALUE_FONT_WEIGHT)
              .margin({ top: Const.WEB_CONSTANT_TEXT_VALUE_MARGIN_TOP })


            Text('本地')
              .fontSize(Const.WEB_CONSTANT_TIP_TEXT_VALUE_FONT_SIZE)
              .textAlign(TextAlign.Center)
              .fontColor('#182431')
              .width(Const.WEB_CONSTANT_TIP_TEXT_VALUE_WIDTH)
              .height(Const.WEB_CONSTANT_TIP_TEXT_VALUE_HEIGHT)
              .opacity(Const.WEB_CONSTANT_TIP_TEXT_VALUE_OPACITY)
              .margin({ top: Const.WEB_CONSTANT_TIP_TEXT_VALUE_MARGIN_TOP })
          }

          Button('点击抽奖')
            .fontSize(Const.WEB_CONSTANT_BUTTON_FONT_SIZE)
            .fontColor($r('app.color.start_window_background'))
            .margin({ top: Const.WEB_CONSTANT_BUTTON_MARGIN_TOP })
            .width(Const.WEB_CONSTANT_BUTTON_WIDTH)
            .height(Const.WEB_CONSTANT_BUTTON_HEIGHT)
            .backgroundColor($r('app.color.blue'))
            .borderRadius(Const.WEB_CONSTANT_BUTTON_BORDER_RADIUS)
            .onClick(() => {
              //调用js函数
              this.webController.runJavaScript('startDraw()');

            })
        }
        .width(Const.WEB_CONSTANT_FULL_WIDTH)
        .height(Const.WEB_CONSTANT_FULL_HEIGHT)


      }
    }

  }
}