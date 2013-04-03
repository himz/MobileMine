require 'spec_helper'
#Routing test covers these. Add only if routing is being deleted.

describe "CreditInfos" do

    describe "details of credit_info" do

      xit "I should get a page"   do
        get credit_info_path(credit_info)
        response.status.should be(200)
      end
    end
end
