From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: fix missing up_read
Date: Fri, 28 Sep 2018 10:48:53 -0700
Message-ID: <20180928174854.65978-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes missing up_read call.

Fixes: c9b60788fc76 ("f2fs: fix to do sanity check with block address in main area")
Cc: <stable@vger.kernel.org> # 4.19+
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3994b44541b4..acb819b8fc42 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1541,8 +1541,10 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
 	}
 
 	if (__is_valid_data_blkaddr(ni.blk_addr) &&
-		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC))
+		!f2fs_is_valid_blkaddr(sbi, ni.blk_addr, DATA_GENERIC)) {
+		up_read(&sbi->node_write);
 		goto redirty_out;
+	}
 
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
-- 
2.19.0.605.g01d371f741-goog
