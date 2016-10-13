<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class HotelAttributeAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> navigation = 'hotelSetting';
        $objResponse -> setTplValue('navigation', 'hotelSetting');
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
        $arrayHotelAttribute = HotelService::instance()->getAttribute($objResponse->arrayLoginEmployeeInfo['hotel_id']);
        //赋值
        sort($arrayHotelAttribute, SORT_NUMERIC);
        //
        $objResponse -> arrayAttribute = $arrayHotelAttribute;
        $objResponse -> add_hotel_attribute_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['add'])));
        $objResponse -> delete_hotel_attribute_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['delete'])));
        //设置类别
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function doAdd($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        //设置Meta(共通)
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {
        $this->setDisplay();
        $hotel_attribute_id = decode($objRequest -> hotel_attribute_id);
        $arrayPostValue= $objRequest->getPost();

        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            $arrayPostValue['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
            unset($arrayPostValue['hotel_attribute_id']);
            if($hotel_attribute_id > 0) {
                $arrayPostValue['hotel_attribute_father_id'] = $hotel_attribute_id;
            }
            $attribute_id = HotelService::instance()->saveHotelAttr($arrayPostValue);
            if($objRequest -> hotel_attribute_id == '0') {
                HotelService::instance()->updateHotelAttr(array('hotel_attribute_id'=>$attribute_id), array('hotel_attribute_father_id'=>$attribute_id));
            }
            return $this->successResponse('保存客房属性成功');
            //$room_layout_attribute_id = HotelService::instance()->saveRoom($arrayPostValue);

        }
        return $this->errorResponse('没有保存任何客房属性');
        //$objResponse -> add_room_attribute_url =
        //    \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['edit'])));
        //设置Meta(共通)
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
        $arrayPostValue= $objRequest->getPost();
        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            foreach($arrayPostValue as $attrId => $attrVal) {
                if(!empty($attrVal) && decode($attrId) > 0) {
                    HotelService::instance()->updateHotelAttr(array('hotel_attribute_id'=>decode($attrId), 
                        'hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']), array('hotel_attribute_name'=>$attrVal));
                } else if(empty($attrVal) && decode($attrId) > 0) {
                    HotelService::instance()->deleteRoomLayoutAttr(array('hotel_attribute_id'=>decode($attrId), 'hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']));
                }
            }
            return $this->successResponse('修改成功！');
        }
        return $this->errorResponse('修改失败，请检查！');
    }

}