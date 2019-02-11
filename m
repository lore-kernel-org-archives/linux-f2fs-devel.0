From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] f2fs: don't allow negative ->write_io_size_bits
Date: Mon, 11 Feb 2019 21:45:14 +0300
Message-ID: <20190211184514.GA22212@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <dan.carpenter@oracle.com>) id 1gtGaF-0000Ce-3r
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Feb 2019 18:45:35 +0000
Received: from userp2120.oracle.com ([156.151.31.85])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gtGaD-008W2U-Hu
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Feb 2019 18:45:35 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We put an upper bound on ->write_io_size_bits but we don't have a lower
bound.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3ec11d392a5e..2db2d38e2aca 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -586,7 +586,7 @@ static int parse_options(struct super_block *sb, char *options)
 		case Opt_io_size_bits:
 			if (args->from && match_int(args, &arg))
 				return -EINVAL;
-			if (arg > __ilog2_u32(BIO_MAX_PAGES)) {
+			if (arg < 0 || arg > __ilog2_u32(BIO_MAX_PAGES)) {
 				f2fs_msg(sb, KERN_WARNING,
 					"Not support %d, larger than %d",
 					1 << arg, BIO_MAX_PAGES);
-- 
2.17.1
