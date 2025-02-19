import { common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG: string = '[ljz:Page_FromStageModel]';
const DOMAIN_NUMBER: number = 0xFF00;

@Entry
@Component
struct Page_FromStageModel {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Button('FuncAbilityB')
        .onClick(() => {
          let context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext; // UIAbilityContext
          // context为需要停止的UIAbility实例的AbilityContext
          const RESULT_CODE: number = 1001;
          let abilityResult: common.AbilityResult = {
            resultCode: RESULT_CODE,
            want: {
              bundleName: 'com.example.testproject',
              moduleName: 'entry', // moduleName非必选
              abilityName: 'FuncAbility',
              parameters: {
                info: '来自FuncAbility Index页面'
              },
            },
          };
          context.terminateSelfWithResult(abilityResult, (err) => {
            if (err.code) {
              hilog.error(DOMAIN_NUMBER, TAG,
                `Failed to terminate self. Code is ${err.code}, message is ${err.message}`);
              return;
            }
          });
        })
    }
  }
}