From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH] f2fs: fix remount problem of option io_bits
Date: Sat, 22 Sep 2018 22:43:09 +0800
Message-ID: <20180922144309.1969-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1g3j8I-00070B-0h
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Sep 2018 14:43:42 +0000
Received: from mout.gmx.net ([212.227.17.21])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g3j8G-004QnU-8q
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 22 Sep 2018 14:43:41 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Chengguang Xu <cgxu519@gmx.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Currently we show mount option "io_bits=%u" as "io_size=%uKB",
it will cause option parsing problem(unrecognized mount option)
in remount.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 896b885f504e..8c96c4e9ee8d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1336,7 +1336,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 				from_kgid_munged(&init_user_ns,
 					F2FS_OPTION(sbi).s_resgid));
 	if (F2FS_IO_SIZE_BITS(sbi))
-		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
+		seq_printf(seq, ",io_bits=%u",
+				F2FS_OPTION(sbi).write_io_size_bits);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (test_opt(sbi, FAULT_INJECTION)) {
 		seq_printf(seq, ",fault_injection=%u",
-- 
2.17.1
