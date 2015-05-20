From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/4] f2fs crypto: add two spinlocks to avoid data
	races
Date: Tue, 19 May 2015 17:43:24 -0700
Message-ID: <1432082606-55975-2-git-send-email-jaegeuk@kernel.org>
References: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Yus6s-0006cT-8o
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 00:43:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yus6q-0004Ql-6v for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 20 May 2015 00:43:46 +0000
In-Reply-To: <1432082606-55975-1-git-send-email-jaegeuk@kernel.org>
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

Previoulsy, fi->i_crypt_info and tfm allocation were not covered by any lock,
resulting in memory leak when multiple threads try to allocate at the same time.

=============================================================================
BUG f2fs_crypt_info (Tainted: G           O   ): Objects remaining in
 f2fs_crypt_info on kmem_cache_close()
-----------------------------------------------------------------------------
  Disabling lock debugging due to kernel taint
  CPU: 3 PID: 26284 Comm: rmmod Tainted: G    B      O    4.1.0-rc2+ #20
  Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
  ffff8800376d98c0 ffff88001dd13d38 ffffffff817ffd6a 0000000000000001
  ffffea00007d6a80 ffff88001dd13e08 ffffffff81218ac0 ffff880000000020
  ffff88001dd13e18 ffff88001dd13dc8 656a624f001a0000 616d657220737463
  Call Trace:
  [<ffffffff817ffd6a>] dump_stack+0x4f/0x7b
  [<ffffffff81218ac0>] slab_err+0xa0/0xb0
  [<ffffffff8121c89c>] ? __kmalloc+0x37c/0x3d0
  [<ffffffff8121dcd6>] ? __kmem_cache_shutdown+0x126/0x340
  [<ffffffff8121dcd6>] ? __kmem_cache_shutdown+0x126/0x340
  [<ffffffff8121dcf6>] __kmem_cache_shutdown+0x146/0x340
  [<ffffffff811e3079>] ? kmem_cache_destroy+0x39/0x130
  [<ffffffff811e30e8>] kmem_cache_destroy+0xa8/0x130
  [<ffffffffa03a0801>] f2fs_exit_crypto+0x41/0x50 [f2fs]
  [<ffffffffa03a1e2a>] exit_f2fs_fs+0x28/0x1fe [f2fs]
  [<ffffffff8113125c>] SyS_delete_module+0x18c/0x210
  [<ffffffff8180b532>] system_call_fastpath+0x16/0x7a
 INFO: Object 0xffff88001f5ab3e0 @offset=5088
 INFO: Allocated in _f2fs_get_encryption_info+0x97/0x260 [f2fs]
   __slab_alloc+0x4bd/0x562
   kmem_cache_alloc+0x2a4/0x390
   _f2fs_get_encryption_info+0x97/0x260 [f2fs]
   f2fs_file_open+0x57/0x70 [f2fs]
   do_dentry_open+0x257/0x350
   vfs_open+0x49/0x50
   do_last+0x208/0x13e0
   path_openat+0x84/0x660
   do_filp_open+0x3a/0x90
   do_sys_open+0x128/0x220
   SyS_creat+0x1e/0x20
   system_call_fastpath+0x16/0x7a

 INFO: Freed in f2fs_free_encryption_info+0x52/0x70 [f2fs]
   __slab_free+0x39/0x214
   kmem_cache_free+0x394/0x3a0
   f2fs_free_encryption_info+0x52/0x70 [f2fs]
   f2fs_evict_inode+0x15a/0x460 [f2fs]
   evict+0xb8/0x190
   iput+0x30e/0x3f0
   d_delete+0x178/0x1b0
   vfs_rmdir+0x122/0x140
   do_rmdir+0x1fb/0x220
   SyS_rmdir+0x16/0x20
   system_call_fastpath+0x16/0x7a

This patch adds one rwlock and one spinlock to avoid leaking objects.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/crypto.c       | 11 ++++++++++-
 fs/f2fs/crypto_fname.c | 10 +++++++++-
 fs/f2fs/crypto_key.c   | 32 +++++++++++++++++++++++---------
 fs/f2fs/f2fs.h         |  2 ++
 fs/f2fs/super.c        |  2 ++
 5 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index c0c5fd2..5a614fe 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -104,6 +104,7 @@ int f2fs_setup_crypto(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_crypt_info *ci;
 	struct crypto_ablkcipher *ctfm;
+	bool free = false;
 	int res;
 
 	res = f2fs_get_encryption_info(inode);
@@ -140,7 +141,15 @@ int f2fs_setup_crypto(struct inode *inode)
 		crypto_free_ablkcipher(ctfm);
 		return -EIO;
 	}
-	ci->ci_ctfm = ctfm;
+
+	spin_lock(&fi->crypto_tfmlock);
+	if (ci->ci_ctfm)
+		free = true;
+	else
+		ci->ci_ctfm = ctfm;
+	spin_unlock(&fi->crypto_tfmlock);
+	if (free)
+		crypto_free_ablkcipher(ctfm);
 	return 0;
 }
 
diff --git a/fs/f2fs/crypto_fname.c b/fs/f2fs/crypto_fname.c
index 016c4b6..dd73c81 100644
--- a/fs/f2fs/crypto_fname.c
+++ b/fs/f2fs/crypto_fname.c
@@ -254,6 +254,7 @@ int f2fs_setup_fname_crypto(struct inode *inode)
 	struct f2fs_inode_info *fi = F2FS_I(inode);
 	struct f2fs_crypt_info *ci = fi->i_crypt_info;
 	struct crypto_ablkcipher *ctfm;
+	bool free = false;
 	int res;
 
 	/* Check if the crypto policy is set on the inode */
@@ -291,7 +292,14 @@ int f2fs_setup_fname_crypto(struct inode *inode)
 		crypto_free_ablkcipher(ctfm);
 		return -EIO;
 	}
-	ci->ci_ctfm = ctfm;
+	spin_lock(&fi->crypto_tfmlock);
+	if (ci->ci_ctfm)
+		free = true;
+	else
+		ci->ci_ctfm = ctfm;
+	spin_unlock(&fi->crypto_tfmlock);
+	if (free)
+		crypto_free_ablkcipher(ctfm);
 	return 0;
 }
 
diff --git a/fs/f2fs/crypto_key.c b/fs/f2fs/crypto_key.c
index 8a10569..2f5a45b 100644
--- a/fs/f2fs/crypto_key.c
+++ b/fs/f2fs/crypto_key.c
@@ -114,17 +114,19 @@ int _f2fs_get_encryption_info(struct inode *inode)
 	struct f2fs_encryption_context ctx;
 	struct user_key_payload *ukp;
 	int res;
+	bool drop = false;
 
 	res = f2fs_crypto_initialize();
 	if (res)
 		return res;
 
-	if (fi->i_crypt_info) {
-		if (!fi->i_crypt_info->ci_keyring_key ||
-			key_validate(fi->i_crypt_info->ci_keyring_key) == 0)
-			return 0;
-		f2fs_free_encryption_info(inode);
+	read_lock(&fi->crypto_lock);
+	if (fi->i_crypt_info && (!fi->i_crypt_info->ci_keyring_key ||
+			key_validate(fi->i_crypt_info->ci_keyring_key) == 0)) {
+		read_unlock(&fi->crypto_lock);
+		return 0;
 	}
+	read_unlock(&fi->crypto_lock);
 
 	res = f2fs_getxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
 				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
@@ -187,18 +189,30 @@ out:
 			res = 0;
 		kmem_cache_free(f2fs_crypt_info_cachep, crypt_info);
 	} else {
-		fi->i_crypt_info = crypt_info;
-		crypt_info->ci_keyring_key = keyring_key;
-		keyring_key = NULL;
+		write_lock(&fi->crypto_lock);
+		if (fi->i_crypt_info) {
+			drop = true;
+		} else {
+			fi->i_crypt_info = crypt_info;
+			crypt_info->ci_keyring_key = keyring_key;
+			keyring_key = NULL;
+		}
+		write_unlock(&fi->crypto_lock);
 	}
 	if (keyring_key)
 		key_put(keyring_key);
+	if (drop)
+		kmem_cache_free(f2fs_crypt_info_cachep, crypt_info);
 	return res;
 }
 
 int f2fs_has_encryption_key(struct inode *inode)
 {
 	struct f2fs_inode_info *fi = F2FS_I(inode);
+	int ret;
 
-	return (fi->i_crypt_info != NULL);
+	read_lock(&fi->crypto_lock);
+	ret = (fi->i_crypt_info != NULL);
+	read_unlock(&fi->crypto_lock);
+	return ret;
 }
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 801afcb..34a968b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -431,6 +431,8 @@ struct f2fs_inode_info {
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	/* Encryption params */
 	struct f2fs_crypt_info *i_crypt_info;
+	rwlock_t crypto_lock;		/* lock for crypt_info */
+	spinlock_t crypto_tfmlock;	/* lock for crypto tfm allocation */
 #endif
 };
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbeb6d7..ae14fc4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -418,6 +418,8 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 #ifdef CONFIG_F2FS_FS_ENCRYPTION
 	fi->i_crypt_info = NULL;
+	rwlock_init(&fi->crypto_lock);
+	spin_lock_init(&fi->crypto_tfmlock);
 #endif
 	return &fi->vfs_inode;
 }
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
