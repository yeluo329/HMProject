import { AppUtil } from '../util/AppUtil';
import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State message: string = '欢迎使用APP';

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }.width('100%')
    }
    .height('100%')
    .backgroundColor(AppUtil.bgColor)
    .onClick(() => {
      router.pushUrl({
        url: 'pages/MainPage',
        params: {
          userInfo: '雷晶湛',
          age: 25
        }
      })
    })

  }
}