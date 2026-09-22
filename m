Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EB1C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gz3oAU8Np0VKKDHTK+KSIhKtwBfTpuMttwznwCnxlSU=; b=YnYkp2G0WErfq4kvGxVd4kNNF6
	heGl2M7RWKtvi60sYYlmB+SJ03wudR2Dah/lOK5bcJn8mU3oCn4BMbf+/tcvuNqe8HEyD8rsnGKl/
	SyqCNunJb4NbQp6xgJZfPhGzO+w3WSaQhTwwV3x9H4vZr2X0hDOeRv+HEOR1JlTXtPKE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x90Xs-0001Qh-GE;
	Tue, 22 Sep 2026 13:28:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x90XW-0001QQ-Nj
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6PGj+hd//EF8JcQmcnCRDBkLakUJwfZRFfDprUZGMAk=; b=i6E7jQFigNbABrbasuaQEvwDQL
 OLbgn0mA0/+MBnk25fLU2QydLN1i/lx4sqOvA3zSZ8PcLqmqt1HvRbSniK8zgmDzexX6FBCQAmNwa
 CzqYbjHdYPNJ0t5clUtzyJjy2/I49KcLBC+tq/GCIN4qYblelo75BETmhD1bEjJK42ac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6PGj+hd//EF8JcQmcnCRDBkLakUJwfZRFfDprUZGMAk=; b=l4PkbZboGR3azqHJ8oV++UFfTN
 3ZmuckKKYWU+zROwkmJuUjimzvLtZXQnQsH3lOMnBPv/Up4FY2MDLLi/FG5hvtW1wwg3+xgj+r3G/
 LzSwL4Cqm0HkixUht78ZQl/4MvtMjfbyX7k5TjGEeh3VazdRkdajV20U1RlOYnCCZeH4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x90XV-00019w-CY for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:28:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 05BDC44B7E;
 Tue, 22 Sep 2026 13:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33081F00893;
 Tue, 22 Sep 2026 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790083679;
 bh=6PGj+hd//EF8JcQmcnCRDBkLakUJwfZRFfDprUZGMAk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ioqsi3ZxN9+a/YXEvieSjbpT8UHcfOoBGM9mV7YUu4Yngh5XSlFRbochz4k9LuSU6
 KuuM0jcH0zX5qOM08Ci6BMAyBsh/nffUzf0u+mjzpfJ177dsB40GH4QPFgQeifeRAw
 0wo/c9tnRIY/PLap26paJls5/ZA5dXLhtAniZtX5+BPgCqtoTFm/DnOYcaZ3QSD7/X
 7AiqT7Oti/bB7AV1hhm5tT8dBdSGvgTP5ohj0lxjHRFMVlBLywo62ETGv/04MalR4G
 ptZiGbBlHK3sXSfknpaUlXNMGkTLAHwz88EF/N10v6pnWguVSXRjh5q/DOf+DbSkGl
 EN2JJKrO04y1g==
Date: Tue, 22 Sep 2026 15:27:54 +0200
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <arKAqsuSoxvM1yKt@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-16-aalbersh@kernel.org>
 <arIszDCcy0VbRVFp@infradead.org>
 <arI-5Ejg0Xw7OVmH@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <arJ1dfejt4DyCsvG@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arJ1dfejt4DyCsvG@infradead.org>
X-Headers-End: 1x90XV-00019w-CY
Subject: Re: [f2fs-dev] [PATCH v16 15/21] xfs: add fs-verity support
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
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, djwong@kernel.org,
 Andrey Albershteyn <aalbersh@redhat.com>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-22 05:32:53, Christoph Hellwig wrote:
> On Tue, Sep 22, 2026 at 10:56:09AM +0200, Andrey Albershteyn wrote:
> > On 2026-09-22 00:22:52, Christoph Hellwig wrote:
> > > On Fri, Sep 18, 2026 at 01:15:27PM +0200, Andrey Albershteyn wrote:
> > > > +	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > > > +	xfs_trans_ijoin(tp, ip, 0);
> > > > +
> > > > +	truncate_inode_pages(VFS_I(ip)->i_mapping, XFS_ISIZE(ip));
> > > 
> > > We can't call truncate_inode_pages with the ilock held.
> > > 
> > > I also don't see what this is trying to protect to start with.
> > > 
> > 
> > I added this to remove stale pages created post-EOF, so, writeback
> > doesn't try to flush them latter (but now I see that writeback will
> > fail to map them to extents anyway). Also, if EOF gets extended
> > these pages would be exposed as they are up-to-date which would be
> > unexpected garbage.
> 
> Yeah, but what is the ilock trying to protect against?  ilock is
> the innermost sleeping lock and protects modifications to the
> inode fields and the extent mapping.   Higher level synchronization
> is done using the iolock and the mmaplock (which is already taken
> here).
> 

hmm maybe I don't understand what you addressing here but don't I
need ilock for xfs_itruncate_extents() used with this transaction.
So, doing extent removal.

With this function I want to remove post EOF pages from pagecache
and then remove post EOF extents on that inode.

iolock is already hold, mmaplock is for pagecache truncation and
ilock for extents removal.

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
