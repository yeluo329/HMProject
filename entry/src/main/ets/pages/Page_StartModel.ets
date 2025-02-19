import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';

const TAG: string = '[Page_StartModel]';
const DOMAIN_NUMBER: number = 0xFF00;


function getInstance(): string {
  return 'key';
}

@Entry
@Component
struct Page_StartModel {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
  private KEY_NEW = 'KEY';

  eventHubFunc(): void {
    // 不带参数触发自定义“event1”事件
    this.context.eventHub.emit('event1');
    // 带1个参数触发自定义“event1”事件
    this.context.eventHub.emit('event1', 1);
    // 带2个参数触发自定义“event1”事件
    this.context.eventHub.emit('event1', 2, 'test');
    // 开发者可以根据实际的业务场景设计事件传递的参数
  }

  build() {
    Row() {
      Column() {
        Button()
          .onClick(() => {
            this.eventHubFunc();
            promptAction.showToast({ message: 'EventHubFuncA' })
          })
      }
      .width('100%')
    }
    .height('100%')

  }
}