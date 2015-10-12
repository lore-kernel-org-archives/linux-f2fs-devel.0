From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 4/5] f2fs: readahead for free nids building
Date: Mon, 12 Oct 2015 17:07:33 +0800
Message-ID: <021201d104cd$866e08e0$934a1aa0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

When there is no free nid in nid cache, all new node allocaters stop their
job to wait for reloading of free nids, however reloading is synchronous as
we will read 4 NAT pages for building nid cache, it cause the long latency.

This patch tries to readahead more NAT pages with READA request flag after
reloading of free nids. It helps to improve performance when users allocate
node id intensively.

Env: Sandisk 32G sd card
time for i in `seq 1 60000`; { echo -n > /mnt/f2fs/$i; echo XXXXXX > /mnt/f2fs/$i;}

Before:
real    0m2.814s
user    0m1.220s
sys     0m1.536s

After:
real    0m2.711s
user    0m1.136s
sys     0m1.568s

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index ad98e35..14f4606 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1560,6 +1560,9 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 			remove_free_nid(nm_i, nid);
 	}
 	mutex_unlock(&curseg->curseg_mutex);
+
+	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nm_i->next_scan_nid),
+					FREE_NID_PAGES, META_NAT, false);
 }
 
 /*
-- 
2.5.2
