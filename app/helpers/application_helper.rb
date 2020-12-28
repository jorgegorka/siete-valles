# frozen_string_literal: true

module ApplicationHelper
  def main_menu_class(current_item)
    if current_page?(current_item)
      'bg-gray-900 text-white group flex items-center px-2 py-2 text-sm font-medium rounded-md'
    else
      'text-gray-300 hover:bg-gray-700 hover:text-white group flex items-center px-2 py-2 text-sm font-medium rounded-md'
    end
  end
end
