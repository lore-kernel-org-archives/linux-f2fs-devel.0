From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 11/12] f2fs: set flush_merge by default
Date: Tue, 24 May 2016 17:03:37 -0700
Message-ID: <1464134619-37015-11-git-send-email-jaegeuk@kernel.org>
References: <1464134619-37015-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1b5MIx-0005B7-Sz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1b5MIx-0006iv-0q
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 May 2016 00:04:07 +0000
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

This patch sets flush_merge by default.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index d0426a3..5696dff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -86,6 +86,7 @@ enum {
 	Opt_inline_data,
 	Opt_inline_dentry,
 	Opt_flush_merge,
+	Opt_noflush_merge,
 	Opt_nobarrier,
 	Opt_fastboot,
 	Opt_extent_cache,
@@ -114,6 +115,7 @@ static match_table_t f2fs_tokens = {
 	{Opt_inline_data, "inline_data"},
 	{Opt_inline_dentry, "inline_dentry"},
 	{Opt_flush_merge, "flush_merge"},
+	{Opt_noflush_merge, "noflush_merge"},
 	{Opt_nobarrier, "nobarrier"},
 	{Opt_fastboot, "fastboot"},
 	{Opt_extent_cache, "extent_cache"},
@@ -482,6 +484,9 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_flush_merge:
 			set_opt(sbi, FLUSH_MERGE);
 			break;
+		case Opt_noflush_merge:
+			clear_opt(sbi, FLUSH_MERGE);
+			break;
 		case Opt_nobarrier:
 			set_opt(sbi, NOBARRIER);
 			break;
@@ -931,6 +936,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, INLINE_DATA);
 	set_opt(sbi, EXTENT_CACHE);
 	sbi->sb->s_flags |= MS_LAZYTIME;
+	set_opt(sbi, FLUSH_MERGE);
 
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
