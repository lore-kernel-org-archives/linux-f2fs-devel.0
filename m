From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH v3 1/2] f2fs: correct return value type of
	f2fs_fill_super
Date: Mon, 16 May 2016 12:38:49 +0800
Message-ID: <1463373530-6173-1-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shengyong1@huawei.com>) id 1b2ALn-0007CM-03
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 04:41:51 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b2ALh-0003VB-7o
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 16 May 2016 04:41:50 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 28c8992..0e54e84 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1417,7 +1417,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	struct f2fs_sb_info *sbi;
 	struct f2fs_super_block *raw_super;
 	struct inode *root;
-	long err;
+	int err;
 	bool retry = true, need_fsck = false;
 	char *options = NULL;
 	int recovery, i, valid_super_block;
@@ -1643,7 +1643,7 @@ try_onemore:
 		if (err < 0) {
 			need_fsck = true;
 			f2fs_msg(sb, KERN_ERR,
-				"Cannot recover all fsync data errno=%ld", err);
+				"Cannot recover all fsync data errno=%d", err);
 			goto free_kobj;
 		}
 	} else {
@@ -1676,7 +1676,7 @@ try_onemore:
 	if (recovery) {
 		err = f2fs_commit_super(sbi, true);
 		f2fs_msg(sb, KERN_INFO,
-			"Try to recover %dth superblock, ret: %ld",
+			"Try to recover %dth superblock, ret: %d",
 			sbi->valid_super_block ? 1 : 2, err);
 	}
 
-- 
2.7.1


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
