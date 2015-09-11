From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs crypto: allocate buffer for decrypting
	filename
Date: Thu, 10 Sep 2015 18:47:42 -0700
Message-ID: <1441936062-69511-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZaDRj-00067Q-Lf
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 01:48:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZaDRg-0000Ez-2h for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Sep 2015 01:48:11 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org

We got dentry pages from high_mem, and its address space directly goes into the
decryption path via f2fs_fname_disk_to_usr.
But, sg_init_one assumes the address is not from high_mem, so we can get this
panic since it doesn't call kmap_high but kunmap_high is triggered at the end.

kernel BUG at ../../../../../../kernel/mm/highmem.c:290!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
...
 (kunmap_high+0xb0/0xb8) from [<c0114534>] (__kunmap_atomic+0xa0/0xa4)
 (__kunmap_atomic+0xa0/0xa4) from [<c035f028>] (blkcipher_walk_done+0x128/0x1ec)
 (blkcipher_walk_done+0x128/0x1ec) from [<c0366c24>] (crypto_cbc_decrypt+0xc0/0x170)
 (crypto_cbc_decrypt+0xc0/0x170) from [<c0367148>] (crypto_cts_decrypt+0xc0/0x114)
 (crypto_cts_decrypt+0xc0/0x114) from [<c035ea98>] (async_decrypt+0x40/0x48)
 (async_decrypt+0x40/0x48) from [<c032ca34>] (f2fs_fname_disk_to_usr+0x124/0x304)
 (f2fs_fname_disk_to_usr+0x124/0x304) from [<c03056fc>] (f2fs_fill_dentries+0xac/0x188)
 (f2fs_fill_dentries+0xac/0x188) from [<c03059c8>] (f2fs_readdir+0x1f0/0x300)
 (f2fs_readdir+0x1f0/0x300) from [<c0218054>] (vfs_readdir+0x90/0xb4)
 (vfs_readdir+0x90/0xb4) from [<c0218418>] (SyS_getdents64+0x64/0xcc)
 (SyS_getdents64+0x64/0xcc) from [<c0105ba0>] (ret_fast_syscall+0x0/0x30)

Cc: <stable@vger.kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8f15fc1..f3fe1a1 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -788,8 +788,9 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			d_type = DT_UNKNOWN;
 
 		/* encrypted case */
-		de_name.name = d->filename[bit_pos];
 		de_name.len = le16_to_cpu(de->name_len);
+		de_name.name = kmalloc(de_name.len, GFP_NOFS);
+		memcpy(de_name.name, d->filename[bit_pos], de_name.len);
 
 		if (f2fs_encrypted_inode(d->inode)) {
 			int save_len = fstr->len;
@@ -799,13 +800,18 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 							&de_name, fstr);
 			de_name = *fstr;
 			fstr->len = save_len;
-			if (ret < 0)
+			if (ret < 0) {
+				kfree(de_name.name);
 				return true;
+			}
 		}
 
 		if (!dir_emit(ctx, de_name.name, de_name.len,
-					le32_to_cpu(de->ino), d_type))
+					le32_to_cpu(de->ino), d_type)) {
+			kfree(de_name.name);
 			return true;
+		}
+		kfree(de_name.name);
 
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
-- 
2.1.1


------------------------------------------------------------------------------
