From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix readdir incorrectness
Date: Fri, 05 Jul 2013 14:22:10 +0900
Message-ID: <1373001730-6928-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UuyTS-00014r-5M
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 Jul 2013 05:22:26 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UuyTQ-0002z3-0z for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 Jul 2013 05:22:26 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MPG007566X5SMI0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 Jul 2013 14:22:17 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, linux-f2fs-devel@lists.sourceforge.net

In the previous Al Viro's readdir patch set, there occurs a bug when running
xfstest: 006 as follows.

[Error output]
alpha size = 4, name length = 6, total files = 4096, nproc=1
1023 files created
rm: cannot remove `/mnt/f2fs/permname.15150/a': Directory not empty

[Correct output]
alpha size = 4, name length = 6, total files = 4096, nproc=1
4097 files created

This bug is due to the misupdate of directory position in ctx.
So, this patch fixes this.

CC: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 9d1cd42..8008d60 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -634,7 +634,6 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 			if (bit_pos >= NR_DENTRY_IN_BLOCK)
 				break;
 
-			ctx->pos += bit_pos - start_bit_pos;
 			de = &dentry_blk->dentry[bit_pos];
 			if (de->file_type < F2FS_FT_MAX)
 				d_type = f2fs_filetype_table[de->file_type];
@@ -643,8 +642,10 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 			if (!dir_emit(ctx,
 				      dentry_blk->filename[bit_pos],
 				      le16_to_cpu(de->name_len),
-				      le32_to_cpu(de->ino), d_type))
+				      le32_to_cpu(de->ino), d_type)) {
+				ctx->pos += bit_pos - start_bit_pos;
 				goto success;
+			}
 			slots = GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 			bit_pos += slots;
 		}
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
