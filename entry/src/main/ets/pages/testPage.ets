@Preview({
  title: '1',
  deviceType:'phone'
})
@Component
struct Item {
  build() {
    Row() {
      Text('设置')
      Image($r('app.media.menu'))
    }

  }
}

@Entry
@Component
struct TestPage {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column() {

        Text(this.message)
          .id('TestPageHelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {

          })
      }.width('100%')
    }
    .height('100%')

  }
}

