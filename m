From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] fsck.f2fs: show ckeckpoint version info
Date: Thu, 16 Apr 2015 00:31:11 -0700
Message-ID: <1429169471-18383-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YieGf-0001Kq-2m
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 07:31:21 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YieGe-0004mP-7s for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 07:31:21 +0000
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

This patch shows the valid checkpoint version number.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/mount.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index f900dd7..1c55f40 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -400,7 +400,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_sb = sbi->raw_super;
 	void *cp1, *cp2, *cur_page;
 	unsigned long blk_size = sbi->blocksize;
-	unsigned long long cp1_version = 0, cp2_version = 0;
+	unsigned long long cp1_version = 0, cp2_version = 0, version;
 	unsigned long long cp_start_blk_no;
 	unsigned int cp_blks = 1 + le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_payload);
 	int ret;
@@ -423,22 +423,28 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 		if (ver_after(cp2_version, cp1_version)) {
 			cur_page = cp2;
 			sbi->cur_cp = 2;
+			version = cp2_version;
 		} else {
 			cur_page = cp1;
 			sbi->cur_cp = 1;
+			version = cp1_version;
 		}
 	} else if (cp1) {
 		cur_page = cp1;
 		sbi->cur_cp = 1;
+		version = cp1_version;
 	} else if (cp2) {
 		cur_page = cp2;
 		sbi->cur_cp = 2;
+		version = cp2_version;
 	} else {
 		free(cp1);
 		free(cp2);
 		goto fail_no_cp;
 	}
 
+	MSG(0, "Info: CKPT version = %"PRIx64"\n", version);
+
 	memcpy(sbi->ckpt, cur_page, blk_size);
 
 	if (cp_blks > 1) {
-- 
2.1.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
