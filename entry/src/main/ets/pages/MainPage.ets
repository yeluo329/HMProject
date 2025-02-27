import { BusinessError } from '@kit.BasicServicesKit';
import { Contact } from '../viewmodel/Contact';
import { router } from '@kit.ArkUI';


async function myFunction(): Promise<string> {
  //同步
  const result: string = await new Promise((resolve: Function) => {
    setTimeout(() => {
      resolve('hello,world!')
    }, 1000);
  });
  console.info(result);
  return result;
}

@Entry
@Component
struct MainPage {
  promise: Promise<number> | null = null
  @State message: string = '点击';
  @State egLanes: LengthConstrain = { minLength: 200, maxLength: 300 }
  private contacts: Array<Contact> =
    [new Contact('小明', $r('app.media.sift')), new Contact('小红', $r('app.media.storage'))]

  aboutToAppear(): void {
    this.promise = new Promise((resolve: Function, reject: Function) => {
      setTimeout(() => {
        const randomNumber: number = Math.random()
        if (randomNumber > 0.5) {
          resolve(randomNumber)
        } else {
          reject(new Error('Random number is too small'));
        }
      }, 1000)
    });

    this.promise.then((result: number) => {
      console.info(`Random number is ${result}`);
    }).catch((error: BusinessError) => {
      console.error(error.message);
    })
  }

  build() {
    List({ space: 10 }) {
      ForEach(this.contacts, (item: Contact) => {
        ListItem() {
          Row() {
            Image(item.icon)
              .width(40)
              .height(40)
              .margin(10)
            Text(item.name).fontSize(20)
              .onClick(() => {
                router.pushUrl({ url: '' })
                  .then()
              })
          }.width('100%')
          .backgroundColor(Color.White)
          .borderRadius(10)
          .margin(10)
        }
      }, (item: Contact) => JSON.stringify(item))
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#FFF1F3F5')
    .alignListItem(ListItemAlign.Center)
    .listDirection(Axis.Vertical) //设置主轴方向
    .lanes(1)

  }
}

@Extend(ListItem)
function listItemStyle() {
  .backgroundColor(Color.White)
}