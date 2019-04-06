From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] f2fs: data: fix warning Using plain integer as NULL pointer
Date: Sat, 6 Apr 2019 16:29:36 +0530
Message-ID: <20190406105936.GA30585@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

changed passing function argument "0 to NULL" to fix below sparse
warning

fs/f2fs/data.c:426:47: warning: Using plain integer as NULL pointer

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 97279441..15a2381 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -423,7 +423,7 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 
 void f2fs_submit_merged_write(struct f2fs_sb_info *sbi, enum page_type type)
 {
-	__submit_merged_write_cond(sbi, NULL, 0, 0, type, true);
+	__submit_merged_write_cond(sbi, NULL, NULL, 0, type, true);
 }
 
 void f2fs_submit_merged_write_cond(struct f2fs_sb_info *sbi,
-- 
2.7.4
