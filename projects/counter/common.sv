class count_common;
  static mailbox gen2bfm = new();
  static mailbox mon2cov =new();
  static mailbox mon2sbd=new();
  static virtual count_intf vif;
  static string testcase;
 static  int num_matches = 0;
  static int num_miss_matches = 0;
endclass