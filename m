From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] f2fs: load_nat_block() can be static
Date: Sun, 22 Apr 2018 14:31:09 +0800
Message-ID: <20180422063109.GA10531@lkp-wsm-ep2>
References: <20180420015231.90679-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180420015231.90679-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: kbuild-all@01.org, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net


Fixes: c20dcf3ce26e ("f2fs: sepearte hot/cold in free nid")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 node.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fa09baa..ff9b682 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2031,7 +2031,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi, enum nid_state state)
 	up_read(&nm_i->nat_tree_lock);
 }
 
-void load_nat_block(struct f2fs_sb_info *sbi, enum nid_state state)
+static void load_nat_block(struct f2fs_sb_info *sbi, enum nid_state state)
 {
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	unsigned int nat_ofs;
