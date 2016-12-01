<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace hotel;
class BookService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new BookService();
        return self::$objService;
    }

    public function getBook($conditions, $field = '*', $hashKey = null, $multiple = false) {
        return BookDao::instance()->getBook($conditions, $field, $hashKey, $multiple);
    }

    public function saveBook($arrayData) {
        return BookDao::instance()->setTable('book')->insert($arrayData);
    }

    public function updateBook($where, $row) {
        return BookDao::instance()->setTable('book')->update($where, $row);
    }

    public function deleteBook($where) {
        return BookDao::instance()->setTable('book')->delete($where);
    }

    public function getBookType($conditions, $fieldid = '*', $hashKey = null) {
        return BookDao::instance()->setTable('book_type')->getList($conditions, $fieldid, $hashKey);
    }

    public function saveBookType($arrayData) {
        return BookDao::instance()->setTable('book_type')->insert($arrayData);
    }

    public function updateBookType($where, $row) {
        return BookDao::instance()->setTable('book_type')->update($where, $row);
    }

    public function deleteBookType($where) {
        return BookDao::instance()->setTable('book_type')->delete($where);
    }

    public function getBookDiscount($conditions, $fieldid = '*', $hashKey = null) {
        return BookDao::instance()->setTable('book_discount')->getList($conditions, $fieldid, $hashKey);
    }

    public function saveBookDiscount($arrayData) {
        return BookDao::instance()->setTable('book_discount')->insert($arrayData);
    }

    public function updateBookDiscount($where, $row) {
        return BookDao::instance()->setTable('book_discount')->update($where, $row);
    }

    public function deleteBookDiscount($where) {
        return BookDao::instance()->setTable('book_discount')->delete($where);
    }


    public function getBookTypeDiscount($conditions) {
        $arrayBookTypeId = \web\UserService::instance()->getUserLogin($conditions, 'book_type_id, book_discount_id');
        $arrayBookType = null;
        if(!empty($arrayBookTypeId)) {
            $conditions['where'] = array('book_discount_id'=>$arrayBookTypeId[0]['book_discount_id']);
            $arrayBookTypeDiscount = $this->getBookDiscount($conditions, 'book_discount, book_discount_name, agreement_company_name');
        }
        if(!empty($arrayBookTypeDiscount)) {
            $arrayBookType['book_discount_id'] = $arrayBookTypeId[0]['book_discount_id'];
            $arrayBookType['book_type_id'] = $arrayBookTypeId[0]['book_type_id'];
            $arrayBookType['book_discount'] = $arrayBookTypeDiscount[0]['book_discount'];
            $arrayBookType['book_discount_name'] = $arrayBookTypeDiscount[0]['book_discount_name'];
            $arrayBookType['agreement_company_name'] = $arrayBookTypeDiscount[0]['agreement_company_name'];
        }
        return $arrayBookType;
    }

    public function getPaymentType($conditions, $fieldid = '*', $hashKey = null) {
        return BookDao::instance()->setTable('payment_type')->getList($conditions, $fieldid, $hashKey);
    }

    public function savePaymentType($arrayData) {
        return BookDao::instance()->setTable('payment_type')->insert($arrayData);
    }

    public function updatePaymentType($where, $row) {
        return BookDao::instance()->setTable('payment_type')->update($where, $row);
    }

    public function deletePaymentType($where) {
        return BookDao::instance()->setTable('payment_type')->delete($where);
    }

    //入住用户信息
    public function getBookUser($conditions, $field = '*', $hashKey = null, $multiple = false) {
        return BookDao::instance()->setTable('book_user')->getList($conditions, $field, $hashKey, $multiple);
    }

    public function saveBookUser($arrayData) {
        return BookDao::instance()->setTable('book_user')->insert($arrayData);
    }

    public function updateBookUser($where, $row) {
        return BookDao::instance()->setTable('book_user')->update($where, $row);
    }

    public function deleteBookUser($where) {
        return BookDao::instance()->setTable('book_user')->delete($where);
    }



}