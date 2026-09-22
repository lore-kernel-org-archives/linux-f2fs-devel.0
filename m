Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D8CC982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3pqZ0JjaizTkGQoxlBWayUc5lz02AubpYkg5eDvPCTE=; b=Wsoo8fQTUSAO+FmXcXUqoXn82i
	ONHS2tsL1G1cj2TstSj/MgT7bFs1SGRCVuyVAKwDI5dOdsnk0lg0Kq19slN0Zy+Ke0nFd/mNwt/zY
	9W+LXOxdnGF30AdsM/yb/ypjI4bVn5t06JRqGFUnfEEB9hsQqcf2aCDKTKUTqQGx/fYI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8yhe-0005u8-QS;
	Tue, 22 Sep 2026 11:30:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x8yhJ-0005sv-LT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 11:30:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nV8p6Om8qinv6yCBXUuo5B2uIDMSV459k6GB4PG3ZlI=; b=CPWxzxyH827wP1KjuXGCHEoae+
 jxXjHwYCZJjeYLFTcTJZD6O93VnTzvnVR2QGCj3+fnbF8U1lJbNsOVDshtZ5osV+jFA0izddabRl4
 bUStnYXuowpjUVzeFUrYPpwOdfCKh7S6XKSXI4MS0ZDYC0OVemTH+3DR7KDcxMB7uZXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nV8p6Om8qinv6yCBXUuo5B2uIDMSV459k6GB4PG3ZlI=; b=QrQYPWRx1zW07b+usrU8YZafKi
 78GU9bc1FfwVMGAUTTkSR7pHFEhlxfiIZo5mAbVrHaUd5V20CcMvgB2FiuY6MKLgN16JhQRJeXt+E
 Upq0AZAT5us0qBvNopSYsY1TOTEf5la8NXnPcVdSnyMG1wZEpNV2CmlL48vukgonzMwc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8yhH-0006ox-Jq for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 11:30:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF14C601F7;
 Tue, 22 Sep 2026 11:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F43B1F000FF;
 Tue, 22 Sep 2026 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790076597;
 bh=nV8p6Om8qinv6yCBXUuo5B2uIDMSV459k6GB4PG3ZlI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=W0dEvj5zWbynOI1xN6zKaAWjWZtxGOprab+zcQIcvZTXmYxhx+2RqMPc1aU4QZttH
 2Lp/6eIl2zv0Rkkad56JU0uFNc+uHztMw/x5ZfZxowYZWEw4kRJSvw8P/qPQoyxL5C
 UTA5+iAh3uJMkWBtQtoGBf8I8SGI3pdjY4ByxIkJLukL9e6r5RWIkKiyEB2CiVe1LW
 XrR+xVhQVeezmzuRaN9DcXdomNZZUVVzWLOP+fWiZamXflNSka1h1QzcCOqxZnGtQU
 +oJijmz3DdwhmB4njIISMv+3QdNdnGRdwwZHpH6aDbkzTZl4JcBfIu8Bc7Hx0RgtkP
 F/uhJyHeh1mfQ==
Date: Tue, 22 Sep 2026 13:29:52 +0200
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <arJl4xbG3vUrX9DK@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-15-aalbersh@kernel.org>
 <20260922043750.GN2705364@frogsfrogsfrogs>
 <arI9MpRVBZ0UEofK@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arI9MpRVBZ0UEofK@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-Headers-End: 1x8yhH-0006ox-Jq
Subject: Re: [f2fs-dev] [PATCH v16 14/21] xfs: don't remove written extents
 past EOF on fsverity inodes
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
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-22 10:33:22, Andrey Albershteyn wrote:
> On 2026-09-21 21:37:50, Darrick J. Wong wrote:
> > On Fri, Sep 18, 2026 at 01:15:26PM +0200, Andrey Albershteyn wrote:
> > > xfs_free_eofblocks() removes all extents past EOF unless the
> > > XFS_DIFLAG_PREALLOC or XFS_DIFLAG_APPEND flags are set. This is
> > > undesired for fsverity as it stores metadata beyond EOF. However, while
> > > merkle tree is being built, delayed preallocation and unwritten extents
> > > are used. After metadata construction is done, fsverity inodes becomes
> > > read-only and won't be changed anymore, none of these unwritten extents
> > > or preallocations in post EOF region will be used.
> > > 
> > > Let xfs_free_eofblocks() be called on fsverity inode as usual to remove
> > > anything which is not written extent. However, inodes which are
> > > undergoing merkle tree construction need to be skipped in case reclaim
> > > takes place.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  fs/xfs/xfs_bmap_util.c | 25 ++++++++++++++++++++++---
> > >  1 file changed, 22 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > > index 268d159339d0..7fd951992557 100644
> > > --- a/fs/xfs/xfs_bmap_util.c
> > > +++ b/fs/xfs/xfs_bmap_util.c
> > > @@ -31,6 +31,7 @@
> > >  #include "xfs_rtbitmap.h"
> > >  #include "xfs_rtgroup.h"
> > >  #include "xfs_zone_alloc.h"
> > > +#include <linux/fsverity.h>
> > >  
> > >  /* Kernel only BMAP related definitions and functions */
> > >  
> > > @@ -553,6 +554,13 @@ xfs_can_free_eofblocks(
> > >  	if (last_fsb <= end_fsb)
> > >  		return false;
> > >  
> > > +	/*
> > > +	 * Don't clean fsverity inodes which have merkle tree being built, the
> > > +	 * merkle tree is written beyond EOF
> > > +	 */
> > > +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> > > +		return false;
> > > +
> > >  	/*
> > >  	 * Check if there is an post-EOF extent to free.  If there are any
> > >  	 * delalloc blocks attached to the inode (data fork delalloc
> > > @@ -579,6 +587,9 @@ xfs_free_eofblocks(
> > >  	struct xfs_trans	*tp;
> > >  	struct xfs_mount	*mp = ip->i_mount;
> > >  	int			error;
> > > +	int			bmapi_flags = XFS_BMAPI_NODISCARD;
> > > +	bool			has_verity =
> > > +			ip->i_diflags2 & XFS_DIFLAG2_VERITY;
> > >  
> > >  	/* Attach the dquots to the inode up front. */
> > >  	error = xfs_qm_dqattach(ip);
> > > @@ -593,15 +604,20 @@ xfs_free_eofblocks(
> > >  	 *
> > >  	 * Note that this means we also leave speculative preallocations in
> > >  	 * place for preallocated files.
> > > +	 *
> > > +	 * Clean up delalloc reservations for fsverity too as those won't be
> > > +	 * used
> > >  	 */
> > > -	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
> > > +	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND) ||
> > > +			has_verity) {
> > >  		if (ip->i_delayed_blks) {
> > >  			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK,
> > >  				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
> > >  				LLONG_MAX, NULL);
> > >  		}
> > >  		xfs_inode_clear_eofblocks_tag(ip);
> > > -		return 0;
> > > +		if (!has_verity)
> > > +			return 0;
> > >  	}
> > >  
> > >  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > > @@ -613,6 +629,9 @@ xfs_free_eofblocks(
> > >  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> > >  	xfs_trans_ijoin(tp, ip, 0);
> > >  
> > > +	if (has_verity)
> > > +		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
> > 
> > This ought to have a comment explaining where post-eof unwritten extents
> > might come from:
> > 
> > 	/*
> > 	 * If fs-verity fails to write the full metadata, it can leave
> > 	 * unwritten preallocations after EOF.  Clear all that out.
> > 	 */
> > 	if (has_verity)
> > 		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
> > 
> > 
> > With that documented,
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> 
> Sure, I will add the comment
> Thanks!

I will re-pharese the comment to:

	/*
	 * While fs-verity writes metadata after EOF, it can leave unwritten
	 * preallocations.  Clear all that out.
	 */

The preallocation are left even in good case, in the merkle tree
holes and after fsverity descriptor.

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
