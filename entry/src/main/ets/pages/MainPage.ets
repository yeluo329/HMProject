@Entry
@Component
struct MainPage {
  pathStack: NavPathStack = new NavPathStack();

  aboutToAppear(): void {

  }

  build() {
    Navigation(this.pathStack) {
      Column() {
        Image($r('app.media.logo'))
      }
    }
    .backgroundColor('#F1F3F5')
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideToolBar(true)

  }
}