<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class RoomsLayoutAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> navigation = 'roomsManagement';
        $objResponse -> setTplValue('navigation', 'roomsManagement');
        $objResponse -> back_lis_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['view'])));
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
        $arrayRoomAttribute = RoomService::getAttribute($objResponse->arrayLoginEmployeeInfo['hotel_id'], $room_type);

        //赋值
        $objResponse -> arrayAttribute = $arrayRoomAttribute;
        $objResponse -> add_room_layout_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['add']), 'room_id'=>$objRequest->room_id));
        $objResponse -> arayRoomType = ModulesConfig::$modulesConfig['roomsSetting']['room_type'];
        //设置类别
        $objResponse -> room_type = $room_type;
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doAdd($objRequest, $objResponse) {
        $room_layout_id = decode($objRequest -> room_layout_id);
        if(!empty($room_layout_id)) {
            throw new \Exception('系统异常！');
        }
        $this->doEdit($objRequest, $objResponse);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {
        $room_layout_id = decode($objRequest -> room_layout_id);
        $arrayPostValue= $objRequest->getPost();

        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            if ($room_layout_id > 0) {
                RoomService::updateRoomLayout(array('room_layout_id' => $room_layout_id), $arrayPostValue);
            } else {
                $arrayPostValue['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                $arrayPostValue['room_layout_add_date'] = date("Y-m-d");
                $arrayPostValue['room_layout_add_time'] = getTime();
                $room_id = RoomService::saveRoomLayout($arrayPostValue);
            }
            $redirect_url =
                \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['view']), 'room_layout_id'=>encode($room_layout_id)));
            $this->setDisplay();
            return $this->successResponse('保存售卖房型成功', array('room_layout_id'=>$room_layout_id), $redirect_url);
        }

        $conditions = DbConfig::$db_query_conditions;
        if(empty($room_layout_id)) {
            $conditions['where'] = array('room_layout_id'=>0);
        } else {
            $conditions['where'] = array('room_layout_id'=>$room_layout_id, 'hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
        }
        $arrayRoomLayout = RoomService::getRoomLayout($conditions);
        //赋值
        $objResponse -> arrayAttribute = RoomService::getAttribute($objResponse->arrayLoginEmployeeInfo['hotel_id'], 'room');
        $objResponse -> arrayDataInfo = $arrayRoomLayout[0];
        $objResponse -> add_room_layout_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['edit']), 'room_id'=>$objRequest->room_id));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();

    }

}