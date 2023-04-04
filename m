Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C1EC761A6
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 16:11:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjjFM-0002Oq-Ls;
	Tue, 04 Apr 2023 16:10:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1pjjFI-0002OY-8L
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 16:10:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XLWINjfscug+jep0oynm/sYycFPlCFuYdV91L0dpTvE=; b=irIWhZ1aj020eXRiNMVIJL2qGa
 tHb7QORhtGY7Ibyju5ng4FYCV31PuzFYt8BS21iOfMfgr92cSC+mFkfr3i2Y1gZsyKRp+hmExfEMY
 rAhtrLfanXHzDeZQ0fpZa0JRVtBlXvB4P1f/W5E99RfRI32yoWyziedRYf+O2BMrYDfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XLWINjfscug+jep0oynm/sYycFPlCFuYdV91L0dpTvE=; b=EyT4RfkEV16Cf5JJfPGjgw2KZ9
 Tka/95bLP9xZh2XAXLdzsAFQ3c88kZ4eXPp1O7mDMw0wq3ZyzeKx/ykPRcwkm6ZbWlZaNd5PQU3cB
 H8g5VlsYlADfAcidhrxiHKkAX2RL8Ey5lllEd/g6D43kTOnTK34VzcpeaS/KVstS9RPM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjjFG-00F4WB-QO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 16:10:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4C2CA636A6;
 Tue,  4 Apr 2023 16:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4C9C433EF;
 Tue,  4 Apr 2023 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680624647;
 bh=cBqdfxJ4/qr/q04Tci5Hs37l8eHYTOelhRrgiW3Uwf4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qgHRWLTCkqbhQJVQYOFgw7vgvG+evZpMFPQE3BK+NKfG3cv7mkTYvSjSZwUJVW74F
 K14dkJfauCFJHDDCUXlIxSRzdyH2edPaV9HANIzKMvT9IAgdDnDE1HqEUc02iReeaJ
 orYrmNkHGPGryJLpjJ7qvF6bBuxz5aNV69iyq9YN3D+pp0G3uDdF4psOaXxuZC9vXM
 nRMQHt/XeB26wxV2sQX9DGIph62bdZ4eJDYVwpAfkJPWXzs3LngddHSAWGo1p81PYw
 rCo6ejeqCtXdG61LFdDonKljtov+H9DP8RMw0QnrckE5J96shsm1Ah2uROts9KXiXW
 TqnbqfF1/V+UA==
Date: Tue, 4 Apr 2023 09:10:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20230404161047.GA109974@frogsfrogsfrogs>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
 <20230404145319.2057051-20-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404145319.2057051-20-aalbersh@redhat.com>
X-Headers-End: 1pjjFG-00F4WB-QO
Subject: Re: [f2fs-dev] [PATCH v2 19/23] xfs: disable direct read path for
 fs-verity sealed files
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
Cc: fsverity@lists.linux.dev, hch@infradead.org, linux-ext4@vger.kernel.org,
 agruenba@redhat.com, damien.lemoal@opensource.wdc.com,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 cluster-devel@redhat.com, dchinner@redhat.com, rpeterso@redhat.com,
 xiang@kernel.org, jth@kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 04, 2023 at 04:53:15PM +0200, Andrey Albershteyn wrote:
> The direct path is not supported on verity files. Attempts to use direct
> I/O path on such files should fall back to buffered I/O path.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> ---
>  fs/xfs/xfs_file.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 947b5c436172..9e072e82f6c1 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -244,7 +244,8 @@ xfs_file_dax_read(
>  	struct kiocb		*iocb,
>  	struct iov_iter		*to)
>  {
> -	struct xfs_inode	*ip = XFS_I(iocb->ki_filp->f_mapping->host);
> +	struct inode		*inode = iocb->ki_filp->f_mapping->host;
> +	struct xfs_inode	*ip = XFS_I(inode);
>  	ssize_t			ret = 0;
>  
>  	trace_xfs_file_dax_read(iocb, to);
> @@ -297,10 +298,17 @@ xfs_file_read_iter(
>  
>  	if (IS_DAX(inode))
>  		ret = xfs_file_dax_read(iocb, to);
> -	else if (iocb->ki_flags & IOCB_DIRECT)
> +	else if (iocb->ki_flags & IOCB_DIRECT && !fsverity_active(inode))
>  		ret = xfs_file_dio_read(iocb, to);
> -	else
> +	else {
> +		/*
> +		 * In case fs-verity is enabled, we also fallback to the
> +		 * buffered read from the direct read path. Therefore,
> +		 * IOCB_DIRECT is set and need to be cleared
> +		 */
> +		iocb->ki_flags &= ~IOCB_DIRECT;
>  		ret = xfs_file_buffered_read(iocb, to);

XFS doesn't usually allow directio fallback to the pagecache.  Why would
fsverity be any different?

--D

> +	}
>  
>  	if (ret > 0)
>  		XFS_STATS_ADD(mp, xs_read_bytes, ret);
> -- 
> 2.38.4
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
