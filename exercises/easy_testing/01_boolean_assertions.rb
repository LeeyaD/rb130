# Write a minitest assertion that will fail if the value.odd? is not true.

def test_not_odd
  # assert_equal(false, value.odd?) # we want `assert` to fail!
  assert_equal(true, value.odd?)
end