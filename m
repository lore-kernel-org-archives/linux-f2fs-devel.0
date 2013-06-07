From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: [f2fs-dev] [PATCH] f2fs: Set sb->s_fs_info before calling
	parse_options()
Date: Fri, 07 Jun 2013 14:16:53 +0800
Message-ID: <51B17AD5.6060908@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1Ukq1Z-00014C-A6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 06:19:45 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ukq1X-0003cu-Nl for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 07 Jun 2013 06:19:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: guz.fnst@cn.fujitsu.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net

In f2fs_fill_super(), set sb->s_fs_info before calling parse_options(), then we can get
f2fs_sb_info via F2FS_SB(sb) in parse_options().
So that the second argument "sbi" of func parse_options() is no longer needed.

Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
---
 fs/f2fs/super.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8555f7d..58516b5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -303,9 +303,9 @@ static const struct export_operations f2fs_export_ops = {
 	.get_parent = f2fs_get_parent,
 };
 
-static int parse_options(struct super_block *sb, struct f2fs_sb_info *sbi,
-				char *options)
+static int parse_options(struct super_block *sb, char *options)
 {
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
 	substring_t args[MAX_OPT_ARGS];
 	char *p;
 	int arg = 0;
@@ -541,6 +541,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto free_sb_buf;
 	}
+	sb->s_fs_info = sbi;
 	/* init some FS parameters */
 	sbi->active_logs = NR_CURSEG_TYPE;
 
@@ -553,7 +554,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	set_opt(sbi, POSIX_ACL);
 #endif
 	/* parse mount options */
-	err = parse_options(sb, sbi, (char *)data);
+	err = parse_options(sb, (char *)data);
 	if (err)
 		goto free_sb_buf;
 
@@ -565,7 +566,6 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_xattr = f2fs_xattr_handlers;
 	sb->s_export_op = &f2fs_export_ops;
 	sb->s_magic = F2FS_SUPER_MAGIC;
-	sb->s_fs_info = sbi;
 	sb->s_time_gran = 1;
 	sb->s_flags = (sb->s_flags & ~MS_POSIXACL) |
 		(test_opt(sbi, POSIX_ACL) ? MS_POSIXACL : 0);
-- 
1.7.7

------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j
