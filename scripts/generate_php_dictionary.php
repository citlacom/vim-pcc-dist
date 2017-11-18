<?php

$functions = get_defined_functions();

if (isset($functions['internal'])) {
  foreach ($functions['internal'] as $function) {
    echo "{$function}\n";
  }
}
