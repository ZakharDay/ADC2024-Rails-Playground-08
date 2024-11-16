json.extract! @pin, :id, :title, :description

json.set! :comments do
  json.array! @pin.comments, partial: "api/v1/pins/comment", as: :comment
end
