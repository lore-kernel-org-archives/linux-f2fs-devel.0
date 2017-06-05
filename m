From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/4] f2fs: add f2fs_bug_on in __remove_discard_cmd
Date: Mon, 5 Jun 2017 18:29:07 +0800
Message-ID: <20170605102909.57625-2-yuchao0@huawei.com>
References: <20170605102909.57625-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170605102909.57625-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Recently, discard related codes have changed a lot, so add f2fs_bug_on to
detect potential bug.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 4ec40563e86d..9a44aca8d2c5 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -739,6 +739,8 @@ static void __remove_discard_cmd(struct f2fs_sb_info *sbi,
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 
+	f2fs_bug_on(sbi, dc->ref);
+
 	if (dc->error == -EOPNOTSUPP)
 		dc->error = 0;
 
-- 
2.13.0.67.g10c78a162fa8
