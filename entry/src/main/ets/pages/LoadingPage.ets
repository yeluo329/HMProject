@Entry
@Component
struct LoadingPage {
  @State simpleList: Array<number> = [1, 2, 3, 4, 5];

  build() {
    Row() {
      Column() {
        ForEach(this.simpleList, (item: number) => {
          LoadingItem().margin({ top: 20 })
        })
      }.width('100%')
    }
    .height('100%')

  }
}

@Builder
function textArea(width: number | Resource | string = '100%', height: number | Resource | string = '100%') {
  Row()
    .width(width)
    .height(height)
    .backgroundColor('#FFF2F3F4')
}

@Component
struct LoadingItem {
  build() {
    Row() {
      Column() {
        textArea(80, 80)
      }.margin({ right: 20 })

      Column() {
        textArea('60%', 20)
        textArea('50%', 20)
      }.alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.SpaceAround)
      .height('100%')

    }
    .padding(20)
    .borderRadius(12)
    .backgroundColor('#FFECECEC')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}