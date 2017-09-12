From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: hurry up to issue discard after io
 interruption
Date: Tue, 12 Sep 2017 18:08:08 +0800
Message-ID: <20170912100808.23775-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dri7W-0006CD-EP
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 10:08:42 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dri7U-00006c-ES
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 10:08:42 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Once we encounter I/O interruption during issuing discards, we will delay
long time before next round, but if system status is I/O idle during the
time, it may loses opportunity to issue discards. So this patch changes
to hurry up to issue discard after io interruption.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7fd742f747ce..3ee2236fc091 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1062,6 +1062,7 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	struct blk_plug plug;
 	int iter = 0, issued = 0;
 	int i;
+	bool io_interrupted = false;
 
 	mutex_lock(&dcc->cmd_lock);
 	f2fs_bug_on(sbi,
@@ -1083,10 +1084,19 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 				continue;
 			}
 
-			if (!issue_cond || is_idle(sbi)) {
+			if (!issue_cond) {
+				__submit_discard_cmd(sbi, dc);
 				issued++;
+				continue;
+			}
+
+			if (is_idle(sbi)) {
 				__submit_discard_cmd(sbi, dc);
+				issued++;
+			} else {
+				io_interrupted = true;
 			}
+
 			if (issue_cond && iter++ > DISCARD_ISSUE_RATE)
 				goto out;
 		}
@@ -1097,6 +1107,9 @@ static int __issue_discard_cmd(struct f2fs_sb_info *sbi, bool issue_cond)
 	blk_finish_plug(&plug);
 	mutex_unlock(&dcc->cmd_lock);
 
+	if (!issued && io_interrupted)
+		issued = -1;
+
 	return issued;
 }
 
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
