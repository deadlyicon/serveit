Serveit::NotFound = -> env do
  [404, {'Content-Type' => 'text/plain', 'Content-Length' => '3'}, ['404']]
end
