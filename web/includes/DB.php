<?php 
    class DbConnect{
        
        private $con;

        function connect(){
            
            include_once dirname(__FILE__)  . '/../config.php';
            
            $this->con = new mysqli(MYSQL_HOST, MYSQL_USER, MYSQL_PASS, MYSQL_BASE); 
            if(mysqli_connect_errno()){
                echo "Failed  to connect " . mysqli_connect_error(); 
                return null; 
            }
            return $this->con; 
        }
        
    }