module LayoutHelper
  def flash_messages(opts={})
    @layout_flash = opts.fetch(:layout_flash) { true }

    capture do
      flash.each do |name, msg|
        concat(content_tag(:div, msg, id: "flash_#{name}", class: "alert fade in") do
          concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
          concat msg
        end)
      end
      nil
    end
  end

  def show_layout_flash?
    @layout_flash.nil? ? true : @layout_flash
  end
end
