From: Chao Yu <chao@kernel.org>
Subject: [PATCH 1/2] f2fs: set CP_TRIMMED_FLAG correctly
Date: Wed, 14 Jun 2017 23:00:55 +0800
Message-ID: <20170614150056.29733-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Don't set CP_TRIMMED_FLAG for non-zoned block device or discard
unsupported device, it can avoid to trigger unneeded checkpoint for
that kind of device.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9081570bc616..8e39b850bfc0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -587,7 +587,7 @@ static void f2fs_put_super(struct super_block *sb)
 	/* be sure to wait for any on-going discard commands */
 	f2fs_wait_discard_bios(sbi);
 
-	if (!sbi->discard_blks) {
+	if (f2fs_discard_en(sbi) && !sbi->discard_blks) {
 		struct cp_control cpc = {
 			.reason = CP_UMOUNT | CP_TRIMMED,
 		};
-- 
2.13.0.90.g1eb437020
