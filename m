From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3] f2fs crypto: allocate buffer for
 decrypting filename
Date: Tue, 15 Sep 2015 09:52:15 -0700
Message-ID: <20150915165215.GA82346@jaegeuk-mac02.mot.com>
References: <1441936062-69511-1-git-send-email-jaegeuk@kernel.org>
	<20150911224550.GA73045@jaegeuk-mac02.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZbtSv-0001Gh-CS
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 16:52:21 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZbtSu-0002v2-91 for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 15 Sep 2015 16:52:21 +0000
Content-Disposition: inline
In-Reply-To: <20150911224550.GA73045@jaegeuk-mac02.mot.com>
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
Cc: stable@vger.kernel.org

Change log from v1:
  o fix wrong pointer assignment

Chang log from v2:
  o add one more missing call path: f2fs_encrypted_follow_link

>From 84574dd5c3e8ed9ca9fdfcbd251b354cdbc5ecab Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 3 Sep 2015 13:38:23 -0700
Subject: [PATCH 1/3] f2fs crypto: allocate buffer for decrypting filename

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
 fs/f2fs/dir.c   | 14 +++++++++++---
 fs/f2fs/namei.c |  8 +++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

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
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a680bf3..ebd612e 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -933,6 +933,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 	struct f2fs_encrypted_symlink_data *sd;
 	loff_t size = min_t(loff_t, i_size_read(inode), PAGE_SIZE - 1);
 	u32 max_size = inode->i_sb->s_blocksize;
+	char *name = NULL;
 	int res;
 
 	res = f2fs_get_encryption_info(inode);
@@ -947,8 +948,10 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 
 	/* Symlink is encrypted */
 	sd = (struct f2fs_encrypted_symlink_data *)caddr;
-	cstr.name = sd->encrypted_path;
 	cstr.len = le16_to_cpu(sd->len);
+	name = kmalloc(cstr.len, GFP_NOFS);
+	memcpy(name, sd->encrypted_path, cstr.len);
+	cstr.name = name;
 
 	/* this is broken symlink case */
 	if (cstr.name[0] == 0 && cstr.len == 0) {
@@ -970,6 +973,8 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 	if (res < 0)
 		goto errout;
 
+	kfree(name);
+
 	paddr = pstr.name;
 
 	/* Null-terminate the name */
@@ -979,6 +984,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 	page_cache_release(cpage);
 	return *cookie = paddr;
 errout:
+	kfree(name);
 	f2fs_fname_crypto_free_buffer(&pstr);
 	kunmap(cpage);
 	page_cache_release(cpage);
-- 
2.1.1


------------------------------------------------------------------------------
