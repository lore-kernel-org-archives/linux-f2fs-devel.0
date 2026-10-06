Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D310CA5FED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1A2fWixpYh/rHEcRDS5At3Z0IGZj3hRvWlDqTuYP/KE=; b=Tuz6OK8FB9UUElgfRHdaBeeMCr
	xR2/VFEu9tBz3Dyz+fD62Co7LURWMSnSrHuKdu3/WKfezgT6lKajkKhHu1gq5pEHSnzih7unNSIUa
	khMNg6S9WM8JmAZ4era52iogCBK8UEZar5yC8PWuDaMP5hcPhDOzFRHx9VurQxhWIccg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xE15q-0006RN-Gj;
	Tue, 06 Oct 2026 09:04:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1xE15p-0006RG-47
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 09:04:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PgeNokXIlRBGGeHOkLtJQ5VDem+6R26Oh7feIv6Fbzk=; b=G32ojiPx03QLDikpRFwy5E80zp
 FOtbDQJK6aylHPNJ1ikun3c/I9xHiBgMa4+1JGche6QnFoBN8jvM3zjFf8x3HE0OqmlheMLx5gJW7
 E8kCbyQpCF6Me/aqdiHEATgj101alp75F21p5tEeMRG6OLs6vbJD1M2tbHjlQCoQDaUs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PgeNokXIlRBGGeHOkLtJQ5VDem+6R26Oh7feIv6Fbzk=; b=hK+OVEQHkP4tQ3EZ5sbPNWEmOU
 iLKaSIYWrnvWBK52QvqVnQCarqIGYmCavTJ+qhVH2aD4hIJ2h8k+mqrMv0f29YJ5timy4mNjprQDz
 iDdhGuJD5XNC1vwLlmjL2PeCd6k4X1Y3K/A19VFqR4BF4FICF7E7eNtsZO0WyWGwkABU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE15m-0000hd-N1 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 09:04:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11C136022A;
 Tue,  6 Oct 2026 09:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F50F1F000FF;
 Tue,  6 Oct 2026 09:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791277444;
 bh=PgeNokXIlRBGGeHOkLtJQ5VDem+6R26Oh7feIv6Fbzk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Cv+Iwz6EcV7+p4TS0689Vi+owN+wS6+WTmpfgTmF0wiiAGIvV1GhvYsdLl9yQ2ne7
 HMaTDRA8mE6/kgQPkxjrvctzXetFjupG1ZWZfE+MKB2AT8zKP9P90m+kNilyEZuQGJ
 Y1sYeVcUJ/w2M4TeydnP2vCYx9qnh5hbITYASlKMNznUNeewrq/FRCJdpH0lgSkfAs
 OalzBxscMcTLeiZhV0gXyDELtvgG/5Yden/XakB9B06IF0/pL5+IRnGspiQyeiSUbA
 W8Ye83zx8uuEA6UuHg2c3eW3BWgKlZ2msR8xr9vstSx2g00AnFuwOpkmh230viqP69
 Ys94/DWQ+G/+Q==
Date: Tue, 6 Oct 2026 11:03:59 +0200
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <asS3a5f8JKzVmlta@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-16-aalbersh@kernel.org>
 <asPEIapeSklgcsUa@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <20261005211235.GF2705364@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261005211235.GF2705364@frogsfrogsfrogs>
X-Headers-End: 1xE15m-0000hd-N1
Subject: Re: [f2fs-dev] [PATCH v17 15/21] xfs: add fs-verity support
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-10-05 14:12:35, Darrick J. Wong wrote:
> On Mon, Oct 05, 2026 at 07:18:35PM +0200, Andrey Albershteyn wrote:
> 
> <snip>
> 
> > > +/*
> > > + * Try to remove all the fsverity metadata after a failed enablement.
> > > + */
> > > +static int
> > > +xfs_fsverity_delete_metadata(
> > > +	struct xfs_inode	*ip)
> > > +{
> > > +	struct xfs_trans	*tp;
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +	int			error;
> > > +
> > > +	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> > > +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > > +	if (error) {
> > > +		xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > > +		return error;
> > > +	}
> > > +
> > > +	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));
> > 
> > Oh I haven't paid enough attention here, it has to be moved before
> > xfs_ilock(ip, XFS_MMAPLOCK_EXCL) not just before the lock, to exclude
> > ABBA with writeback/reclaim taking folio lock and waiting for trans
> > space.
> 
> Hrm?  You have to hold IOLOCK and MMAPLOCK, and *not* hold ILOCK, to
> truncate the pagecache.  IOWs,
> 
> 	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> 	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));
> 
> 	error = xfs_trans_alloc(...);
> 	if (error)
> 		...
> 
> 	xfs_ilock(ip, XFS_ILOCK_EXCL);
> 	xfs_trans_ijoin(tp, ip, 0);

Yeah sorry, you are right, I'm confusing myself

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
