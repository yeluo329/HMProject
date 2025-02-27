@Entry
@Component
struct TabPage {
  @State currentIndex: number = 0;

  @Builder
  tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }

    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {
      // TabContent() {
      //   Column() {
      //     Tabs() {
      //       TabContent() {
      //         Text('关注的内容')
      //       }.tabBar('关注')
      //
      //       TabContent() {
      //         Text('视频的内容')
      //       }.tabBar('视频')
      //
      //       TabContent() {
      //         Text('数码的内容')
      //       }.tabBar('数码')
      //
      //       TabContent() {
      //         Text('游戏的内容')
      //       }.tabBar('游戏')
      //
      //       TabContent() {
      //         Text('科技的内容')
      //       }.tabBar('科技')
      //     }
      //   }
      //   .backgroundColor('#ff08a8f1')
      //   .width('100%')
      // }.tabBar('首页')
      // .backgroundColor(Color.Yellow)

      TabContent() {
        TextArea({ placeholder: '请输入' })
          .onChange((event) => {
            console.info('ljz' + event)
          })
      }
      .tabBar(this.tabBuilder('推荐的内容', 0, $r('app.media.menu'), $r('app.media.news')))

      TabContent() {
        Text('推荐的内容').fontSize(30)
      }
      .tabBar('推荐')
      .backgroundColor(Color.Orange)

      TabContent() {
        Text('发现的内容').fontSize(30)
      }
      .tabBar('发现')
      .backgroundColor(Color.Red)

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .tabBar("我的")
      .backgroundColor(Color.Pink)

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .tabBar("我的")
      .backgroundColor(Color.Pink)

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .tabBar("我的")
      .backgroundColor(Color.Pink)

      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .tabBar("我的")
      .backgroundColor(Color.Pink)


      TabContent() {
        Text('我的内容').fontSize(30)
      }
      .tabBar("我的")
      .backgroundColor(Color.Pink)
    }
    .barMode(BarMode.Scrollable)


    // .barWidth(100)
    // .barHeight(300)

  }

  aboutToAppear(): void {
    this.doFunc()
  }

  doFunc() {
    let array: string = 'Who Love Solo';
    let wordArr = array.split(' ');
    let sumLength = 0;
    for (let i = 0; i < wordArr.length; i++) {
      sumLength += wordArr[i].length
    }

    console.log('ljz:' + `sumLength:${sumLength}wordArr:${wordArr.length}` +
    (sumLength / wordArr.length).toFixed(2));
  }
}

