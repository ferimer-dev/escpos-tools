<?php
namespace ReceiptPrintHq\EscposTools\Parser\Command;

use ReceiptPrintHq\EscposTools\Parser\Command\Command;
use ReceiptPrintHq\EscposTools\Parser\Command\TextContainer;

class TextCmd extends Command implements TextContainer
{
    private $str = "";

    function addChar($char)
    {
        if (isset(Printout::$tree[$char])) {
            // Reject ESC/POS control chars.
            return false;
        }
        $this -> str .= $char;
        return true;
    }

    function getText()
    {
        return $this -> str;
    }
}