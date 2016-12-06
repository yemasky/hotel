<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class DepartmentAction extends \BaseAction {
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
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        $arrayDepartment = HotelService::instance()->getHotelDepartment($conditions);
        //
        $objResponse -> arrayDepartment = $arrayDepartment;
        $objResponse -> add_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['add'])));
        $objResponse -> delete_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['delete'])));
        $objResponse -> arayRoomType = ModulesConfig::$modulesConfig['roomsSetting']['room_type'];
        //设置类别
    }

    protected function doAdd($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {
        $this->setDisplay();
        $room_layout_attribute_id = decode($objRequest -> room_layout_attribute_id);
        $arrayPostValue= $objRequest->getPost();

        if(!empty($arrayPostValue) && is_array($arrayPostValue) && $objRequest -> room_layout_attribute_id != '') {
            $arrayPostValue['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
            unset($arrayPostValue['room_layout_attribute_id']);
            if($room_layout_attribute_id > 0) {
                $arrayPostValue['room_layout_attribute_father_id'] = $room_layout_attribute_id;
            }
            $arrayPostValue['room_type'] = 'room';
            $attribute_id = RoomService::instance()->saveRoomLayoutAttr($arrayPostValue);
            if($objRequest -> room_layout_attribute_id == '0') {
                RoomService::instance()->updateRoomLayoutAttr(array('room_layout_attribute_id'=>$attribute_id), array('room_layout_attribute_father_id'=>$attribute_id));
            }
            return $this->successResponse('保存客房属性成功');
            //$room_layout_attribute_id = RoomService::instance()->saveRoom($arrayPostValue);

        }
        return $this->errorResponse('没有保存任何客房属性');
        //$objResponse -> add_room_attribute_url =
        //    \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['edit'])));
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();

    }

}