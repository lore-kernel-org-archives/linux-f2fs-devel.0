From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: pass checkpoint reason on roll-forward
	recovery
Date: Thu, 16 Apr 2015 00:30:45 -0700
Message-ID: <1429169445-18306-3-git-send-email-jaegeuk@kernel.org>
References: <1429169445-18306-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YieGH-0006v6-30
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 07:30:57 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YieGF-0001T8-VO for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 07:30:57 +0000
In-Reply-To: <1429169445-18306-1-git-send-email-jaegeuk@kernel.org>
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

This patch adds CP_RECOVERY to remain recovery information for checkpoint.
And, it makes sure writing checkpoint in this case.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c        | 6 +++++-
 fs/f2fs/f2fs.h              | 1 +
 fs/f2fs/recovery.c          | 2 +-
 include/trace/events/f2fs.h | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 384bfc4..a5e17a2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1051,7 +1051,7 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	mutex_lock(&sbi->cp_mutex);
 
 	if (!is_sbi_flag_set(sbi, SBI_IS_DIRTY) &&
-			cpc->reason != CP_DISCARD && cpc->reason != CP_UMOUNT)
+		(cpc->reason == CP_FASTBOOT || cpc->reason == CP_SYNC))
 		goto out;
 	if (unlikely(f2fs_cp_error(sbi)))
 		goto out;
@@ -1086,6 +1086,10 @@ void write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	unblock_operations(sbi);
 	stat_inc_cp_count(sbi->stat_info);
+
+	if (cpc->reason == CP_RECOVERY)
+		f2fs_msg(sbi->sb, KERN_NOTICE,
+			"checkpoint: version = %llx", ckpt_ver);
 out:
 	mutex_unlock(&sbi->cp_mutex);
 	trace_f2fs_write_checkpoint(sbi->sb, cpc->reason, "finish checkpoint");
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 053361a..c06a25e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -103,6 +103,7 @@ enum {
 	CP_UMOUNT,
 	CP_FASTBOOT,
 	CP_SYNC,
+	CP_RECOVERY,
 	CP_DISCARD,
 };
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4b742c9..8d8ea99 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -564,7 +564,7 @@ out:
 		mutex_unlock(&sbi->cp_mutex);
 	} else if (need_writecp) {
 		struct cp_control cpc = {
-			.reason = CP_SYNC,
+			.reason = CP_RECOVERY,
 		};
 		mutex_unlock(&sbi->cp_mutex);
 		write_checkpoint(sbi, &cpc);
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 75724bd..8804f22 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -78,6 +78,7 @@
 		{ CP_UMOUNT,	"Umount" },				\
 		{ CP_FASTBOOT,	"Fastboot" },				\
 		{ CP_SYNC,	"Sync" },				\
+		{ CP_RECOVERY,	"Recovery" },				\
 		{ CP_DISCARD,	"Discard" })
 
 struct victim_sel_policy;
-- 
2.1.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
