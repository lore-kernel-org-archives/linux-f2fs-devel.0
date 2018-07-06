From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/4] f2fs: flush journal nat entries for nat_bits
 during unmount
Date: Fri,  6 Jul 2018 14:09:00 -0700
Message-ID: <20180706210903.77887-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fbXyb-00010o-2a
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 21:09:13 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fbXyZ-001HX8-8Y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 06 Jul 2018 21:09:13 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Let's flush journal nat entries for speed up in the next run.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 29237aeca041..0f076fb0d828 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2613,6 +2613,13 @@ void f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	nid_t set_idx = 0;
 	LIST_HEAD(sets);
 
+	/* during unmount, let's flush nat_bits before checking dirty_nat_cnt */
+	if (enabled_nat_bits(sbi, cpc)) {
+		down_write(&nm_i->nat_tree_lock);
+		remove_nats_in_journal(sbi);
+		up_write(&nm_i->nat_tree_lock);
+	}
+
 	if (!nm_i->dirty_nat_cnt)
 		return;
 
-- 
2.17.0.441.gb46fe60e1d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
