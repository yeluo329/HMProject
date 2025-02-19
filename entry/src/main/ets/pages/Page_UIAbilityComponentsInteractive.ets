import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';

const TAG: string = '[ljz:Page_UIAbilityComponentsInteractive]';
const DOMAIN_NUMBER: number = 0xFF00;

@Entry
@Component
struct Page_UIAbilityComponentsInteractive {
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext
  @State message: string = 'Hello World';

  build() {
    Column() {
      Button('点击')
        .onClick(() => {
          let wantInfo: Want = {
            deviceId: '', // deviceId为空表示本设备
            bundleName: 'com.example.testproject',
            moduleName: 'entry', // moduleName非必选
            abilityName: 'FuncAbility',
            parameters: {
              // 自定义信息
              info: '来自EntryAbility Page_UIAbilityComponentsInteractive页面'
            }
          };
          this.context.startAbilityForResult(wantInfo).then((data) => {
            if (data?.resultCode === 1001) {
              let info = data.want?.parameters?.info;
              hilog.info(DOMAIN_NUMBER, TAG, JSON.stringify(info) ?? '');
              if (info !== null) {
                promptAction.showToast({ message: JSON.stringify(info), duration: 6000 });
              }
            }
            hilog.info(DOMAIN_NUMBER, TAG, JSON.stringify(data.resultCode) ?? '');

          }).catch((error: BusinessError) => {
            promptAction.showToast({ message: '跳转失败' })
            hilog.error(DOMAIN_NUMBER, TAG, 'startAbility failed.');
          });
        })


    }.width('100%')
  }
}