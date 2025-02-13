@Component
export struct ItemAction {
  @State isOk: boolean = false
  value?: string

  build() {
    Row({ space: 20 }) {
      Image(this.isOk ? $r('app.media.startIcon') : $r('app.media.foreground'))
        .ImageStyle()

      Text(this.value)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .opacity(this.isOk ? 0.5 : 1.0)
    }
    .rowStyle()
    .onClick(() => {
      this.isOk = !this.isOk
    })
  }
}

@Extend(Image)
function ImageStyle() {
  .width(30)
  .height(30)
  .objectFit(ImageFit.Contain)
  .margin(20)
}

@Extend(Row)
function rowStyle() {
  .width('90%')
  .height(40)
  .backgroundColor(Color.Brown)
  .margin(20)
  .borderRadius(15)
}