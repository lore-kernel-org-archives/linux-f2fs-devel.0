Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151E2E9A03E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ezv5GKt3a2dOw62qdJemZgqY+f+ZiGcw5ft6GNAprmA=; b=Q6Xq52wUWHLJJHZdno+6SjEmUx
	hr/fspL4LwGDR8pKuxOp/OlXSdNKuLFdgWiyllWrPClxplfYqY12lj89X6oF1Wp4qRmonLMy0TRwJ
	4455p1Ah8/OwK7/zBiX/q9eK4kPAKWN+nG3pw9abYE6GlyoKft18G/hQQjsCj1BPj9X0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vsSvF-00073o-0S;
	Tue, 17 Feb 2026 21:47:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vsSvD-00073e-3M
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:47:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C9lFiR/76UieHkY9rgBrSmf8X5TAjyrgwYvNhnTikeg=; b=mkiElYJDD9EfXVrNh1NvI1qK2x
 cdrJmII1YIxXbyG3uNQf+mfAMkozvIxz7jNZehzRWNf4q7aTGplzgop2lHhEC2mOuaeFtHa11xo5r
 YneFB4qi1uTA+MJfjQASvmXpjRFzCH098VuGwUYb+aVZakX7MR3rRaSN1Q3Im38UgVBI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C9lFiR/76UieHkY9rgBrSmf8X5TAjyrgwYvNhnTikeg=; b=d8DLRssFK1/0sNSCGwR14ZWprv
 yF9q0DfSoXk+PwgK8JX2t5G4YYWUlNB59sT1MDBgqF89JcbYWiZhlM0kxC+5ITi752yNrNQyjN6Y8
 wYv9ZQMlQtKQsUyqp+BItCrY8dGL7VqzLRNPvncS27Gj+T4erTi/VJzWEjdU35qXFWJY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vsSvC-0002rz-JN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Feb 2026 21:47:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 071844322B;
 Tue, 17 Feb 2026 21:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4A2C19421;
 Tue, 17 Feb 2026 21:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771364868;
 bh=LctAiSd9BeDNjjjmUFC0gRSRPzBQHPUhz2MMJP2LiZ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ACVk7zGO8Dvjx8+P4M4/0bzCltWT475XNNKSF6yfMizGEZZgP//NxuF4Cb+eRrosZ
 pJA2vtZNd9TvSzcMuXg3ghwDJHyvFGUZcVescGoarZpyQV1r9mOSl79rlbHvBBfDyB
 Cc/J6x62SFD6ufA7WFHs9uQVScYU7wbIZ8C30vGIsYXgMv0eIz8E0YFfiUg84KQMnT
 50RhjiOPfJ4fymbO8V5Apyr3qcrn4LhY3UPg9X5JFPj/i3Vr3X8FdYyF+wqpZOEWfP
 FiyONdpkAkAfZevczJhlYl7XzAj0VQEb4cg5BlXLcgnSlil2/91cHl74i5G5DdTzyP
 jvLmt1WWdpvIA==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Tue, 17 Feb 2026 16:47:25 -0500
Message-ID: <20260217214741.1928576-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217214741.1928576-1-cel@kernel.org>
References: <20260217214741.1928576-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vsSvC-0002rz-JN
Subject: [f2fs-dev] [PATCH v8 01/17] fs: Move file_kattr initialization to
 callers
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, sprasad@microsoft.com, frank.li@vivo.com,
 ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org,
 hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

fileattr_fill_xflags() and fileattr_fill_flags() zero the entire
file_kattr struct before populating select fields. This behavior
prevents callers from setting flags in fa->fsx_xflags before
calling these helpers; the zeroing clears any pre-set values.

As Darrick Wong observed, when a function named "fill_xflags"
modifies more than just xflags, filesystems must understand
implementation details beyond the function's apparent scope. When
initialization occurs at entry points, helper functions need not
duplicate that zeroing.

Move struct file_kattr zero-initialization from the fill functions
to their callers. Entry points such as ioctl_setflags(),
ioctl_fssetxattr(), and the file_getattr/file_setattr syscalls
now perform aggregate initialization directly. The fill functions
retain their field-setting logic but no longer clear the struct.

This change enables subsequent patches where filesystem
->fileattr_get() handlers can set case-sensitivity flags
(FS_XFLAG_CASEFOLD, FS_XFLAG_CASENONPRESERVING) in fa->fsx_xflags
before calling the fill functions.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c     | 14 +++++---------
 fs/xfs/xfs_ioctl.c |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 6d2a298a786d..42aa511111a0 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -15,12 +15,10 @@
  * @fa:		fileattr pointer
  * @xflags:	FS_XFLAG_* flags
  *
- * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
- * other fields are zeroed.
+ * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
  */
 void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
 {
-	memset(fa, 0, sizeof(*fa));
 	fa->fsx_valid = true;
 	fa->fsx_xflags = xflags;
 	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
@@ -48,11 +46,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
  * @flags:	FS_*_FL flags
  *
  * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
- * All other fields are zeroed.
  */
 void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
 {
-	memset(fa, 0, sizeof(*fa));
 	fa->flags_valid = true;
 	fa->flags = flags;
 	if (fa->flags & FS_SYNC_FL)
@@ -325,7 +321,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	unsigned int flags;
 	int err;
 
@@ -357,7 +353,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int err;
 
 	err = copy_fsxattr_from_user(&fa, argp);
@@ -378,7 +374,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct path filepath __free(path_put) = {};
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
@@ -431,7 +427,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	struct path filepath __free(path_put) = {};
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 4eeda4d4e3ab..369555275140 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -498,7 +498,7 @@ xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
 	void			__user *arg)
 {
-	struct file_kattr	fa;
+	struct file_kattr	fa = {};
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
 	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
