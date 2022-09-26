class ApiResourceCommentsController < ApiApplicationController
  def show
    resource_id = params['resource_id']
    comments = Resource.find(resource_id)&.resource_comments
    render json: comments, only: %i[id content resource_id user_id]
  end
  
  def create
    content = params['content']
    resource_id = params['resource_id']
    newComment = ResourceComment.new(
      content:,
      user: current_user,
      resource_id:
    )

    if newComment.save
      status = :created
      render json: {
        'commentId': newComment.id,
        'content': newComment.content,
        'resource_id': newComment.resource.id
      }, status:
    elsif content.nil?
      handle_bad_request_custom_message('content_must_exist')
    elsif content.strip == ''
      handle_bad_request_custom_message('content_can_not_be_empty')
    elsif Resource.where(id: resource_id).blank?
      handle_record_not_found_error
    else
      handle_bad_request_custom_message('invalid_parameters')
    end
  end

  private

  def handle_bad_request_custom_message(message)
    code = 400
    message = message
    status = :bad_request

    render json: { code:, message:, status: }, status:
  end
end
