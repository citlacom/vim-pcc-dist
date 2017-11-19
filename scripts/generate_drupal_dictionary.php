<?php

$functions = get_defined_functions();

if (isset($functions['user'])) {
  foreach ($functions['user'] as $function) {
    echo "{$function}\n";
  }
}
