From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to do f2fs_balance_fs in f2fs_map_blocks correctly
Date: Sat, 20 Aug 2016 15:12:02 +0800
Message-ID: <20160820071202.31355-2-yuchao0@huawei.com>
References: <20160820071202.31355-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160820071202.31355-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we preallocate blocks with f2fs_reserve_blocks in f2fs_map_blocks, we
should call f2fs_balance_fs for checking and reclaiming space, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dee3a78..040a07a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -784,6 +784,7 @@ skip:
 		err = reserve_new_blocks(&dn, prealloc);
 		if (err)
 			goto sync_out;
+		allocated = dn.node_changed;
 
 		map->m_len += dn.ofs_in_node - ofs_in_node;
 		if (prealloc && dn.ofs_in_node != last_ofs_in_node + 1) {
-- 
2.8.2.311.gee88674
