Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D093FCA5FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 21:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p1SnEpPDseTNe4nCdol9QMudUMDkt+wQVXqKbdsdnhQ=; b=YC7PF5NWXdekyf3I/csXB9RJyy
	fdsEmLu4LjPHHqcdxCly37v2xatVAk5tqAOWDct7ml7ltLxmpMWBujf8ldAGZaJKTnKav/TV9F25C
	MKEb4lWc6KUZDfS7e0YCbpFuy9PpgpTBwKh+2bcun+iRVERZ7UMMKnb5bfKKfIKI47+I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDpzI-00026O-6h;
	Mon, 05 Oct 2026 21:12:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <djwong@kernel.org>) id 1xDpzG-00026I-Ux
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 21:12:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tWny7OQoIybWrVpLqJVtZbV0h7M1yQfOw+IiB5CpJ1Y=; b=aTOkj7B9HqJz9GqVXh5TeXyPvd
 njpwH6Rq2YwWuDyJ9gKSCWZP31iq8IWB8/tAlFop9pVjYeJSs34u4507Ltp1a7f8kE+JIikixJThZ
 rL4UQUxdECH0W7HLnOODZq3m8i3pKgm8rd9p+Fc6YGMvoGXAUyTzh0JvKtRWo32Rnq/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tWny7OQoIybWrVpLqJVtZbV0h7M1yQfOw+IiB5CpJ1Y=; b=chURPc1NfDfinM4o4xs4e38WJZ
 6NmzFlO9v35k17YNX44z5jgG82hpANYNLk5IwTQH8A02oKv0nsKrRBPkJ3HllJZ8PQgCAk8HYHtcE
 wcfmi6zbOmjcCdoLTQFm+z+NRedom2K39/mFT62gDc4TZ3Ct9OWMeySrcUIEJ1PN+vUk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xDpzG-000283-AE for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 21:12:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with UTF8SMTP id B2FAD60008;
 Mon,  5 Oct 2026 21:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 597531F000FF;
 Mon,  5 Oct 2026 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791234756;
 bh=tWny7OQoIybWrVpLqJVtZbV0h7M1yQfOw+IiB5CpJ1Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HJteQIa/DDzgnwyJHNbSCu+IWvB1GpDJUesTphW48b60A2/0GRigCUS7194OP5m3s
 LznhOFBx8V60WNnU6TgcbnfjkZ+PEFWD3XjqDSwUM5j7+SX4hnw8kf0UtartFyXHLg
 PHYvoGd2j/k6UJfyQPokSWmM3/0jJcRqbWZ5k3anZTwHQgvJlayp9hSdRQDZwrax+7
 giYaXZ09baiLJ/5pvHPX56cgLGnHOtmkdaRyWOBcSx0pTqS2/Ht5qeVe4TuHThbYhd
 4hvzwzFJj4Zo/rgJfAr7p05yzBWMZbvXnR1l42A19uhK9ogaMXTxZAlO8gbE4RygkZ
 djvHaykCksmLg==
Date: Mon, 5 Oct 2026 14:12:35 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20261005211235.GF2705364@frogsfrogsfrogs>
References: <20261002223705.2175542-1-aalbersh@kernel.org>
 <20261002223705.2175542-16-aalbersh@kernel.org>
 <asPEIapeSklgcsUa@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <asPEIapeSklgcsUa@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-Headers-End: 1xDpzG-000283-AE
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
From: "Darrick J. Wong via Linux-f2fs-devel"
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Oct 05, 2026 at 07:18:35PM +0200, Andrey Albershteyn wrote:

<snip>

> > +/*
> > + * Try to remove all the fsverity metadata after a failed enablement.
> > + */
> > +static int
> > +xfs_fsverity_delete_metadata(
> > +	struct xfs_inode	*ip)
> > +{
> > +	struct xfs_trans	*tp;
> > +	struct xfs_mount	*mp = ip->i_mount;
> > +	int			error;
> > +
> > +	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
> > +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > +	if (error) {
> > +		xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
> > +		return error;
> > +	}
> > +
> > +	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));
> 
> Oh I haven't paid enough attention here, it has to be moved before
> xfs_ilock(ip, XFS_MMAPLOCK_EXCL) not just before the lock, to exclude
> ABBA with writeback/reclaim taking folio lock and waiting for trans
> space.

Hrm?  You have to hold IOLOCK and MMAPLOCK, and *not* hold ILOCK, to
truncate the pagecache.  IOWs,

	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));

	error = xfs_trans_alloc(...);
	if (error)
		...

	xfs_ilock(ip, XFS_ILOCK_EXCL);
	xfs_trans_ijoin(tp, ip, 0);

--D

> I will send v18 if more feedback will arrive, otherwise, I can
> resend just this patch (or could be fixed during merge?).
> 
> -- 
> - Andrey
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
