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
            case 'saveAttrValue':
                $this->doSaveAttrValue($objRequest, $objResponse);
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
        if(decode($objRequest->room_layout_id) > 0) {
            $this->view($objRequest, $objResponse);
            return;
        }

        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
        $conditions['order'] = 'room_layout_valid DESC';
        $arrayRoomLayout = RoomService::instance()->getRoomLayout($conditions);
        if(!empty($arrayRoomLayout)) {
            foreach ($arrayRoomLayout as $i => $v) {
                $arrayRoomLayout[$i]['view_url'] =
                    \BaseUrlUtil::Url(array('module'=>$objRequest->module, 'room_layout_id'=>encode($v['room_layout_id'])));
                $arrayRoomLayout[$i]['edit_url'] =
                    \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['edit']),
                        'room_layout_id'=>encode($v['room_layout_id'])));
                $arrayRoomLayout[$i]['delete_url'] =
                    \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['delete']),
                        'room_layout_id'=>encode($v['room_layout_id'])));
            }
        }
        //赋值
        $objResponse -> arrayDataInfo = $arrayRoomLayout;
        $objResponse -> add_room_layout_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['add'])));
        $objResponse -> arayRoomType = ModulesConfig::$modulesConfig['roomsSetting']['room_type'];
        //设置类别
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
    }

    protected function view($objRequest, $objResponse) {
        $this->doEdit($objRequest, $objResponse);
        $objResponse->view = 1;
        $objResponse->setTplName("hotel/modules_roomsLayout_add");
    }

    protected function doAdd($objRequest, $objResponse) {
        $room_layout_id = decode($objRequest -> room_layout_id);
        if(!empty($room_layout_id)) {
            throw new \Exception('系统异常！');
        }
        $this->doEdit($objRequest, $objResponse);
        //
        $objResponse -> add_room_layout_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['add'])));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {
        if($objRequest -> act == 'updateLayoutImages') {
            $url = $objRequest->url;
            $room_layout_id = decode($objRequest->room_layout_id);
            if(empty($room_layout_id)) return $this->errorResponse('错误的ID号，请检查');

            $conditions = DbConfig::$db_query_conditions;
            $this->setDisplay();
            $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                'room_layout_images_path'=>$url, 'room_layout_id'=>$room_layout_id);
            $arrayLayoutImage = RoomService::instance()->getRoomLayoutImages($conditions);
            if (!empty($arrayLayoutImage)) {
                return $this->errorResponse('此房型已经添加此图片');
            }
            $room_layout_images_id = RoomService::instance()->saveRoomLayoutImages(array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                'room_layout_images_path'=>$objRequest->url,
                'room_layout_id'=>$room_layout_id,
                'room_layout_images_filesize'=>0,
                'room_layout_images_add_date'=>getDay(),
                'room_layout_images_add_time'=>getTime()));
            return $this->successResponse('', array('room_layout_images_id'=>$room_layout_images_id));
        }

        $room_layout_id = decode($objRequest -> room_layout_id);
        $arrayPostValue= $objRequest->getPost();

        $conditions = DbConfig::$db_query_conditions;
        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            $this->setDisplay();
            $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                'room_layout_name'=>$arrayPostValue['room_layout_name']);
            $arrayRoomLayout = RoomService::getRoomLayout($conditions);
            if(!empty($arrayRoomLayout)) {
                if(empty($room_layout_id)) {
                    return $this->errorResponse('有重复的售卖房型名字，请检查！');
                } else {
                    if($arrayRoomLayout[0]['room_layout_id'] == $room_layout_id) {
                    } else {
                        return $this->errorResponse('有重复的售卖房型名字，请检查！');
                    }
                }
            }

            if ($room_layout_id > 0) {
                RoomService::updateRoomLayout(array('room_layout_id' => $room_layout_id), $arrayPostValue);
            } else {
                $arrayPostValue['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                $arrayPostValue['room_layout_add_date'] = date("Y-m-d");
                $arrayPostValue['room_layout_add_time'] = getTime();
                $room_layout_id = RoomService::saveRoomLayout($arrayPostValue);
            }
            $redirect_url =
                \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['edit']),
                    'room_layout_id'=>encode($room_layout_id)));
            return $this->successResponse('保存售卖房型成功', array('room_layout_id'=>encode($room_layout_id)), $redirect_url);
        }

        if(empty($room_layout_id)) {
            $conditions['where'] = array('room_layout_id'=>0);
        } else {
            $conditions['where'] = array('room_layout_id'=>$room_layout_id, 'hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
        }
        $arrayRoomLayout = RoomService::instance()->getRoomLayout($conditions);

        //房型图片
        $conditions['where'] = array('room_layout_id'=>$room_layout_id, 'hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
        $objResponse -> arrayDataImages = RoomService::instance()->getRoomLayoutImages($conditions);
        //属性
        $arrayAttribute = RoomService::instance()->getAttribute($objResponse->arrayLoginEmployeeInfo['hotel_id'], 'room');
        $arrayAttributeValue = RoomService::instance()->getRoomLayoutAttrValue($conditions, 'room_layout_attribute_id', true);
        //print_r($arrayAttribute);
        //print_r($arrayAttributeValue);
        if(!empty($arrayAttribute)) {
            foreach($arrayAttribute as $attrKey => $arrayChild) {
                foreach($arrayChild['childen'] as $i => $arrayAttr) {
                    $arrayAttribute[$attrKey]['childen'][$i]['values'] = array();
                    if(isset($arrayAttributeValue[$arrayAttr['room_layout_attribute_id']])) {
                        $arrayValues = $arrayAttributeValue[$arrayAttr['room_layout_attribute_id']];
                        foreach($arrayValues as $attr => $attrVal) {
                            $arrayAttribute[$attrKey]['childen'][$i]['values'][] = $attrVal;
                        }
                    }
                }
            }
        }
        sort($arrayAttribute, SORT_NUMERIC);
        //赋值
        $objResponse -> view = 0;
        $objResponse -> orientations = ModulesConfig::$modulesConfig['roomsLayout']['orientations'];
        $objResponse -> room_layout_id = encode($room_layout_id);
        $objResponse -> arrayAttribute = $arrayAttribute;
        $objResponse -> arrayDataInfo = $arrayRoomLayout[0];
        $objResponse -> add_room_layout_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['edit']),
                'room_layout_id'=>$objRequest->room_layout_id));
        $objResponse -> add_room_layout_attr_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsLayout']['saveAttrValue'])));
        $objResponse -> upload_images_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['upload']['uploadImages']),
                'upload_type'=>ModulesConfig::$modulesConfig['roomsLayout']['upload_type'],
                'room_layout_id'=>encode($room_layout_id)));
        $objResponse -> upload_manager_img_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['upload']['uploadImages']),
                'upload_type'=>ModulesConfig::$modulesConfig['roomsLayout']['upload_type'],
                'room_layout_id'=>encode($room_layout_id),'act'=>'manager_img'));
        $objResponse -> room_attribute_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomsAttribute']['view'])));
        //设置Meta(共通)
        $objResponse -> setTplValue("__Meta", \BaseCommon::getMeta('index', '管理后台', '管理后台', '管理后台'));
        $objResponse -> setTplName("hotel/modules_roomsLayout_add");
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();

    }

    protected function doSaveAttrValue($objRequest, $objResponse) {
        $this->setDisplay();
        $room_layout_id = decode($objRequest->room_layout_id);
        $arrayPostValue= $objRequest->getPost();
        if(!empty($arrayPostValue) && $room_layout_id > 0) {
            $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
            RoomService::instance()->deleteRoomLayoutAttrValue(array('room_layout_id'=>$room_layout_id,
                'hotel_id'=>$hotel_id));
            $arrayInsertValue = array();
            $i = 0;
            $arrarAttrHash = array();
            foreach ($arrayPostValue as $key => $val) {
                foreach ($val as $k => $v) {
                    if(empty($v)) continue;
                    foreach($v as $attr => $attrValue) {
                        if(empty($attrValue)) continue;
                        if(isset($arrarAttrHash[$k][$attrValue])) continue;//消除相同属性的属性值
                        $arrayInsertValue[$i]['hotel_id'] = $hotel_id;
                        $arrayInsertValue[$i]['room_layout_id'] = $room_layout_id;
                        $arrayInsertValue[$i]['room_layout_attribute_father_id'] = $key;
                        $arrayInsertValue[$i]['room_layout_attribute_id'] = $k;
                        $arrayInsertValue[$i]['room_layout_attribute_value'] = $attrValue;
                        //消除相同属性的属性值
                        $arrarAttrHash[$k][$attrValue] = 0;
                        $i++;
                    }

                }
            }
            if(!empty($arrayInsertValue)) {
                RoomService::instance()->batchSaveRoomLayoutAttrValue($arrayInsertValue);
                return $this->successResponse('保存房型及房型属性成功！');
            }
        }
        return $this->successResponse('保存房型成功！');
    }

}