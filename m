Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38CADFF8860
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kd3BRCn4A7+4baSrdMXpgcumYifm6C3v4z+ITFgy1P0=; b=cR4/R6PTktdYlknDhdT23uJJUG
	lNT4YUrhDNR7Ibp8o5TwdRpuz3kaHv6o1hEsZr5Q3OfX9OK54CWpZNhEfINAaOa9+SZupYo2zZw4S
	o+Co8OTsC3ABsK2u1ZUwPxMQkdLIM12p08yb13Wd6e/JkXKYJPSWPfnisTJudAs0DNFM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHOKK-0006WC-B8;
	Mon, 27 Apr 2026 15:56:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1wHOKI-0006W6-Nq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 15:56:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O1z5RvPQPoyZZC4Dm9QB0boKqMzZHCOPlV1jsRvLJ3A=; b=LwvT9fwZSK2gYENquxhmKUv4bd
 vnphWsFwgOjKY5esVF0Q+3v6hspJg+d/rlhfbiJWP6M+1pWYNPUWqSZ69EsAbB4thMzbkY8Wg72SO
 Lfd+sSP0rOxtN0O9wrwfEyUAdLSvWUDIFdKlwNp4HKB5Z6lzqOxdCwMYjWO0z+muwMOI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=O1z5RvPQPoyZZC4Dm9QB0boKqMzZHCOPlV1jsRvLJ3A=; b=RaNLkGcFEFa0G3oEhk8jgqv5Ar
 TbyTAzfFkbdN2XcDAg54U2TDubXh+FgZkkg5cdgw5Xcw15MPXOi0hroeJWEGFZfcZHVSaU514XZvD
 1aE16Gsp6bkOOrqevK5fCyFJe+cZPTGPfU76nKGufNyHTxsgCPNdpNvQMggMIekKCaDw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wHOKF-0002r8-JT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 15:56:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2887B43B3F;
 Mon, 27 Apr 2026 15:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ADFC19425;
 Mon, 27 Apr 2026 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777305397;
 bh=Zz8Qb+L+a6t6/LZ2gpOvq36I/oARw1YWvWvpPUd8Taw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KuiMFGhhZMhfF4cpbnvg34N+nWG4ckxtWlgEsSJSo8lrJn1WrrC21FCMUKvoWHc6a
 VXNYvv+TI2vivTAogG5fVhZZm8Q6m/XaHPK2M0KNeItNGc2tDUwxnimhGxrQ55KmBk
 QV1jyEdOnMUUXPAM3CdguB9xwM8gMnmibDlfd4POipt7r20r4s/VkjQg3sdKEqY3JB
 iyQwLnIFPdI37sq0FnlfBjRf5o8IcNj9c1F7hl3FZJcF0uWsyGShf28J5+euuE7Ea+
 +GQ3062oVXFnCblu3RlRACujnsY5albUCT4Pkla85PEJfP6zv/KSvZM4Ne/B6iDEpg
 Rf9Usmw5ML5vw==
Date: Mon, 27 Apr 2026 08:56:36 -0700
To: Chuck Lever <cel@kernel.org>
Message-ID: <20260427155636.GC7751@frogsfrogsfrogs>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <20260424-case-sensitivity-v11-8-de5619beddaf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424-case-sensitivity-v11-8-de5619beddaf@oracle.com>
X-Headers-End: 1wHOKF-0002r8-JT
Subject: Re: [f2fs-dev] [PATCH v11 08/15] xfs: Report case sensitivity in
 fileattr_get
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
 cem@kernel.org, Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, linux-nfs@vger.kernel.org,
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

On Fri, Apr 24, 2026 at 09:53:10PM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Upper layers such as NFSD need to query whether a filesystem
> is case-sensitive. Add FS_XFLAG_CASEFOLD to xfs_ip2xflags()
> when the filesystem is formatted with the ASCIICI feature
> flag. This serves both FS_IOC_FSGETXATTR (via xfs_fill_fsxattr() in
> xfs_fileattr_get()) and XFS_IOC_BULKSTAT (which populates bs_xflags
> directly from xfs_ip2xflags()), so bulkstat consumers and per-inode
> queries see a consistent view of the filesystem's case-folding
> behavior.
> 
> XFS always preserves case. XFS is case-sensitive by default, but
> supports ASCII case-insensitive lookups when formatted with the
> ASCIICI feature flag.
> 
> Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/xfs/libxfs/xfs_inode_util.c | 2 ++
>  fs/xfs/xfs_ioctl.c             | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/fs/xfs/libxfs/xfs_inode_util.c b/fs/xfs/libxfs/xfs_inode_util.c
> index 551fa51befb6..82be54b6f8d3 100644
> --- a/fs/xfs/libxfs/xfs_inode_util.c
> +++ b/fs/xfs/libxfs/xfs_inode_util.c
> @@ -130,6 +130,8 @@ xfs_ip2xflags(
>  
>  	if (xfs_inode_has_attr_fork(ip))
>  		flags |= FS_XFLAG_HASATTR;
> +	if (xfs_has_asciici(ip->i_mount))
> +		flags |= FS_XFLAG_CASEFOLD;
>  	return flags;
>  }
>  
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index ed9b4846c05f..5a58fb0bad2b 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -472,6 +472,13 @@ xfs_fill_fsxattr(
>  
>  	fileattr_fill_xflags(fa, xfs_ip2xflags(ip));
>  
> +	/*
> +	 * FS_XFLAG_CASEFOLD is read-only; hide it from the legacy
> +	 * flags view so chattr's RMW cycle does not pass it back to
> +	 * xfs_fileattr_set().
> +	 */
> +	fa->flags &= ~FS_CASEFOLD_FL;

I don't understand this at all.  Yes, FS_XFLAG_CASEFOLD is readonly, but
how does clearing FS_CASEFOLD_FL from the fileattr_get output (without
clearing XFLAG_CASEFOLD!) solve anything?  This makes the reported
output inconsistent between fsgetxattr and getflags -- one reports case
folding, the other reports no casefolding.

If you want to avoid fileattr_set returning EINVAL when setting
attributes due to the casefold flag, then don't you want to check the
flag state vs. xfs_has_asciici() in the *fileattr_set* path?

--D

> +
>  	if (ip->i_diflags & XFS_DIFLAG_EXTSIZE) {
>  		fa->fsx_extsize = XFS_FSB_TO_B(mp, ip->i_extsize);
>  	} else if (ip->i_diflags & XFS_DIFLAG_EXTSZINHERIT) {
> 
> -- 
> 2.53.0
> 
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
