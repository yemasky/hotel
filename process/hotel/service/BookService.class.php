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

    public function getBook($conditions, $fieldid, $hashKey = null) {
        return BookDao::instance()->getBook($conditions, $fieldid, $hashKey);
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

    public function searchISBookRoomLayout($conditions) {
        $table = "`room_layout_room` rlr LEFT JOIN `room_layout` rl ON rlr.`room_layout_id` = rl.room_layout_id "
                ."LEFT JOIN `room_layout_price` rlp ON rlp.`room_layout_id` = rlr.`room_layout_id` AND rlp.`room_layout_price_is_active` = '1'";
        $fieid = 'COUNT(rlp.`room_layout_id`) room_layout_num, rlp.`room_layout_price`, rl.*';//rlr.`room_id`
        return BookDao::instance()->setTable($table)->getList($conditions, $fieid);
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


}