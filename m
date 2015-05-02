From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 12/19] f2fs: introduce dot and dotdot name check
Date: Fri,  1 May 2015 17:48:39 -0700
Message-ID: <1430527726-68547-12-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLca-0008G4-G4
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:32 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcZ-0004Sy-NU for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:32 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds an inline function to check dot and dotdot names.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 11 +++++++++++
 fs/f2fs/hash.c |  3 +--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e99a404..b8f99fd 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1454,6 +1454,17 @@ static inline void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi)
 	sbi->sb->s_flags |= MS_RDONLY;
 }
 
+static inline bool is_dot_dotdot(const struct qstr *str)
+{
+	if (str->len == 1 && str->name[0] == '.')
+		return true;
+
+	if (str->len == 2 && str->name[0] == '.' && str->name[1] == '.')
+		return true;
+
+	return false;
+}
+
 #define get_inode_mode(i) \
 	((is_inode_flag_set(F2FS_I(i), FI_ACL_MODE)) ? \
 	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
diff --git a/fs/f2fs/hash.c b/fs/f2fs/hash.c
index a844fcf..71b7206 100644
--- a/fs/f2fs/hash.c
+++ b/fs/f2fs/hash.c
@@ -79,8 +79,7 @@ f2fs_hash_t f2fs_dentry_hash(const struct qstr *name_info)
 	const unsigned char *name = name_info->name;
 	size_t len = name_info->len;
 
-	if ((len <= 2) && (name[0] == '.') &&
-		(name[1] == '.' || name[1] == '\0'))
+	if (is_dot_dotdot(name_info))
 		return 0;
 
 	/* Initialize the default seed for the hash checksum functions */
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
