@Preview
@Component
export struct Button1 {
  num: string = '1'
  textColor: number = Color.White
  buttonColor: number = 0x333333
  textSize: number = 40
  buttonWidth: number = 75

  build() {
    Column() {
      Text(`${this.num}`)
        .fontColor(this.textColor)
        .fontSize(this.textSize)
        .fontWeight(FontWeight.Bold)
    }
    .width(this.buttonWidth)
    .height(75)
    .backgroundColor(this.buttonColor)
    .justifyContent(FlexAlign.Center)
    .borderRadius(50)

  }
}