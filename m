From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] fscrypto: use dget_parent() in fscrypt_d_revalidate()
Date: Tue, 12 Apr 2016 16:31:23 -0700
Message-ID: <20160412233123.GA17607@jaegeuk.gateway>
References: <1460482042-14011-1-git-send-email-jaegeuk@kernel.org>
 <20160412223303.GQ25498@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160412223303.GQ25498@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Apr 12, 2016 at 11:33:03PM +0100, Al Viro wrote:
> On Tue, Apr 12, 2016 at 10:27:20AM -0700, Jaegeuk Kim wrote:
> > This patch updates fscrypto along with the below ext4 crypto change.
> > 
> > Fixes: 3d43bcfef5f0 ("ext4 crypto: use dget_parent() in ext4_d_revalidate()")
> 
> >  static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
> >  {
> > -	struct inode *dir = d_inode(dentry->d_parent);
> > -	struct fscrypt_info *ci = dir->i_crypt_info;
> > +	struct dentry *dir;
> > +	struct fscrypt_info *ci;
> >  	int dir_has_key, cached_with_key;
> >  
> > -	if (!dir->i_sb->s_cop->is_encrypted(dir))
> > +	dir = dget_parent(dentry);
> > +	if (!d_inode(dir)->i_sb->s_cop->is_encrypted(d_inode(dir))) {
> > +		dput(dir);
> 
> ... and as soon as you call it from RCU mode, you are screwed.

Thank you for pointing this out.
IIUC, did you mean this?

Thanks,

>From a0ac7972189b7c366720a0b456e39516d622a6d4 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 12 Apr 2016 16:05:36 -0700
Subject: [PATCH] ext4/fscrypto: avoid RCU lookup in d_revalidate

As Al pointed, d_revalidate should return RCU lookup before using d_inode.
This was originally introduced by:
commit 34286d666230 ("fs: rcu-walk aware d_revalidate method").

Reported-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: stable <stable@vger.kernel.org>
---
 fs/crypto/crypto.c | 4 ++++
 fs/ext4/crypto.c   | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index da70520..2fc8c43 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -26,6 +26,7 @@
 #include <linux/ratelimit.h>
 #include <linux/bio.h>
 #include <linux/dcache.h>
+#include <linux/namei.h>
 #include <linux/fscrypto.h>
 #include <linux/ecryptfs.h>
 
@@ -353,6 +354,9 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct fscrypt_info *ci;
 	int dir_has_key, cached_with_key;
 
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
 	dir = dget_parent(dentry);
 	if (!d_inode(dir)->i_sb->s_cop->is_encrypted(d_inode(dir))) {
 		dput(dir);
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index db9ae6e..6a6c273 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -32,6 +32,7 @@
 #include <linux/random.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock_types.h>
+#include <linux/namei.h>
 
 #include "ext4_extents.h"
 #include "xattr.h"
@@ -482,6 +483,9 @@ static int ext4_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct ext4_crypt_info *ci;
 	int dir_has_key, cached_with_key;
 
+	if (flags & LOOKUP_RCU)
+		return -ECHILD;
+
 	dir = dget_parent(dentry);
 	if (!ext4_encrypted_inode(d_inode(dir))) {
 		dput(dir);
-- 
2.6.3
