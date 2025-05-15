class common;

// Define Mailboxes
static mailbox gen2bfm=new();
static mailbox mon2cov=new();
static mailbox mon2sbd=new();

// Define Virtual Interface
static virtual intrface vif1;

// Defining the testcase variable
static string testcase="multiple_wr_rd";

// Defining count variables
static int count = 40;
static int bfm_count;
static int tx_count;

// Defining Matches and Mismatch variables
static int num_matches = 0;
static int num_miss_matches = 0;

endclass
