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

  def priority_color(priority)
    case priority.to_sym
    when :high
      'bg-blue-900'
    when :midium
      'bg-secondary'
    when :low
      'bg-accent1'
    else
      'bg-accent2'
    end
  end

  def selected_value_for_filter(field, project, params)
    session_data = project ? session["project_tasks_#{project.id}"] : session['tasks']
    session_data&.fetch(field, params[field.to_sym])
  end
end
