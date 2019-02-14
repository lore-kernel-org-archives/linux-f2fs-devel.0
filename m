From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: don't allow negative ->write_io_size_bits
Date: Fri, 15 Feb 2019 00:16:15 +0800
Message-ID: <20190214161615.5854-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

As Dan reported:

"We put an upper bound on ->write_io_size_bits but we don't have a lower
bound."

So let's add lower bound check for ->write_io_size_bits in parse_options().

[We don't allow configuring ->write_io_size_bits to zero, since at least
we need to fill one dummy page for aligned IO.]

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index be8be445c6ed..230845221c74 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -586,7 +586,7 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_io_size_bits:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			if (arg > __ilog2_u32(BIO_MAX_PAGES)) {
+			if (arg <= 0 || arg > __ilog2_u32(BIO_MAX_PAGES)) {
 				f2fs_msg(sb, KERN_WARNING,
 					"Not support %d, larger than %d",
 					1 << arg, BIO_MAX_PAGES);
-- 
2.18.0
