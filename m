From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 09/12] f2fs: add lazytime mount option
Date: Tue, 24 May 2016 17:03:35 -0700
Message-ID: <1464134619-37015-9-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIv-0005AI-Bd
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIu-0006wA-Jw
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:05 +0000
In-Reply-To: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds lazytime support.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e9e81cb..d0426a3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -93,6 +93,8 @@ enum {
 	Opt_noinline_data,
 	Opt_data_flush,
 	Opt_fault_injection,
+	Opt_lazytime,
+	Opt_nolazytime,
 	Opt_err,
 };
 
@@ -119,6 +121,8 @@ static match_table_t f2fs_tokens = {
 	{Opt_noinline_data, "noinline_data"},
 	{Opt_data_flush, "data_flush"},
 	{Opt_fault_injection, "fault_injection=%u"},
+	{Opt_lazytime, "lazytime"},
+	{Opt_nolazytime, "nolazytime"},
 	{Opt_err, NULL},
 };
 
@@ -506,6 +510,12 @@ static int parse_options(struct super_block *sb, char *options)
 				"FAULT_INJECTION was not selected");
 #endif
 			break;
+		case Opt_lazytime:
+			sb->s_flags |= MS_LAZYTIME;
+			break;
+		case Opt_nolazytime:
+			sb->s_flags &= ~MS_LAZYTIME;
+			break;
 		default:
 			f2fs_msg(sb, KERN_ERR,
 				"Unrecognized mount option \"%s\" or missing value",
@@ -598,6 +608,9 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 			inode->i_ino == F2FS_META_INO(sbi))
 		return;
 
+	if (flags == I_DIRTY_TIME)
+		return;
+
 	if (is_inode_flag_set(inode, FI_AUTO_RECOVER))
 		clear_inode_flag(inode, FI_AUTO_RECOVER);
 
@@ -917,6 +930,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, BG_GC);
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, EXTENT_CACHE);
+	sbi->sb->s_flags |= MS_LAZYTIME;
 
 #ifdef CONFIG_F2FS_FS_XATTR
 	set_opt(sbi, XATTR_USER);
-- 
2.6.3


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
