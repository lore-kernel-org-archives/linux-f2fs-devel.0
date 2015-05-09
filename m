From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] fsck.f2fs: show superblock features and
	encryption info
Date: Fri,  8 May 2015 21:24:38 -0700
Message-ID: <1431145481-2184-2-git-send-email-jaegeuk@kernel.org>
References: <1431145481-2184-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwK3-00059O-4U
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:25:07 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwK2-0004k9-2p for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:25:07 +0000
In-Reply-To: <1431145481-2184-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 1c55f40..11ab197 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -224,6 +224,23 @@ void print_cp_state(u32 flag)
 	MSG(0, "\n");
 }
 
+void print_sb_state(struct f2fs_super_block *sb)
+{
+	__le32 f = sb->feature;
+	int i;
+
+	MSG(0, "Info: superblock features = %x : ", f);
+	if (f & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) {
+		MSG(0, "%s", " encrypt");
+	}
+	MSG(0, "\n");
+	MSG(0, "Info: superblock encrypt level = %d, salt = ",
+					sb->encryption_level);
+	for (i = 0; i < 16; i++)
+		MSG(0, "%02x", sb->encrypt_pw_salt[i]);
+	MSG(0, "\n");
+}
+
 int sanity_check_raw_super(struct f2fs_super_block *raw_super)
 {
 	unsigned int blocksize;
@@ -300,6 +317,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
 			config.auto_fix = 0;
 			config.fix_on = 1;
 		}
+		print_sb_state(sbi->raw_super);
 		return 0;
 	}
 
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
