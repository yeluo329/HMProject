import { router } from '@kit.ArkUI';
import { it } from '@ohos/hypium';
import { ItemAction } from '../ui/ItemAction';
import { JSON } from '@kit.ArkTS';

const params = router.getParams() as Record<string, string>

@Entry
@Component
struct MainPage {
  @State tasks: string[] = []

  aboutToAppear(): void {
    this.tasks = ['打架', '睡觉', '健身', '吃饭']
  }

  build() {
    Row() {
      Column() {
        Text(`欢迎${params?.['userInfo']}`)
          .fontSize(25)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.tasks[4] = '哈哈'
          })

        Divider()

        //这个可以显示
        // ForEach(this.tasks, (item: string) => {
        //   ItemAction({ value: item })
        // }, (item: string, index: number) => index + '_' + JSON.stringify(item))


        ForEach(this.tasks, (item: string) => {
          ItemAction({ value: item })
        }, (item: string, index: number) => {
          console.log('ljz:' + JSON.stringify(item) + 'index:' + index)
          return JSON.stringify(item) + index
        })
      }
      .width('100%')
    }
    .height('100%')
    .onClick(() => {
      router.back()
    })

  }
}