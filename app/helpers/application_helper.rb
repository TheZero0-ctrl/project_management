module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice
      'bg-notice'
    when :success
      'bg-success'
    when :alert
      'bg-alert'
    when :error
      'bg-error'
    else
      'bg-alert'
    end
  end
end
