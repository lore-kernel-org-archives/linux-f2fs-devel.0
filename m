From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid frequent costly fsck triggers
Date: Tue, 27 Nov 2018 23:31:25 -0800
Message-ID: <20181128073125.39102-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we want to re-enable nat_bits, we rely on fsck which requires full scan
of directory tree. Let's do that by regular fsck or unclean shutdown.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c28a9d1cb278..aa500239baf2 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1621,7 +1621,11 @@ static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
 {
 	unsigned long flags;
 
-	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	/*
+	 * In order to re-enable nat_bits we need to call fsck.f2fs by
+	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
+	 * so let's rely on regular fsck or unclean shutdown.
+	 */
 
 	if (lock)
 		spin_lock_irqsave(&sbi->cp_lock, flags);
-- 
2.19.0.605.g01d371f741-goog
