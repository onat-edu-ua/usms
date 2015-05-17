class ActiveAdmin::Views::Pages::Base < Arbre::HTML::Document

  private

  # Renders the content for the footer
  def build_footer
    div :id => "footer" do
      para "Copyright &copy; #{Date.today.year.to_s}. Version #{Usms::Application.config.build_info.fetch('version', 'unknown')}. #{link_to('ONAT', 'http://onat.edu.ua')} NOC.".html_safe
    end
  end

end