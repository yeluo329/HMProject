import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct LoginPage {
  @State message: string = 'Hello World';
  //账号
  @State account: string = ''
  @State password: string = ''
  @State isShowProgress: boolean = false;
  pathStack: NavPathStack = new NavPathStack();
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

  login(): void {
    if (this.account === '' || this.password === '') {
      promptAction.showToast({
        message: $r('app.string.input_empty_tips')
      })
    } else {
      this.isShowProgress = true;
      if (this.timeOutId === -1) {
        this.timeOutId = setTimeout(() => {
          this.isShowProgress = false;
          this.timeOutId = -1;
          this.pathStack.pushPathByName('LoadingPage', null);}, 0);
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
          .margin({
            top: '150vp',
            bottom: '8vp'
          })
        Text("登陆界面")
          .fontSize('24fp')
          .fontWeight(FontWeight.Medium)
          .fontColor('#182431')


        Text("登录账号以使用更多服务")
          .fontSize('16fp')
          .fontColor('#99182431')
          .margin({
            bottom: '30vp',
            top: '8vp'
          })

        TextInput({ placeholder: "账号" })
          .maxLength(11)
          .type(InputType.Number)
          .inputStyle()
          .onChange((value: string) => {
            this.account = value;
          })

        Line()
          .lineStyle()

        TextInput({ placeholder: '密码' })
          .maxLength(8)
          .type(InputType.Password)
          .inputStyle()
          .onChange((value: string) => {
            this.password = value;
          })
        Line()
          .lineStyle()


        Row() {
          Text('短信验证码登录')
            .blueTextStyle()
          Text('忘记密码')
            .blueTextStyle()
        }.justifyContent(FlexAlign.SpaceBetween)
        .width('100%')
        .padding({
          top: '8vp'
        , right: '16vp',
          left: '16vp'
        })


        Button($r('app.string.login'), { type: ButtonType.Capsule })
          .width('328vp')
          .height('40vp')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#007DFF')
          .margin({
            top: '48vp',
            bottom: '12vp'
          })
          .onClick(() => {
            this.login()
          })


        //注册账号
        Text($r('app.string.register_account'))
          .fontColor('#007DFF')
          .fontSize('16fp')
          .fontWeight(FontWeight.Medium)


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
