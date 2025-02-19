import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';


//应用程序包 之间的  数据共享
AppStorage.setOrCreate('myAppSaveName', '自定义鸿蒙原声音乐啦')

const TAG: string = '[EntryAbility]';
const DOMAIN_NUMBER: number = 0xFF00;

export default class EntryAbility extends UIAbility {
  windowStage: window.WindowStage | undefined = undefined

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    //UIAbility上下文环境
    console.log('ljz  ' + 'bundleName:' + this.context.abilityInfo.bundleName
      + '  moduleName:' + this.context.abilityInfo.moduleName
      + '  name:' + this.context.abilityInfo.name)

    //获取eventHub
    let eventHub = this.context.eventHub
    // 执行订阅操作
    eventHub.on('event1', this.eventFunc);
    eventHub.on('event1', (data: string) => {
      // 触发事件，完成相应的业务操作


    })

  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');

    this.context.eventHub.off('event1');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');


    // windowStage 创建是
    windowStage.loadContent('pages/Page_UIAbilityComponentsInteractive', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });

    //订阅windowStage事件
    try {
      this.windowStage = windowStage;
      windowStage.on('windowStageEvent', (data) => {
        let stageEventType: window.WindowStageEventType = data;
        switch (stageEventType) {
          case window.WindowStageEventType.SHOWN: // 切到前台
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage foreground.`);
            break;
          case window.WindowStageEventType.ACTIVE: // 获焦状态
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage active.`);
            break;
          case window.WindowStageEventType.INACTIVE: // 失焦状态
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage inactive.`);
            break;
          case window.WindowStageEventType.HIDDEN: // 切到后台
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage background.`);
            break;
          case window.WindowStageEventType.RESUMED: // 前台可交互状态
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage resumed.`);
            break;
          case window.WindowStageEventType.PAUSED: // 前台不可交互状态
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage paused.`);
            break;
          default:
            break;
        }
      })
    } catch (exception) {
      hilog.error(DOMAIN_NUMBER, TAG,
        `Failed to enable the listener for window stage event changes. Cause: ${JSON.stringify(exception)}`);

    }

  }

  //windowStage还没有销毁
  onWindowStageWillDestroy(windowStage: window.WindowStage): void {
    // 释放通过windowStage对象获取的资源
    // 在onWindowStageWillDestroy()中注销WindowStage事件订阅（获焦/失焦、切到前台/切到后台、前台可交互/前台不可交互）
    try {
      if (this.windowStage) {
        this.windowStage.off('windowStageEvent')
      }
    } catch (err) {
      let code = (err as BusinessError).code;
      let message = (err as BusinessError).message;
      hilog.error(DOMAIN_NUMBER, TAG,
        `Failed to disable the listener for windowStageEvent. Code is ${code}, message is ${message}`);
    }
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    // 申请系统需要的资源，或者重新申请在onBackground()中释放的资源
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    // 释放UI不可见时无用的资源，或者在此回调中执行较为耗时的操作
    // 例如状态保存等
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }


  onNewWant(want: Want, launchParam: AbilityConstant.LaunchParam): void {
  }

  eventFunc(argOne: Context, argTwo: Context): void {
    hilog.info(DOMAIN_NUMBER, TAG, '1. ' + `${argOne}, ${argTwo}`);
    return;
  }
}