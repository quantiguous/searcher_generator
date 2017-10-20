require 'spec_helper'
<% small_model_name = model_name.underscore%>
describe <%=model_name%>Searcher do
  context 'searcher' do
    it 'should return <%=small_model_name%>' do
<% get_attributes.each do |attr| -%>
<% if attr[0].include?('bet$')-%>
<% attr[0] = attr[0].chomp('bet$')-%>
      <%=small_model_name%>s = [Factory(:<%=small_model_name%>, :<%=attr[0]%> => "<%=1.year.ago.to_s%>")]
      <%=small_model_name%>s << Factory(:<%=small_model_name%>, :<%=attr[0]%> => "<%=6.months.ago.to_s%>")
      <%=model_name%>Searcher.new({from_<%=attr[0]%>:  "<%=13.months.ago.to_s%>", to_<%=attr[0]%>: "<%=7.months.ago.to_s%>" }).paginate.should == [<%=small_model_name%>s[0]]
      <%=model_name%>Searcher.new({from_<%=attr[0]%>:  "<%=13.months.ago.to_s%>", to_<%=attr[0]%>: "<%=2.months.from_now.to_s%>" }).paginate.should == <%=small_model_name%>s.reverse

<% elsif attr[0].include?('bet1')-%>
<% attr[0] = attr[0].chomp('bet1')-%>
      <%=small_model_name%>s = [Factory(:<%=small_model_name%>, :<%=attr[0]%> => <%= 100%>)]
      <%=small_model_name%>s << Factory(:<%=small_model_name%>, :<%=attr[0]%> => <%= 200%>)
      <%=model_name%>Searcher.new({from_<%=attr[0]%>:  <%= 50 %>, to_<%=attr[0]%>: <%= 150 %> }).paginate.should == [<%=small_model_name%>s[0]]
      <%=model_name%>Searcher.new({from_<%=attr[0]%>:  <%= 50 %>, to_<%=attr[0]%>: <%= 200 %> }).paginate.should == <%=small_model_name%>s.reverse

<% elsif attr[0].include?('e$')-%>
<% attr[0] = attr[0].chomp('e$')-%>
      <%=small_model_name%> = Factory(:<%=small_model_name%>, :<%=attr[0]%> => 'STRING1')
      <%=model_name%>Searcher.new({<%= attr[0]%>: 'STRING1'}).paginate.should == [<%=small_model_name%>]
      <%=model_name%>Searcher.new({<%= attr[0]%>: 'STRING2'}).paginate.should == []

<% elsif attr[0].include?('page@') or attr[0].include?('humanize_model@')-%>
<% elsif attr[0].include?('approval_status@')-%>
<% attr[0] = attr[0].chomp('@')-%>
      <%=small_model_name%> = Factory(:<%=small_model_name%>, :<%=attr[0]%> => 'U')
      <%=model_name%>Searcher.new({<%= attr[0]%>: 'U'}).paginate.should == [<%=small_model_name%>]
      <%=model_name%>Searcher.new({<%= attr[0]%>: 'A'}).paginate.should == []
      
<% else -%>
      <%=small_model_name%> = Factory(:<%=small_model_name%>, :<%=attr[0]%> => 'STRING1')
      <%=model_name%>Searcher.new({<%= attr[0]%>: 'STRING1'}).paginate.should == [<%=small_model_name%>]
      <%=model_name%>Searcher.new({<%= attr[0]%>: 'STRING2'}).paginate.should == []

<% end -%>
<% end -%>
    end
  end
end
