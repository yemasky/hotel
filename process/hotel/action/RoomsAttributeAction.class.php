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
        $objResponse -> add_room_attribute_url = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesRoomsAttribute['add']), 'room_id'=>$objRequest->room_id));
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
        if(decode($objRequest->room_id) > 0) {
            $this->view($objRequest, $objResponse);
            return;
        }

        $arrayRoomAttribute = RoomService::getAttribute($objResponse->arrayLoginEmployeeInfo['hotel_id']);

        //赋值
        $objResponse -> arrayAttribute = $arrayRoomAttribute;
        //设置类别

        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

   protected function view($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        $objResponse->view = 1;
        $objResponse->setTplName("hotel/modules_roomsSetting_add");
    }

    protected function doAdd($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {
        $room_id = decode($objRequest -> room_id);
        $arrayPostValue= $objRequest->getPost();

        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            if ($room_id > 0) {
                RoomService::updateRoom(array('room_id' => $room_id), $arrayPostValue);
            } else {
                $arrayPostValue['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                $arrayPostValue['room_add_date'] = date("Y-m-d");
                $arrayPostValue['room_add_time'] = getTime();
                $room_id = RoomService::saveRoom($arrayPostValue);
            }
            $redirect_url = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesRoomsSetting['view']), 'room_id'=>encode($room_id)));
            $this->setDisplay();
            return $this->successResponse('保存酒店房间成功', '', $redirect_url);
        }

        $conditions = DbConfig::$db_query_conditions;
        if(empty($room_id)) {
            $conditions['where'] = array('room_id'=>0);
        } else {
            $conditions['where'] = array('room_id'=>$room_id, 'hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
        }
        $arrayRoom = RoomService::getRoom($conditions);
        sort($arrayRoom);
        $objResponse -> arrayDataInfo = $arrayRoom[0][0];
        $objResponse -> arayRoomType = ModulesConfig::$modulesRoomsSetting['room_type'];
        $objResponse->view = 0;
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
        $room_id = decode($objRequest->room_id);
        if(empty($room_id)) {
            return $this->errorResponse('操作失败，酒店ID不正确！');
        }
        RoomService::updateHotel(array('room_id'=>$room_id), array('room_status'=>'-1'));
        return $this->successResponse('删除酒店成功');
    }

}