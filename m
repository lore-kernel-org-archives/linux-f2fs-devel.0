From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v4] f2fs crypto: allocate buffer for
 decrypting filename
Date: Wed, 16 Sep 2015 10:57:15 -0700
Message-ID: <20150916175715.GA99097@jaegeuk-mac02.mot.com>
References: <1441936062-69511-1-git-send-email-jaegeuk@kernel.org>
	<20150911224550.GA73045@jaegeuk-mac02.mot.com>
	<20150915165215.GA82346@jaegeuk-mac02.mot.com>
	<000901d0f068$1a1bd100$4e537300$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZcGxQ-00064Y-Lt
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Sep 2015 17:57:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZcGxP-0005jQ-EF for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 16 Sep 2015 17:57:24 +0000
Content-Disposition: inline
In-Reply-To: <000901d0f068$1a1bd100$4e537300$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Thanks Chao,

Change log from v3:
  o enhance the code with proper error handling

Change log from v1:
  o fix wrong pointer assignment
 
Chang log from v2:
  o add one more missing call path: f2fs_encrypted_follow_link

>From efdbbbb4c9bb6519e3c10ec5081a2dcdbaca81d2 Mon Sep 17 00:00:00 2001
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
 fs/f2fs/dir.c   | 13 ++++++++++---
 fs/f2fs/namei.c | 10 +++++++++-
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 8f15fc1..6726c4a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -787,7 +787,6 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 		else
 			d_type = DT_UNKNOWN;
 
-		/* encrypted case */
 		de_name.name = d->filename[bit_pos];
 		de_name.len = le16_to_cpu(de->name_len);
 
@@ -795,12 +794,20 @@ bool f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 			int save_len = fstr->len;
 			int ret;
 
+			de_name.name = kmalloc(de_name.len, GFP_NOFS);
+			if (!de_name.name)
+				return false;
+
+			memcpy(de_name.name, d->filename[bit_pos], de_name.len);
+
 			ret = f2fs_fname_disk_to_usr(d->inode, &de->hash_code,
 							&de_name, fstr);
-			de_name = *fstr;
-			fstr->len = save_len;
+			kfree(de_name.name);
 			if (ret < 0)
 				return true;
+
+			de_name = *fstr;
+			fstr->len = save_len;
 		}
 
 		if (!dir_emit(ctx, de_name.name, de_name.len,
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a680bf3..dfa01c8 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -947,8 +947,13 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 
 	/* Symlink is encrypted */
 	sd = (struct f2fs_encrypted_symlink_data *)caddr;
-	cstr.name = sd->encrypted_path;
 	cstr.len = le16_to_cpu(sd->len);
+	cstr.name = kmalloc(cstr.len, GFP_NOFS);
+	if (!cstr.name) {
+		res = -ENOMEM;
+		goto errout;
+	}
+	memcpy(cstr.name, sd->encrypted_path, cstr.len);
 
 	/* this is broken symlink case */
 	if (cstr.name[0] == 0 && cstr.len == 0) {
@@ -970,6 +975,8 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 	if (res < 0)
 		goto errout;
 
+	kfree(cstr.name);
+
 	paddr = pstr.name;
 
 	/* Null-terminate the name */
@@ -979,6 +986,7 @@ static const char *f2fs_encrypted_follow_link(struct dentry *dentry, void **cook
 	page_cache_release(cpage);
 	return *cookie = paddr;
 errout:
+	kfree(cstr.name);
 	f2fs_fname_crypto_free_buffer(&pstr);
 	kunmap(cpage);
 	page_cache_release(cpage);
-- 
2.1.1


------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140
