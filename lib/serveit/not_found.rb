Serveit::NotFound = -> env do
  [404, {'Content-Type' => 'text/plain'}, []]
end
