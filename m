From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix potential overflow in build_sit_info
Date: Wed, 9 Aug 2017 18:09:12 +0800
Message-ID: <20170809100912.65591-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On a 32-bit system, below calculation may overflow the 32-bit unsigned
integer, allocating a buffer size that smaller than needed. A write on
the buffer will then trigger an out of boundary write.
1. MAIN_SEGS(sbi) * sizeof(struct seg_entry)
2. MAIN_SECS(sbi) * sizeof(struct sec_entry)

Fixes this by doing type cast before calculating.

This patch fixes CVE-2017-10662.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 682ae68b9ef7..947674b5f466 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2997,8 +2997,9 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 
 	SM_I(sbi)->sit_info = sit_i;
 
-	sit_i->sentries = kvzalloc(MAIN_SEGS(sbi) *
-					sizeof(struct seg_entry), GFP_KERNEL);
+	sit_i->sentries = kvzalloc((unsigned long long)MAIN_SEGS(sbi) *
+				(unsigned long long)sizeof(struct seg_entry),
+				GFP_KERNEL);
 	if (!sit_i->sentries)
 		return -ENOMEM;
 
@@ -3036,8 +3037,10 @@ static int build_sit_info(struct f2fs_sb_info *sbi)
 		return -ENOMEM;
 
 	if (sbi->segs_per_sec > 1) {
-		sit_i->sec_entries = kvzalloc(MAIN_SECS(sbi) *
-					sizeof(struct sec_entry), GFP_KERNEL);
+		sit_i->sec_entries = kvzalloc(
+				(unsigned long long)MAIN_SECS(sbi) *
+				(unsigned long long)sizeof(struct sec_entry),
+				GFP_KERNEL);
 		if (!sit_i->sec_entries)
 			return -ENOMEM;
 	}
-- 
2.13.1.388.g69e6b9b4f4a9
