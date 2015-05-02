From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 04/19] f2fs: add feature facility in superblock
Date: Fri,  1 May 2015 17:48:31 -0700
Message-ID: <1430527726-68547-4-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcK-0008EH-Io
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:16 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcJ-0001Cm-E0 for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:16 +0000
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

This patch introduces a feature in superblock, which will indicate any new
features for f2fs.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h          | 7 +++++++
 include/linux/f2fs_fs.h | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cd9748a..e1dd986 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -70,6 +70,13 @@ struct f2fs_mount_info {
 	unsigned int	opt;
 };
 
+#define F2FS_HAS_FEATURE(sb, mask)					\
+	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
+#define F2FS_SET_FEATURE(sb, mask)					\
+	F2FS_SB(sb)->raw_super->feature |= cpu_to_le32(mask)
+#define F2FS_CLEAR_FEATURE(sb, mask)					\
+	F2FS_SB(sb)->raw_super->feature &= ~cpu_to_le32(mask)
+
 #define CRCPOLY_LE 0xedb88320
 
 static inline __u32 f2fs_crc32(void *buf, size_t len)
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 8d345c2..d44e97f 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -90,7 +90,8 @@ struct f2fs_super_block {
 	__le32 cp_payload;
 	__u8 version[VERSION_LEN];	/* the kernel version */
 	__u8 init_version[VERSION_LEN];	/* the initial kernel version */
-	__u8 reserved[892];		/* valid reserved region */
+	__le32 feature;			/* defined features */
+	__u8 reserved[888];		/* valid reserved region */
 } __packed;
 
 /*
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
