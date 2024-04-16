import vibrator from '@ohos.vibrator';
class RouterInfo{
  id:string;
  title:string;
  defaultIcon:string;
  activeIcon:string;

  constructor(id,title,defaultIcon,activeIcon) {
    this.id = id;
    this.title = title;
    this.defaultIcon = defaultIcon;
    this.activeIcon = activeIcon
  }
}

@Entry
@Component
struct Index {

  routersInfo:RouterInfo[] = [
    new RouterInfo('particulars','明细',$r('app.media.index_particulars_icon'),$r('app.media.index_particulars_active_icon')),
    new RouterInfo('diagram','图表',$r('app.media.index_diagram_icon'),$r('app.media.index_diagram_active_icon')),
    new RouterInfo('add_account','记账',$r('app.media.index_add_account_icon'),''),
    new RouterInfo('discover','发现',$r('app.media.index_discovery_icon'),$r('app.media.index_discovery_active_icon')),
    new RouterInfo('my','我的',$r('app.media.index_my_icon'),$r('app.media.index_my_active_icon'))
  ]
  @State activeRouterInfoId: string = this.routersInfo[0].id

  // 页面点击处理
  onClickItemHandle(id:string){
    if(id === 'add_account'){
       //   待处理
    }else this.activeRouterInfoId = id

    try {
      vibrator.startVibration({
        type: 'time',
        duration: 100,
      }, {
        id: 0,
        usage: 'alarm'
      }, (error) => {
        if (error) {
          console.error('vibrate fail, error.code: ' + error.code + 'error.message: ', + error.message);
          return;
        }
        console.log('Callback returned to indicate a successful vibration.');
      });
    } catch (err) {
      console.error('errCode: ' + err.code + ' ,msg: ' + err.message);
    }
  }

  build() {
    Column(){
      Row(){}.layoutWeight(1)
      Row(){
        ForEach(this.routersInfo,(routerInfo:RouterInfo)=>{
          Column({space:5}){
            if(routerInfo.id === 'add_account'){
              Row().width(60).height(40)
              Row().width(60).height(60).backgroundImage(routerInfo.defaultIcon).backgroundImageSize(ImageSize.Contain).position({y:-32}).borderRadius(30).zIndex(1)
            } else Row().width(40).height(40).backgroundImage(this.activeRouterInfoId === routerInfo.id?routerInfo.activeIcon:routerInfo.defaultIcon).backgroundImageSize(ImageSize.Contain)
            Text(routerInfo.title)
          }.alignItems(HorizontalAlign.Center).onClick(()=> this.onClickItemHandle(routerInfo.id))
        })
      }.width('100%').height(75).justifyContent(FlexAlign.SpaceEvenly).border({
        width:{top:1},
        color:'#ccc'
      })
    }.width('100%').height('100%')

  }
}