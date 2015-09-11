From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs crypto: allocate buffer for decrypting filename
Date: Fri, 11 Sep 2015 15:45:50 -0700
Message-ID: <20150911224550.GA73045@jaegeuk-mac02.mot.com>
References: <1441936062-69511-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1441936062-69511-1-git-send-email-jaegeuk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 o fix wrong pointer assignment

>From a0f3577cab882adc70d71e733d62c48aab61c3a4 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 3 Sep 2015 13:38:23 -0700
Subject: [PATCH] f2fs crypto: allocate buffer for decrypting filename

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
 fs/f2fs/dir.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8f15fc1..cce512c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -773,6 +773,7 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	unsigned int bit_pos;
 	struct f2fs_dir_entry *de = NULL;
 	struct f2fs_str de_name = FSTR_INIT(NULL, 0);
+	char *name = NULL;
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
@@ -788,8 +789,10 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			d_type = DT_UNKNOWN;
 
 		/* encrypted case */
-		de_name.name = d->filename[bit_pos];
 		de_name.len = le16_to_cpu(de->name_len);
+		name = kmalloc(de_name.len, GFP_NOFS);
+		memcpy(name, d->filename[bit_pos], de_name.len);
+		de_name.name = name;
 
 		if (f2fs_encrypted_inode(d->inode)) {
 			int save_len = fstr->len;
@@ -799,13 +802,18 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 							&de_name, fstr);
 			de_name = *fstr;
 			fstr->len = save_len;
-			if (ret < 0)
+			if (ret < 0) {
+				kfree(name);
 				return true;
+			}
 		}
 
 		if (!dir_emit(ctx, de_name.name, de_name.len,
-					le32_to_cpu(de->ino), d_type))
+					le32_to_cpu(de->ino), d_type)) {
+			kfree(name);
 			return true;
+		}
+		kfree(name);
 
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
-- 
2.1.1
