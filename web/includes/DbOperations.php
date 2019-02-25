<?php 

    class DbOperations{
        private $con; 

        function __construct(){
            require_once dirname(__FILE__) . '/DB.php';
            $db = new DbConnect; 
            $this->con = $db->connect(); 
        }

        public function getAllAnimals(){
            $stmt = $this->con->prepare("SELECT * FROM vw_animais ");
            $stmt->execute(); 
            $result = $stmt->get_result();
            $animals = array(); 
            while($row = $result->fetch_assoc()){ 
                $animal = array(); 
                $animal['cod'] = $row['cod']; 
                $animal['nome'] = $row['nome']; 
                $animal['sexo'] = $row['sexo']; 
                $animal['especie'] = $row['especie']; 
                $animal['especie_cod'] = $row['especie_cod']; 
                $animal['chip'] = $row['chip']; 
                $animal['dtNascimento'] = $row['dtNascimento']; 
                $animal['dtUpdate'] = $row['dtUpdate']; 
                $animal['dtFalecimento'] = $row['dtFalecimento']; 
                $animal['raca'] = $row['raca']; 
                $animal['idade'] = $row['idade']; 
                $animal['Vivo'] = $row['Vivo']; 
                $animal['path'] = $row['path']; 
                array_push($animals, $animal);
            }             
            return $animals; 
        }

        
        public function getAllRacas($situacao,$especie_cod){
            $query = "SELECT * FROM vw_racas ";
            if($situacao || $especie_cod) {
                $query = $query . "WHERE ";
                if($situacao) {
                    $query = $query . "situacao = '" . $situacao . "'";
                    if($especie_cod) {
                        $query = $query . " and especie_cod = " . $especie_cod;
                    }
                }else {
                    if($especie_cod) {
                        $query = $query . "especie_cod = " . $especie_cod;
                    }
                }
            } //FORMATAR QUERY COM OS PARAMETROS.

            $stmt = $this->con->prepare($query);
            $stmt->execute(); 
            $result = $stmt->get_result();
            $racas = array(); 
            while($row = $result->fetch_assoc()){ 
                $raca = array(); 
                $raca['id'] = $row['cod']; 
                $raca['raca'] = $row['descricao']; 
                $raca['especie'] = $row['especie']; 
                $raca['kindOfPet'] = $row['especie_cod']; 
                $raca['situacao'] = $row['situacao']; 
                array_push($racas, $raca);
            }             
            return $racas; 
        }


        public function postAnimal($pet){
            // return $pet;
            $img = rand(1,5); // gerar identificar de imagem.
            $dtBorn = DateTime::createFromFormat('d-m-Y', $pet->dtBorn)->format('Y-m-d'); // Formatar data para Mysql
            if ($pet->dtDeath) {// Formatar data para Mysql
                $dtDeath = "'" . DateTime::createFromFormat('d-m-Y', $pet->dtDeath)->format('Y-m-d') . "'";
            }else {
                $dtDeath = 'null';
            }
            $query = "call sp_animal_insert('" . $pet->name . "','" . $pet->gender . "'," .$pet->kindOfPet . ",'" . $pet->chip. "','" . $dtBorn . "'," . $dtDeath . "," . $pet->raca . "," . $img . ");";
            $stmt = $this->con->prepare("call sp_animal_insert('0101','F',1,'1111','2000-01-01',null,6,5);");
            return $query;
            // $stmt->execute(); 
            // $result = $stmt->get_result();
            // return $result;
        }


    }