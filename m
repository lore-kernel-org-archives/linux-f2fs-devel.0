From: Huajun Li <huajun.li.lee@gmail.com>
Subject: [PATCH V2 2/6] f2fs: Add a new mount option: inline_data
Date: Sun, 10 Nov 2013 23:13:17 +0800
Message-ID: <1384096401-25169-3-git-send-email-huajun.li.lee@gmail.com>
References: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <huajun.li.lee@gmail.com>) id 1VfWnK-0006on-P9
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Nov 2013 15:19:22 +0000
Received: from mga09.intel.com ([134.134.136.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VfWnJ-0001JY-Un for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 10 Nov 2013 15:19:22 +0000
In-Reply-To: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, linux-kernel@vger.kernel.org, Weihong Xu <weihong.xu@intel.com>

From: Huajun Li <huajun.li@intel.com>

Add a mount option: inline_data. If the mount option is set,
data of New created small files can be stored in their inode.

Signed-off-by: Huajun Li <huajun.li@intel.com>
Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
Signed-off-by: Weihong Xu <weihong.xu@intel.com>
---
 fs/f2fs/super.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bafff72..12e89ac 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -50,6 +50,7 @@ enum {
 	Opt_active_logs,
 	Opt_disable_ext_identify,
 	Opt_inline_xattr,
+	Opt_inline_data,
 	Opt_err,
 };
 
@@ -65,6 +66,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_active_logs, "active_logs=%u"},
 	{Opt_disable_ext_identify, "disable_ext_identify"},
 	{Opt_inline_xattr, "inline_xattr"},
+	{Opt_inline_data, "inline_data"},
 	{Opt_err, NULL},
 };
 
@@ -311,6 +313,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_disable_ext_identify:
 			set_opt(sbi, DISABLE_EXT_IDENTIFY);
 			break;
+		case Opt_inline_data:
+			set_opt(sbi, INLINE_DATA);
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -508,7 +513,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 #endif
 	if (test_opt(sbi, DISABLE_EXT_IDENTIFY))
 		seq_puts(seq, ",disable_ext_identify");
-
+	if (test_opt(sbi, INLINE_DATA))
+		seq_puts(seq, ",inline_data");
 	seq_printf(seq, ",active_logs=%u", sbi->active_logs);
 
 	return 0;
-- 
1.7.9.5


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
