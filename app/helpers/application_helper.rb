module ApplicationHelper
  def main_menu_class(current_item)
    if current_page?(current_item)
      'bg-gray-900 text-white group flex items-center px-2 py-2 text-sm font-medium rounded-md'
    else
      'text-gray-300 hover:bg-gray-700 hover:text-white group flex items-center px-2 py-2 text-sm font-medium rounded-md'
    end
  end

  def format_datetime(datetime)
    return if datetime.blank?

    datetime.strftime('%d-%m-%Y %H:%M')
  end
end
