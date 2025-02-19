import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction, window } from '@kit.ArkUI';
import { preferences, relationalStore } from '@kit.ArkData';
import { util } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';


let dataPreferences: preferences.Preferences | null = null

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    let options: preferences.Options = {
      name: 'myStore'
    }
    dataPreferences = preferences.getPreferencesSync(this.context, options);


    const STORE_CONFIG: relationalStore.StoreConfig = {
      name: 'ljz.db', // 数据库文件名
      securityLevel: relationalStore.SecurityLevel.S3, // 数据库安全级别,
      encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
      customDir: 'customDir/subCustomDir',
      isReadOnly: false // 可选参数，指定数据库是否以只读方式打开。该参数默认为false，
    }

    // 判断数据库版本，如果不匹配则需进行升降级操作
    // 假设当前数据库版本为3，表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, IDENTITY)
    const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS EMPLOYEE (ID INTEGER PRIMARY KEY AUTOINCREMENT, '
      + 'NAME TEXT NOT NULL, AGE INTEGER, SALARY REAL,'
      + ' CODES BLOB, IDENTITY UNLIMITED INT)'; // 建表Sql语句, IDENTITY为bigint类型，sql中指定类型为UNLIMITED INT

    relationalStore.getRdbStore(this.context, STORE_CONFIG, (err, store) => {
      if (err) {
        console.error(`Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info('Succeeded in getting RdbStore.');
      if (store.version === 0) {
        store.executeSql(SQL_CREATE_TABLE); // 创建数据表
        // 设置数据库的版本，入参为大于0的整数
        store.version = 3;
      }

      // 如果数据库版本不为0且和当前数据库版本不匹配，需要进行升降级操作
      // 当数据库存在并假定版本为1时，例应用从某一版本升级到当前版本，数据库需要从1版本升级到2版本
      if (store.version === 1) {
        // version = 1：表结构：EMPLOYEE (NAME, SALARY, CODES, ADDRESS) => version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS)
        (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE ADD COLUMN AGE INTEGER');
        store.version = 2;
      }

      // 当数据库存在并假定版本为2时，例应用从某一版本升级到当前版本，数据库需要从2版本升级到3版本
      if (store.version === 2) {
        // version = 2：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES, ADDRESS) => version = 3：表结构：EMPLOYEE (NAME, AGE, SALARY, CODES)
        (store as relationalStore.RdbStore).executeSql('ALTER TABLE EMPLOYEE DROP COLUMN ADDRESS TEXT');
        store.version = 3;
      }

    });

    // if (dataPreferences.hasSync('startup')) {
    //   console.info("The key 'startup' is contained.");
    // } else {
    //   console.info("The key 'startup' does not contain.");
    //   dataPreferences.putSync('startup', 'auto');
    //   dataPreferences.flush((err: BusinessError) => {
    //     if (err) {
    //       console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
    //       return;
    //     }
    //     console.info('Succeeded in flushing.');
    //   })
    //
    //   console.info('The value' + dataPreferences.getSync('startup', 'default'));
    //
    //   dataPreferences.deleteSync('startup');
    // }
    //
    // let uInt8Array1 = new util.TextEncoder().encodeInto("~！@#￥%……&*（）——+？");
    // dataPreferences.putSync('uInt8', uInt8Array1);

    windowStage.loadContent('pages/MainPage', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy():
    void {
    // Main window is destroyed, release UI related resources
    hilog
      .info
      (
        0x0000,
        'testTag',
        '%{public}s',
        'Ability onWindowStageDestroy'
      )
    ;
  }

  onForeground():
    void {
    // Ability has brought to foreground
    hilog
      .info
      (
        0x0000,
        'testTag',
        '%{public}s',
        'Ability onForeground'
      )
    ;
  }

  onBackground():
    void {
    // Ability has back to background
    hilog
      .info
      (
        0x0000,
        'testTag',
        '%{public}s',
        'Ability onBackground'
      )
    ;
  }
}