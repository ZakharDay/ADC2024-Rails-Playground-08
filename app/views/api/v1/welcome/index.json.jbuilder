json.set! :pins do
  json.array! @pins, partial: "api/v1/pins/pin", as: :pin
end

json.set! :comments do
  json.array! @comments, partial: "api/v1/pins/comment", as: :comment
end
