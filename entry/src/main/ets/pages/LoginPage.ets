import { promptAction } from '@kit.ArkUI';


async function test(): Promise<boolean> {
  const result: boolean = await new Promise((resolve: Function, reject: Function) => {
    setTimeout(() => {
      resolve(true)
    }, 1000)
  });
  return result;
}

@Entry
@Component
struct LoginPage {
  @State message: string = 'Hello World';
  @State account: string = '';
  @State password: string = '';
  @State isShowProgress: boolean = false;
  pathStack: NavPathStack = new NavPathStack()
  private timeOutId: number = -1;

  @Builder
  imageButton(src: Resource) {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(src)
    }
    .height('48vp')
    .width('48vp')
    .backgroundColor('#F1F3F5')
  }

  login(result: boolean): void {
    if (this.account === '' || this.password === '') {
      promptAction.showToast({
        message: $r('app.string.input_empty_tips')
      });
    } else {
      this.isShowProgress = true
      if (this.timeOutId === -1) {
        this.timeOutId = setTimeout(async () => {
          this.isShowProgress = false;
          this.timeOutId = -1;
          if (result) {
            this.pathStack.pushPathByName('MainPage', null);
          } else {

            promptAction.showToast({
              message: $r('app.string.Network_Lost')
            });
          }
        }, 1000)
      }

    }
  }

  aboutToDisappear() {
    clearTimeout(this.timeOutId);
    this.timeOutId = -1;

  }

  build() {
    Navigation(this.pathStack) {
      Column() {
        Image($r('app.media.logo'))
          .width('78vp')
          .height('78vp')
          .margin({ top: '150vp', bottom: '8vp' })

        Text($r('app.string.login_page'))
          .fontSize('24fp')
          .fontWeight(FontWeight.Medium)
          .fontColor('#182431')

        Text($r('app.string.login_more'))
          .fontSize('16fp')
          .fontColor('#99182431')
          .margin({
            bottom: '30vp',
            top: '8vp'
          })

        TextInput({ placeholder: $r('app.string.account') })
          .maxLength(11)
          .type(InputType.Number)
          .inputStyle()
          .onChange((value: string) => {
            this.account = value;
          })
        Line().lineStyle()

        TextInput({ placeholder: $r('app.string.password') })
          .maxLength(8)
          .type(InputType.Password)
          .inputStyle()
          .onChange((value: string) => {
            this.password = value;
          })
        Line().lineStyle()


        Row() {
          Text($r('app.string.message_login'))
            .blueTextStyle()
          Text($r('app.string.forgot_password'))
            .blueTextStyle()
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width('328vp')
        .margin({ top: '8vp' })


        Button($r('app.string.login'), { type: ButtonType.Capsule })
          .width('328vp')
          .height('40vp')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)
          .backgroundColor($r('app.color.login_button_color'))
          .margin({
            top: '48vp',
            bottom: '12vp'
          })
          .onClick(async () => {
            // await ConnectionUtils.isNetworkConnected().then((value) => {
            //   this.login(value)
            // })
          })


        Text($r('app.string.register_account'))
          .fontColor('#007DFF')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)
          .onClick(() => {
            promptAction.showToast({ message: '功能未完成' })
          })


        if (this.isShowProgress) {
          LoadingProgress()
            .color('#182431')
            .width('30vp')
            .height('30vp')
            .margin({ top: '20vp' })
        }

        Blank()

        Text($r('app.string.other_login_method'))
          .fontColor('#838D97')
          .fontSize('12fp')
          .fontWeight(FontWeight.Medium)
          .margin({
            top: '50vp',
            bottom: '12vp'
          })


        Row({ space: 44 }) {
          this.imageButton($r('app.media.login_method1'))
          this.imageButton($r('app.media.login_method2'))
          this.imageButton($r('app.media.login_method3'))
        }
        .margin({ bottom: '16vp' })

      }
      .height('100%')
      .width('100%')
      .padding({
        left: '12vp',
        right: '12vp',
        bottom: '24vp'
      })
    }
    .backgroundColor('#F1F3F5')
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideToolBar(true)

  }
}


@Extend(TextInput)
function inputStyle() {
  .placeholderColor('#99182431')
  .height('45vp')
  .fontSize('18fp')
  .backgroundColor('#F1F3F5')
  .width('328vp')
  .margin({ top: 12 })
}


@Extend(Line)
function lineStyle() {
  .width('328vp')
  .height('1vp')
  .backgroundColor('#33182431')
}


@Extend(Text)
function blueTextStyle() {
  .fontColor('#007DFF')
  .fontSize('14fp')
  .fontWeight(FontWeight.Medium)
}
