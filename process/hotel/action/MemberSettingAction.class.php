<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class MemberSettingAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {

    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'add':
                $this->doAdd($objRequest, $objResponse);
                break;
            case 'edit':
                $this->doEdit($objRequest, $objResponse);
                break;
            case 'delete':
                $this->doDelete($objRequest, $objResponse);
                break;
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    protected function tryexecute($objRequest, $objResponse) {
        BookService::instance()->rollback();//事务回滚
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('IN'=>array('hotel_id'=>array(0, $objResponse->arrayLoginEmployeeInfo['hotel_id'])));
        $arrayBookType = BookService::instance()->getBookType($conditions, '*', 'book_type_id', true, 'book_type_father_id');
        // 折扣
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
        $conditions['order'] = 'book_type_id ASC';
        $arrayDiscount = BookService::instance()->getBookDiscount($conditions);
        $conditions['order'] = '';
        $arrayType = '';
        if(!empty($arrayDiscount)) {
            foreach($arrayBookType as $key => $BookType) {
                foreach($BookType['children'] as $j => $Type) {
                    $arrayType[$Type['book_type_id']] = $Type;
                }
            }
        }
        //print_r($arrayAccessorialService);
        //赋值
        //sort($arrayRoomAttribute, SORT_NUMERIC);
        //
        $objResponse -> arrayData = $arrayBookType;
        $objResponse -> memberType = ModulesConfig::$memberType;
        $objResponse -> arrayDiscount = $arrayDiscount;
        $objResponse -> arrayType = $arrayType;
        $objResponse -> add_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['memberSetting']['add'])));
        $objResponse -> edit_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['memberSetting']['edit'])));
        $objResponse -> delete_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['memberSetting']['delete'])));
        $objResponse -> searchBookInfoUrl =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['add'])));
        //设置类别
    }

    protected function doAdd($objRequest, $objResponse) {
        $objRequest -> book_type_id = 0;
        $objRequest -> book_discount_id = '';
        $this->doEdit($objRequest, $objResponse);
    }

    protected function doEdit($objRequest, $objResponse) {
        $this->setDisplay();
        $arrayPostValue= $objRequest->getPost();
        $book_type_id = $objRequest -> book_type_id;

        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {
            $arrayData['book_type_name'] = $objRequest -> book_type_name;
            $arrayData['type'] = $objRequest -> type;
            if(empty($arrayPostValue['agreement_active_time_begin'])) unset($arrayPostValue['agreement_active_time_begin']);
            if(empty($arrayPostValue['agreement_active_time_end'])) unset($arrayPostValue['agreement_active_time_end']);
            if(isset($arrayPostValue['book_type_name']) && !empty($arrayData['book_type_name']) && !empty($arrayData['type'])) {
                $url = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['memberSetting']['view'])));
                //$url = '';
                if($book_type_id > 0) {
                    $arrayData['book_type_father_id'] = $arrayPostValue['book_type'];
                    $where = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                        'book_type_id'=>$book_type_id);
                    BookService::instance()->updateBookType($where, $arrayData);
                    return $this->successResponse($objResponse->arrayLaguage['save_success']['page_laguage_value'],'',$url);
                } else {
                    BookService::instance()->startTransaction();
                    $arrayData['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                    $book_type_id = BookService::instance()->saveBookType($arrayData);
                    BookService::instance()->updateBookType(array('book_type_id'=>$book_type_id),
                            array('book_type_father_id'=>$book_type_id));
                    BookService::instance()->commit();
                    return $this->successResponse($objResponse->arrayLaguage['save_success']['page_laguage_value'],'',$url);
                }
            }
            $book_discount_id = $objRequest -> book_discount_id;
            $book_discount_name = $objRequest -> book_discount_name;
            if(isset($arrayPostValue['book_discount_name']) && !empty($book_discount_name) && isset($arrayPostValue['book_discount'])) {
                $url = \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['memberSetting']['view'])));
                //$url = '';
                if($book_discount_id > 0) {
                    $where = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                        'book_discount_id'=>$book_discount_id);
                    unset($arrayPostValue['book_discount_id']);
                    unset($arrayPostValue['discount_book_type_id']);
                    BookService::instance()->updateBookDiscount($where, $arrayPostValue);
                    return $this->successResponse($objResponse->arrayLaguage['save_success']['page_laguage_value'],'',$url);
                } else {
                    unset($arrayPostValue['book_discount_id']);
                    $arrayPostValue['book_type_id'] = $arrayPostValue['discount_book_type_id'];
                    unset($arrayPostValue['discount_book_type_id']);
                    $arrayPostValue['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
                    BookService::instance()->saveBookDiscount($arrayPostValue);
                    return $this->successResponse($objResponse->arrayLaguage['save_success']['page_laguage_value'],'',$url);
                }
            }
        }
        return $this->errorResponse($objResponse->arrayLaguage['save_nothings']['page_laguage_value']);
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
        $arrayPostValue= $objRequest->getPost();
        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {

            return $this->successResponse($objResponse->arrayLaguage['save_success']['page_laguage_value']);
        }
        return $this->errorResponse($objResponse->arrayLaguage['save_nothings']['page_laguage_value']);
    }

}