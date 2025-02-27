import { webview } from '@kit.ArkWeb';
import CommonConstants from '../common/constants/CommonConstants';
import httpGet from '../utils/HttpUtil';
import { http } from '@kit.NetworkKit';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct WebPage {
  controller: webview.WebviewController = new webview.WebviewController();
  @State buttonName: string = '请求';
  @State webVisibility: Visibility = Visibility.Hidden;
  @State webSrc: string = CommonConstants.SERVER;

  build() {
    Column() {
      Row() {
        Image($r('app.media.ic_network_global'))
          .height(30)
          .width(30)

        TextInput({ placeholder: '请输入网址', text: this.webSrc })
          .height(40)
          .layoutWeight(1)
          .backgroundColor(Color.White)
          .onChange((value: string) => {
            this.webSrc = value;
          })


      }
      .margin({ top: 12, left: 12, right: 12 })
      .height(56)
      .borderRadius(28)
      .backgroundColor(Color.White)
      .padding({
        left: 12,
        right: 12
      })

      Row() {
        Web({ src: this.webSrc, controller: this.controller })
          .zoomAccess(true)
          .height('100%')
          .width('100%')
      }
      .visibility(this.webVisibility)
      .width('100%')
      .height('83%')
      .align(Alignment.Top)


      Row() {
        Button(this.buttonName)
          .fontSize(16)
          .width('90%')
          .height(40)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.onRequest();
          })
      }
      .height(56)
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r('app.media.ic_background_image', ImageRepeat.NoRepeat))
    .backgroundImageSize(ImageSize.Cover)
  }

  async onRequest() {
    if (this.webVisibility === Visibility.Hidden) {
      this.webVisibility = Visibility.Visible
      try {
        let result = await httpGet(this.webSrc)
        if (result && result.responseCode === http.ResponseCode.OK) {
          this.controller.clearHistory();
          this.controller.loadUrl(this.webSrc);
        }
      } catch (error) {
        promptAction.showToast({ message: "请求出错，请检查是否有网络" })
      }
    } else {
      this.webVisibility = Visibility.Hidden;
    }
  }
}