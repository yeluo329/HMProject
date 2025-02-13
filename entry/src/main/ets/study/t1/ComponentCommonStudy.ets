@Entry
@Component
struct ComponentCommonStudy {
  @State message: string = 'Hello World';
  //点击事件
  // build() {
  //   Column() {
  //     Row() {
  //       Button('按钮1', { type: ButtonType.Normal })
  //         .width(66)
  //         .height(40)
  //         .onClick((event: ClickEvent) => {
  //           //screenX 得到点击的x和y的值 绝对未知      event.target.area.width 按钮的宽高
  //           this.message = `屏幕x:${event.screenX} \n屏幕Y:${event.screenY}\n按钮X:${event.x}\n按钮Y:${event.y}` +
  //             `\n宽度:${event.target.area.width}\n高度:${event.target.area.height}`
  //         })
  //     }
  //
  //     Text(this.message)
  //       .fontSize(22)
  //       .fontWeight(FontWeight.Bold)
  //   }
  //   .width('100%')
  //   .alignItems(HorizontalAlign.Start)
  //   .padding({ top: 30, left: 30 })


  @State eventType: string = ''

  //触摸事件
  build() {
    Column() {
      Row() {
        Button('触摸按钮', { type: ButtonType.Normal })
          .width(100)
          .height(40)
          .onTouch((event: TouchEvent) => {
            if (event.type == TouchType.Down) {
              this.eventType = '按下-Down'
            }

            if (event.type == TouchType.Up) {
              this.eventType = '抬起-Up'
            }

            if (event.type == TouchType.Move) {
              this.eventType = '触摸中-Move'
            }

            //x和y相对于按钮的位置 相对位置
            this.message = '触摸的类型:' + this.eventType + '\n'
              + 'x:' + event.touches[0].x + '\n'
              + 'y:' + event.touches[0].y + '\n'
              + '宽度:' + event.target.area.width + '\n'
              + '高度:' + event.target.area.height
          })
      }

      Text(this.message)
        .fontSize(22)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding({ top: 30, left: 30 })

  }
}