Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72414D3EE89
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uWNh90yGwB4ek3lOOp/u5wW9RwSsiygy6A0k2at7LUU=; b=K5w9eGFX9Sh6jf5eRDMCz9ZtDr
	S8XXIstwuqgr9lN81Yf6IEei08pifETzN5lUCXmqKlsK9S/F4sTM1JMPKapni8tSSoxTMMI7cY5KE
	25RPL7GpOEOO9LoJuxwq0VzFynu7UIlg38C6VOTZzdOODt/A/ErY1OW4EmtiUoVaBNPs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vix9a-0000N6-Om;
	Thu, 22 Jan 2026 16:03:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vix9Y-0000My-W9
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 16:03:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=beQkWM9/YZbwbOPM/2lKmFBj2aAGpKVYujt9J4w94Lo=; b=e5UTPPphpO5tpuytp93jS3j9AL
 zbDeN3VsqLGPgwxZkl09CeNHgQyWPBj0nXIC1anlWr5qWpQhDY7+UbVra1pwjWczdumDsM4RGhttY
 LyTVydOgQFLW/hM724MSezjLldx30vDfgvpmumLgw7iR27aSTaVP5lJdSGElnchp862o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=beQkWM9/YZbwbOPM/2lKmFBj2aAGpKVYujt9J4w94Lo=; b=hV70ylW5gHOOfUIbkM4NZNkF/c
 B6/yqTpRrrchfgy1Y95ZsIiN03jWz5LrjVfR7GFha/0pna7EmfwFK2FOPQ7B4vpPWHYIsewGRZ7Pc
 1qeokgpLbCjqp+J+pNRIImVjxkJrk7WcD32jJ+mBG7BY29iCjruDrdSqEXZlihmkNPMk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vix9Y-0000UW-Cg for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 16:03:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F04C600C4;
 Thu, 22 Jan 2026 16:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F66C19423;
 Thu, 22 Jan 2026 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769097798;
 bh=Wo5lloV0KSGzxOB6thbFAC7r4tmGkmKAHZEdL5z/ptg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pfyZKRd/bSRobKFlKCkOH3T39xUOdLeowMA6HibhxrOLlvMe0GMk7aivFQUBMkkRg
 EBxuqSTY2Si4dPw+PMAHe3nDjztcQhQfa7ETznO9JyxTUcnKTIT18fq9wi3/jj7idW
 UhECuFBPwkPb41zTT0GfdT1H48GQIpMg6eXYVtMDw7TZ1BlvWWuppYAGcDFtCpGft3
 WcO91qUNn/xKeYC/7GhEXYbxEJgzrRGaqfMrXCu7ZXXBvukSXjMNNiVpcJK3qD0MdY
 ylmkGwjub15rZJVauERLFDnPHjtpPBlJIelza6XwfoguupwnnXlvQ4/7ssT4hLIcp3
 rugwpN056uCzg==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Thu, 22 Jan 2026 11:02:56 -0500
Message-ID: <20260122160311.1117669-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122160311.1117669-1-cel@kernel.org>
References: <20260122160311.1117669-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vix9Y-0000UW-Cg
Subject: [f2fs-dev] [PATCH v7 01/16] fs: Add case sensitivity flags to
 file_kattr
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
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Enable upper layers such as NFSD to retrieve case sensitivity
information from file systems by adding FS_XFLAG_CASEFOLD and
FS_XFLAG_CASENONPRESERVING flags.

Filesystems report case-insensitive or case-nonpreserving behavior
by setting these flags directly in fa->fsx_xflags. The default
(flags unset) indicates POSIX semantics: case-sensitive and
case-preserving. These flags are read-only; userspace cannot set
them via ioctl.

Remove struct file_kattr initialization from fileattr_fill_xflags()
and fileattr_fill_flags(). Callers at ioctl/syscall entry points
zero-initialize the struct themselves, which allows them to pass
hints (flags_valid, fsx_valid) to the filesystem's ->fileattr_get()
callback via the fa argument. Filesystem handlers that invoke these
fill functions can now set flags directly in fa->fsx_xflags before
calling them, without the fill functions zeroing those values.

Case sensitivity information is exported to userspace via the
fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
system call.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c           | 12 ++++--------
 fs/xfs/xfs_ioctl.c       |  2 +-
 include/linux/fileattr.h |  3 ++-
 include/uapi/linux/fs.h  |  2 ++
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..6e37040fc5fa 100644
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
@@ -46,11 +44,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
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
@@ -323,7 +319,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	unsigned int flags;
 	int err;
 
@@ -355,7 +351,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int err;
 
 	err = copy_fsxattr_from_user(&fa, argp);
@@ -434,7 +430,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	struct filename *name __free(putname) = NULL;
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 59eaad774371..f0417c4d1fca 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -496,7 +496,7 @@ xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
 	void			__user *arg)
 {
-	struct file_kattr	fa;
+	struct file_kattr	fa = {};
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
 	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index f89dcfad3f8f..709de829659f 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -16,7 +16,8 @@
 
 /* Read-only inode flags */
 #define FS_XFLAG_RDONLY_MASK \
-	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR)
+	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | \
+	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
 
 /* Flags to indicate valid value of fsx_ fields */
 #define FS_XFLAG_VALUES_MASK \
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 66ca526cf786..919148beaa8c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -253,6 +253,8 @@ struct file_attr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_CASEFOLD	0x00020000	/* case-insensitive lookups */
+#define FS_XFLAG_CASENONPRESERVING 0x00040000	/* case not preserved */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
