import { router } from '@kit.ArkUI';
import { preferences, ValueType } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

const params = router.getParams() as Record<string, string>

@Entry
@Component
struct MainPage {
  dataPreferences: preferences.Preferences | null = null
  message: string = ''

  aboutToAppear(): void {
    let options: preferences.Options = { name: 'myStore' }
    this.dataPreferences = preferences.getPreferencesSync(getContext(this), options)
    // this.dataPreferences.putSync('startup', '雷晶湛');
    this.message = this.dataPreferences.getSync('startup', 'default') as string;

    preferences.deletePreferences(getContext(this), options, (err: BusinessError) => {
      if (err) {
        console.error(`Failed to delete preferences. Code:${err.code}, message:${err.message}`);
        return;
      }
      console.info('Succeeded in deleting preferences.');
    })
    // this.dataPreferences.on('change', (key: string) => {
    //   console.info('The key ' + key + ' changed.');
    // })
    //
    // this.dataPreferences.put('startup', 'manual', (err: BusinessError) => {
    //   if (err) {
    //     console.error(`Failed to put the value of 'startup'. Code:${err.code},message:${err.message}`);
    //     return;
    //   }
    //
    //   console.info("Succeeded in putting the value of 'startup'.");
    //   if (this.dataPreferences !== null) {
    //     this.dataPreferences.flush((err: BusinessError) => {
    //       if (err) {
    //         console.error(`Failed to flush. Code:${err.code}, message:${err.message}`);
    //         return;
    //       }
    //       console.info('Succeeded in flushing.');
    //     })
    //   }
    // })

  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(40)


      }.width('100%')
    }
    .height('100%')
  }
}