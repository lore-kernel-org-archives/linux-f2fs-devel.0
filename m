Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7710AFAD3E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Apr 2026 23:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RVNHXtTcu7NKzY2rT5oSXwL1Y57ZnDXnurXysMowguc=; b=Pop5sFgwYfcaMLDWw8G38CNBqe
	v7DdN3XKcP/PbdK78QP1+Ns42tUaRDI6wO661eMIxERc9IRtKo4zBelQxcxZnnqWTm72gDAIOvjTk
	6vhVWu07pP2DZzqMBUckF1eCh3Ho4kz2yFsUjztVfyUpOvFRd9r3iYywgs/DLmvv/Op8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFh9R-0006TA-7l;
	Wed, 22 Apr 2026 23:38:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wFh9O-0006T3-V9
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r5fNZ1WoBJb7qCdAvPaJiCbR/tSUHObc9XOETPiDC+s=; b=kM0bQWxoM66QJhwjKFQSYDlZQS
 pQNf3HYKe7sY6VsmjBhLl5wGJQmhInBeQ2ygJ0Jvh/8XHLqIQoklMXbGN9Mh8+bb6oTH2ubYhzKgu
 k1apa2kHOW7lWr4M6iJ/rC0bdIjblzP9JFAH6JXfKkNwVKGJI6GXENonBbnhFT7S2IoE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r5fNZ1WoBJb7qCdAvPaJiCbR/tSUHObc9XOETPiDC+s=; b=RZ2bRhZpT/zdAw4c4uK4MO/4aQ
 1nV49ikT6w9vK/R1jbBIISQHoL3zkb7LsJJ7MAJZEP4rz7ODN+wlw9Q2RooZPO96lkUC8s/2FYKO1
 I20wMtgcplzQs1nNhlurfCJUe7YQLBhIuoQWgUaObvohTb8WBLzoPThC5yZatU/3LBhQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFh9P-0007Cm-4Z for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 22 Apr 2026 23:38:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 478096186C;
 Wed, 22 Apr 2026 23:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08E0C19425;
 Wed, 22 Apr 2026 23:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776901104;
 bh=cA0ZR5J/e3BV4LxJ7qZBjOuZwp2IQKJzAscafkI55UU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ezVtpBVv1QMF6X9CFXadmDeGdwQ+lK71l5/X2+S0Y2NUH1w14TuTXFtm/J/iaIcGu
 EF5cAl6y2Vhv2hCcnNmgTxoIo1dwdxhPtlWq9cNpo4IM7RZ2+h76UMiOie6HmtapIl
 3HKX1mi1BY4P8U98ZIxqrv59ejKNYkgTyRrlkaaWeC8M9hf5SVq1yqT4N6R3WlgVa8
 1paua8ccPeMwKAurOHnqmV/AyxV0VYYPv23r0lnFDZt5eaLdWsIOFVXsa14SrCwQZ0
 MiM3BzfGaTinld59+KmN1n63TEaa1cSBjrbe1rwlsaABMnGhsmWaRILzz9nOn98xNq
 hFG3JN3FV+7SQ==
Date: Wed, 22 Apr 2026 16:38:23 -0700
To: Chuck Lever <cel@kernel.org>
Message-ID: <20260422233823.GA3778109@frogsfrogsfrogs>
References: <20260422-case-sensitivity-v9-0-be023cc070e2@oracle.com>
 <20260422-case-sensitivity-v9-1-be023cc070e2@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260422-case-sensitivity-v9-1-be023cc070e2@oracle.com>
X-Headers-End: 1wFh9P-0007Cm-4Z
Subject: Re: [f2fs-dev] [PATCH v9 01/17] fs: Move file_kattr initialization
 to callers
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jan Kara <jack@suse.cz>, pc@manguebit.org, yuezhang.mo@sony.com,
 cem@kernel.org, almaz.alexandrovich@paragon-software.com,
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, sfrench@samba.org,
 slava@dubeyko.com, linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 sprasad@microsoft.com, frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 22, 2026 at 07:29:55PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> fileattr_fill_xflags() and fileattr_fill_flags() memset the
> entire file_kattr struct before populating select fields, so
> callers cannot pre-set fields in fa->fsx_xflags without having
> their values clobbered. Darrick Wong noted that a function
> named "fill_xflags" touching more than xflags forces callers
> to know implementation details beyond its apparent scope.
> 
> Drop the memset from both fill functions and initialize at the
> entry points instead: ioctl_setflags(), ioctl_fssetxattr(),
> the file_setattr() syscall, and xfs_ioc_fsgetxattra() now
> declare fa with an aggregate initializer. ioctl_getflags(),
> ioctl_fsgetxattr(), and the file_getattr() syscall already
> aggregate-initialize fa to pass flags_valid/fsx_valid hints
> into vfs_fileattr_get().
> 
> Subsequent patches rely on this so that ->fileattr_get()
> handlers can set case-sensitivity flags (FS_XFLAG_CASEFOLD,
> FS_XFLAG_CASENONPRESERVING) in fa->fsx_xflags before the fill
> functions run.
> 
> Suggested-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Heh, I never did review this one so 
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/file_attr.c     | 12 ++++--------
>  fs/xfs/xfs_ioctl.c |  2 +-
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index da983e105d70..f429da66a317 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -15,12 +15,10 @@
>   * @fa:		fileattr pointer
>   * @xflags:	FS_XFLAG_* flags
>   *
> - * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
> - * other fields are zeroed.
> + * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
>   */
>  void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
>  {
> -	memset(fa, 0, sizeof(*fa));
>  	fa->fsx_valid = true;
>  	fa->fsx_xflags = xflags;
>  	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
> @@ -48,11 +46,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
>   * @flags:	FS_*_FL flags
>   *
>   * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> - * All other fields are zeroed.
>   */
>  void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
>  {
> -	memset(fa, 0, sizeof(*fa));
>  	fa->flags_valid = true;
>  	fa->flags = flags;
>  	if (fa->flags & FS_SYNC_FL)
> @@ -325,7 +321,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
>  {
>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>  	struct dentry *dentry = file->f_path.dentry;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	unsigned int flags;
>  	int err;
>  
> @@ -357,7 +353,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
>  {
>  	struct mnt_idmap *idmap = file_mnt_idmap(file);
>  	struct dentry *dentry = file->f_path.dentry;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	int err;
>  
>  	err = copy_fsxattr_from_user(&fa, argp);
> @@ -431,7 +427,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
>  	struct path filepath __free(path_put) = {};
>  	unsigned int lookup_flags = 0;
>  	struct file_attr fattr;
> -	struct file_kattr fa;
> +	struct file_kattr fa = {};
>  	int error;
>  
>  	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 46e234863644..ed9b4846c05f 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -517,7 +517,7 @@ xfs_ioc_fsgetxattra(
>  	xfs_inode_t		*ip,
>  	void			__user *arg)
>  {
> -	struct file_kattr	fa;
> +	struct file_kattr	fa = {};
>  
>  	xfs_ilock(ip, XFS_ILOCK_SHARED);
>  	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
> 
> -- 
> 2.53.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
