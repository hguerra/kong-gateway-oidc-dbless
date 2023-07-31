return {
  ["roles/accessapproval.approver"] = {
    permissions = {
      "accessapproval.requests.approve",
      "accessapproval.requests.dismiss",
      "accessapproval.requests.get",
      "accessapproval.requests.invalidate",
      "accessapproval.requests.list",
    }
  },
  ["roles/ml.developer"] = {
    permissions = {
      "ml.jobs.create",
      "ml.jobs.get",
      "ml.jobs.list",
      "ml.jobs.update",
      "ml.jobs.delete",
    }
  }
}
