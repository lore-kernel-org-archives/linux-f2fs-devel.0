From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 6/7] f2fs-tools: determine cp_addr by sbi->cur_cp
Date: Wed,  2 Nov 2016 22:28:45 -0700
Message-ID: <20161103052846.72244-6-jaegeuk@kernel.org>
References: <20161103052846.72244-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c2AaY-0007BQ-Jl
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:22 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c2AaX-0005i7-TE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 03 Nov 2016 05:29:22 +0000
In-Reply-To: <20161103052846.72244-1-jaegeuk@kernel.org>
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

We don't guarantee cp_addr is fixed by cp_ver due to sload.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/f2fs.h | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fsck/f2fs.h b/fsck/f2fs.h
index 39ff161..fbb878a 100644
--- a/fsck/f2fs.h
+++ b/fsck/f2fs.h
@@ -280,19 +280,10 @@ static inline bool is_set_ckpt_flags(struct f2fs_checkpoint *cp, unsigned int f)
 
 static inline block_t __start_cp_addr(struct f2fs_sb_info *sbi)
 {
-	block_t start_addr;
-	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
-	unsigned long long ckpt_version = le64_to_cpu(ckpt->checkpoint_ver);
-
-	start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
+	block_t start_addr = le32_to_cpu(F2FS_RAW_SUPER(sbi)->cp_blkaddr);
 
-	/*
-	 * odd numbered checkpoint should at cp segment 0
-	 * and even segent must be at cp segment 1
-	 */
-	if (!(ckpt_version & 1))
+	if (sbi->cur_cp == 2)
 		start_addr += sbi->blocks_per_seg;
-
 	return start_addr;
 }
 
-- 
2.8.3


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
