import { ExpressionEvaluator } from '../help/CalculateHelper';
import { Button1 } from './Button1';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct WelcomePage {
  @State result: string = '0'
  @State loveModel: boolean = false
  @State cal: string = '' //计算时的信息

  openLoveModel(): void {
    promptAction.showDialog({
      title: '爱情模式已开启',
      message: '亲爱的,你已经开启爱情模式',
      buttons: [
        {
          text: '我知道了',
          color: '#FF13E70C'
        },
        {
          text: '关闭爱情模式',
          color: '#F00'
        }]
    }, (err, data) => {
      if (err) {
        promptAction.showToast({ message: '发生了错误:', duration: 6000 })
      }

      if (data.index == 1) {
        this.loveModel = false
        promptAction.showToast({ message: '爱情模式被关闭', duration: 6000 })
      }
    })
  }

  closeLoveModel(): void {
    promptAction.showDialog({
      title: '爱情模式关闭',
      message: '亲爱的,你已经关闭爱情模式',
      buttons: [
        {
          text: '我知道了',
          color: '#FF13E70C'
        },
        {
          text: '开启爱情模式',
          color: '#F00'
        }]
    }, (err, data) => {
      if (err) {
        promptAction.showToast({ message: '发生了错误:', duration: 6000 })
      }

      if (data.index == 1) {
        this.loveModel = true
        promptAction.showToast({ message: '爱情模式被开启', duration: 6000 })
      }
    })
  }

  build() {
    Column({ space: 10 }) {
      if (this.result == '5201314') {
        Image('images/love1.gif')
          .width('100%')
          .height(200)
      }
      Blank() //自动化 把空隙撑开

      //计算的结果
      Column() {
        Text(this.result)
          .fontColor(Color.White)
          .fontSize(this.loveModel ? 70 : 60)
      }
      .width('100%')
      .alignItems(HorizontalAlign.End)
      .padding({ right: 36 })

      //计算的细节
      Column() {
        Text(this.cal)
          .fontColor(Color.White)
      }
      .width('100%')
      .alignItems(HorizontalAlign.End)
      .padding({ right: 36 })

      ///TODO AC
      Row({ space: 10 }) {
        Button1({
          num: 'AC',
          buttonColor: 0xA5A5A5,
          textColor: Color.Black,
          textSize: 30
        }).onClick(() => {
          this.result = '0';
          this.cal = '';
        })
        Button1({
          num: '+/-',
          buttonColor: 0xA5A5A5,
          textColor: Color.Black,
          textSize: 30
        }).onClick(() => {
          // 开启爱情模式
          this.loveModel = !this.loveModel // 取反 之前是false 现在就变成true
          if (this.loveModel) {
            this.openLoveModel()
          } else {
            this.closeLoveModel()
          }

        })
        Button1({
          num: '%',
          buttonColor: 0xA5A5A5,
          textColor: Color.Black,
          textSize: 30
        })
        Button1({
          num: '÷',
          buttonColor: 0xFF9F0B,
        }).onClick(() => {
          this.cal += '÷'
        })
      }

      ///TODO 789
      Row({ space: 10 }) {
        Button1({
          num: '7'
        }).onClick(() => {
          this.cal += '7'
        })
        Button1({
          num: '8'
        }).onClick(() => {
          this.cal += '8'
        })
        Button1({
          num: '9'
        }).onClick(() => {
          this.cal += '9'
        })
        Button1({
          num: 'x',
          buttonColor: 0xFF9F0B,
        }).onClick(() => {
          this.cal += '*'
        })
      }

      ///TODO 4 5 6
      Row({ space: 10 }) {
        Button1({
          num: '4'
        }).onClick(() => {
          this.cal += '4'
        })
        Button1({
          num: '5'
        }).onClick(() => {
          this.cal += '5'
        })
        Button1({
          num: '6'
        }).onClick(() => {
          this.cal += '6'
        })
        Button1({
          num: '-',
          buttonColor: 0xFF9F0B,
        }).onClick(() => {

          if (this.cal.length > 0 &&
            this.cal[this.cal.length - 1] >= '0' && this.cal[this.cal.length - 1] <= '9') {
            this.cal += '-'
          } else {
            promptAction.showToast({ message: '不能输入负数', duration: 6000 })
          }
        })
      }


      // TODO 1 2 3 ...
      Row({ space: 10 }) {
        Button1({
          num: '1'
        }).onClick(() => {
          this.cal += '1'
        })

        Button1({
          num: '2',
        }).onClick(() => {
          this.cal += '2'
        })

        Button1({
          num: '3',
        }).onClick(() => {
          this.cal += '3'
        })

        Button1({
          num: '+',
          buttonColor: 0xFF9F0B,
        }).onClick(() => {
          this.cal += '+'
        })
      }

      // TODO 0 . =  ...
      Row({ space: 10 }) {
        Button1({
          num: '0'
        , buttonWidth: 160
        }).onClick(() => {
          this.cal += '0'
        })

        Button1({
          num: '.',
        }).onClick(() => {
          this.cal += '.'
        })

        Button1({
          num: '=',
          buttonColor: 0xFF9F0B,
        }).onClick(() => {
          let calHelp = new ExpressionEvaluator()
          let tempResult = `${calHelp.evaluate(this.cal)}`
          if (this.loveModel && tempResult.length === 8) {
            this.result = '5201314'
          } else {
            this.result = tempResult
          }



        })
      }

    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.Black)
    .padding({ bottom: 10 })

  }
}