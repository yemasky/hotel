<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class RoomsAttributeAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> navigation = 'roomsManagement';
        $objResponse -> setTplValue('navigation', 'roomsManagement');
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'edit':
                $this->doEdit($objRequest, $objResponse);
                break;
            case 'add':
                $this->doAdd($objRequest, $objResponse);
                break;
            case 'delete':
                $this->doDelete($objRequest, $objResponse);
                break;
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        $room_type = $objRequest->room_type;
        $room_type = empty($room_type) ? 'room' : $room_type;
        $arrayRoomAttribute = RoomService::instance()->getAttribute($objResponse->arrayLoginEmployeeInfo['hotel_id'], $room_type);

        //赋值
        $objResponse -> arrayAttribute = $arrayRoomAttribute;
        $objResponse -> add_room_attribute_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['add']), 'room_id'=>$objRequest->room_id));
        $objResponse -> arayRoomType = ModulesConfig::$modulesConfig['roomsSetting']['room_type'];
        //设置类别
        $objResponse -> room_type = $room_type;
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doAdd($objRequest, $objResponse) {
        //$this->doEdit($objRequest, $objResponse);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {

        $objResponse -> add_room_attribute_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['edit']), 'room_id'=>$objRequest->room_id));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();

    }

}