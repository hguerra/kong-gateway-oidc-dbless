local iam = require "kong.plugins.domain-restriction.iam"

describe("some asserts", function()
  it("checks if they're equals", function()
    local roles = iam.roles()
    local users = iam.users()

    assert.are.equals(3, iam.sum(1, 2))
    assert.are.equals(5, #roles["roles/accessapproval.approver"].permissions)
    assert.are.equals(1, #users["example@gmail.com"].roles)
  end)
end)
