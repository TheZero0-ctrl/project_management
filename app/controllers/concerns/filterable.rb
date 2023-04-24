module Filterable
  def filter!(resource, name)
    store_filters(resource, name)
    apply_filters(resource, name)
  end

  private

  def store_filters(resource, name)
    session[name] = {} unless session.key?(name)

    session[name].merge!(filter_params_for(resource))
  end

  def apply_filters(resource, name)
    resource.filter(session[name])
  end

  def filter_params_for(resource)
    params.permit(resource::FILTER_PARAMS)
  end
end
