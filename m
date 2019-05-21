From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: allow ssr block allocation during checkpoint=disable period
Date: Tue, 21 May 2019 11:06:25 -0700
Message-ID: <20190521180625.10562-2-jaegeuk@kernel.org>
References: <20190521180625.10562-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190521180625.10562-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch allows to use ssr during checkpoint is disabled.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 963fb4571fd9..1e029da26053 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -387,7 +387,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 			goto next;
 		/* Don't touch checkpointed data */
 		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
-					get_ckpt_valid_blocks(sbi, segno)))
+					get_ckpt_valid_blocks(sbi, segno) &&
+					p.alloc_mode != SSR))
 			goto next;
 		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
 			goto next;
-- 
2.19.0.605.g01d371f741-goog
