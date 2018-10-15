From: Gao Ming <gaoming20@huawei.com>
Subject: [PATCH] f2fs-tools: add the max chunk size limit in
 sparse image
Date: Mon, 15 Oct 2018 21:24:57 +0800
Message-ID: <1539609897-88068-1-git-send-email-gaoming20@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <gaoming20@huawei.com>) id 1gC2sC-0000j6-Nf
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Oct 2018 13:25:28 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gC2sA-003xmq-BB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Oct 2018 13:25:28 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com, jaegeuk@kernel.org
Cc: harry.shen@huawei.com, weidu.du@huawei.com, wvitao.wang@huawei.com, wangfei66@huawei.com

Malloc Failure occurs in 32bit Windows, when using fastboot.exe flash the
 f2fs sparse image filling with  up to 2G chunk size.

Signed-off-by: Gao Ming <gaoming20@huawei.com>
---
 lib/libf2fs_io.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index 76d283d..47917ab 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -311,6 +311,7 @@ int f2fs_init_sparse_file(void)
 #endif
 }
 
+#define MAX_CHUNK_SIZE (1 * 1024 * 1024 * 1024ULL)
 int f2fs_finalize_device(void)
 {
 	int i;
@@ -337,6 +338,12 @@ int f2fs_finalize_device(void)
 				chunk_start = -1;
 			} else if (blocks[j] && chunk_start == -1) {
 				chunk_start = j;
+			} else if (blocks[j] && (chunk_start != -1) &&
+				 (j + 1 - chunk_start >=
+					(MAX_CHUNK_SIZE / F2FS_BLKSIZE))) {
+				ret = sparse_merge_blocks(chunk_start,
+							  j + 1 - chunk_start);
+				chunk_start = -1;
 			}
 			ASSERT(!ret);
 		}
-- 
2.8.1
