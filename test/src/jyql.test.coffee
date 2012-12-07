this.test 'true should be truthy', =>
  this.ok true, 'true is not truthy!'

this.test 'should be able to append to an array', => 
  this.equal [1, 2], [1] + 2  