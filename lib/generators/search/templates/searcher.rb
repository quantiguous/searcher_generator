class <%= model_name.camelcase %>Searcher < Searcher
  attr_searchable <%= symbolize_attribute %>
  
<% if between_attributes.present? || between_date_time_attributes.present? -%>
  def find
    reln = <%= model_name.camelcase %>.order('id desc')
<% between_attributes.each do |attr| -%>
    reln = reln.where("<%= attr[0]%> >= ? and <%= attr[0]%> <= ?", <%= attr[1]%>, <%= attr[2]%>) if <%= attr[1]%>.present? and <%= attr[2]%>.present?
<% end -%>
<% between_date_time_attributes.each do |attr| -%>
    reln = reln.where("<%= attr[0]%> >= ? and <%= attr[0]%> <= ?", Time.zone.parse(<%= attr[1]%>).beginning_of_day,Time.zone.parse(<%= attr[2]%>).beginning_of_day) if <%= attr[1]%>.present? and <%= attr[2]%>.present?
<% end -%>
    reln
  end
<% end -%>  
end