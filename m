From: Xiaojun Wang <wangxiaojun11@huawei.com>
Subject: [f2fs-dev] [PATCH] f2fs-tools:fix memory leak in write dquot
Date: Wed, 24 Apr 2019 14:47:42 +0800
Message-ID: <1556088462-21693-1-git-send-email-wangxiaojun11@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: wangxiaojun11@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

this patch free ddquot in qtree_write_dquot to avoid memory leak

Signed-off-by: Xiaojun Wang <wangxiaojun11@huawei.com>
---
 fsck/quotaio_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/quotaio_tree.c b/fsck/quotaio_tree.c
index ebee862..de25a60 100644
--- a/fsck/quotaio_tree.c
+++ b/fsck/quotaio_tree.c
@@ -353,6 +353,7 @@ int qtree_write_dquot(struct dquot *dquot)
 	if (ret != info->dqi_entry_size) {
 		log_err("Quota write failed (id %u): %s",
 			(unsigned int)dquot->dq_id, strerror(errno));
+		quota_free_mem(&ddquot);
 		return ret;
 	}
 	quota_free_mem(&ddquot);
-- 
2.7.4
