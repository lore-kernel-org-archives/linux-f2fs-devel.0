Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5110C982FA
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d6vDsQgxSUR5NbGDqBpkwISMGUADWuLBR+cPsrmNAaw=; b=ACuN1n4Z55LEgsE2kg2P6eIr8H
	yr/y+Y7WFpYK9P47UJmAouHLJCVfPzaDYNyvEa8xFEfMc69wsYqiBsSLM/K50XmOclxtw+9c6vbTu
	KA5PNMQXV8MASLR6jmRjpGIekgt91pdCEtLV0e2e6rJbcheCMkS/zMVevbhvdhmWmTgg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8vwg-0005Lp-TP;
	Tue, 22 Sep 2026 08:33:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1x8vwW-0005HQ-KZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:In-Reply-To:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w4z5ytHAoQC8UWkOcT2zO26c7SVy/93HRcvFS003K4I=; b=Nmn/8Os8yQPbV+O/t2Iu9+OSUG
 rhRqrrJn+r2HMPPEahtjhZ2pIdFEpdZfJKPUwFftsROZgFX/S25mMkJ620+ZVdBZBg2tcP1z1891o
 oK7/GCmXweQHKL/HBPIfGmUbtdvd4lZPrEO0tN954Sp05eUDbGPBP7l+OZ3esx6s6txI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w4z5ytHAoQC8UWkOcT2zO26c7SVy/93HRcvFS003K4I=; b=f9MmexrpaTMmLWeFlWQzKLHKrn
 9SwFq4gLQ5jBM0JZsJiwbPPWPEnme44NvdSUqY7PgMDsFhToxzdTMhz07h7YKr0JPgLZodbnaQusU
 27TccZ0ShVq7Pn0FiO4dIb5vVvCAtwBxfN/p1rBFlmg3RKjEqsEVg7/4gSM8lSdPOscQ=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8vwS-0005xq-Hb for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 08:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790066006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4z5ytHAoQC8UWkOcT2zO26c7SVy/93HRcvFS003K4I=;
 b=VTOTiEQIl91Y6dYxZdf1v2iib8zKxLzjB3IZHRTN/8u1rNeymVxep4Oj/oZHQUvhv9KpdX
 fFyZNAN7kdl4sxYrsUTNYy5Gby/73eCAmDrlBFgnE9H+RKfp29ZG7PSaKasouWYsezS2DM
 dIAK6YXVaJ40hrMDorzora4Cee1HY04=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-0JhM6askNKevmGyqKY6HPQ-1; Tue, 22 Sep 2026 04:33:25 -0400
X-MC-Unique: 0JhM6askNKevmGyqKY6HPQ-1
X-Mimecast-MFC-AGG-ID: 0JhM6askNKevmGyqKY6HPQ_1790066004
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e73659ac5so54771045e9.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 01:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790066004; x=1790670804;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w4z5ytHAoQC8UWkOcT2zO26c7SVy/93HRcvFS003K4I=;
 b=rpMGpGFCYGBetJ944MH/wvoGvtlIMJnafxVhoKaNR4G57lwuynw4kuxm2JW5/0KVH/
 DuR6YVtpgpvV+6kflK2XflVMNhmL0scSN2PbPkuY69b7b+u7HwAf1L7Sy+K2b1q0cqSg
 t4D2EpGUwOE+94/XQlJjsBuM0eHqtTA/J8sg7j+8acH3EYYv72cBCn2kZ0mMlCiCZShn
 Z95++4mjkJIazBqrM7dlusjuy0pZ4L6/ROK2jYofTnW+RrNTcqNqQJZTwg1Xn/SQRn/B
 z7cWlLHaJ0D0qHqZJkZhuUu5GL6bKvwh28B55V6LpAH0meEyVrOgKgbM53LKitFlUggz
 qD7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAM4B1msygWaKLlh+37Tnbyv/Kw8XcpbzKxQQ7k58FPaDWRnfoYgnFCife8wwItDq/RSf2mHGh6fFvuRBgPxU0@lists.sourceforge.net
X-Gm-Message-State: AFuF++nvz5Y9U/24s0NZo2YEXlbDttWMv5dyFOVFv9NM3nwmsC0c6RGP
 EA+ZPQHzOr9Iub8AnSma9DuKDc8a5ziWWgRwg9ZcztswTUyhOP+2j10EKPmtzrIL49ehk+XsqdH
 WE5YP8jsueIOAEtn4VMoq4Op6mp07jRBtPJhN48vcnz63UgfNlZhUBtIvhiTTl1ieJqdLp/AX1G
 pFcQ==
X-Gm-Gg: AYBFou3ojawj1ho0+/scNWiCX12H1mgFZTfMUhQKuE/6aK1r3lf2f7abjLxEVC/yW4t
 r0bHw9AAMhcJ9Hf7lYaE14KNodwLKK7SZOD9KGbkkwRKXm8RKv22mN3rMZt27VzFDto+MrwszVb
 r91RwShFqkjqUhOTgUf7bQmznEvidSaYgKMjTLwYhLBZ93jUpB7IIPdCMGubqI8wQBKm5GNNrjd
 FWnGdV0wqAumZogGQ76cGou4GBkrWqUsNXVGFH4iRMSby02cu5W48fnR9NmJZfIEsV71Kvf85Wr
 vi5Mmu5mlbacB6HCQ9sTigDjRHwx0fvj+gFTzQ0Xjq0oWxuOoqM+tYzRimkbs1xMrsgCcenTlVh
 dS4Ud2Wpelrm/eD/Gofjru9TpG7UNA7mHEg==
X-Received: by 2002:a05:600c:a42:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-49fc5594deemr183435105e9.0.1790066004123; 
 Tue, 22 Sep 2026 01:33:24 -0700 (PDT)
X-Received: by 2002:a05:600c:a42:b0:49e:6683:d23c with SMTP id
 5b1f17b1804b1-49fc5594deemr183434735e9.0.1790066003664; 
 Tue, 22 Sep 2026 01:33:23 -0700 (PDT)
Received: from aalbersh-thinkpadx1carbongen13.rmtcz.csb ([217.30.74.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdab8ae6dsm74097995e9.0.2026.09.22.01.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:33:23 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:33:22 +0200
To: "Darrick J. Wong" <djwong@kernel.org>
Message-ID: <arI9MpRVBZ0UEofK@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-15-aalbersh@kernel.org>
 <20260922043750.GN2705364@frogsfrogsfrogs>
MIME-Version: 1.0
In-Reply-To: <20260922043750.GN2705364@frogsfrogsfrogs>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y4vQSmxOKZuNhR8TJIO8bvJjgCfA9LAksZW8l92jLGM_1790066004
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Headers-End: 1x8vwS-0005xq-Hb
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
Reply-To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-21 21:37:50, Darrick J. Wong wrote:
> On Fri, Sep 18, 2026 at 01:15:26PM +0200, Andrey Albershteyn wrote:
> > xfs_free_eofblocks() removes all extents past EOF unless the
> > XFS_DIFLAG_PREALLOC or XFS_DIFLAG_APPEND flags are set. This is
> > undesired for fsverity as it stores metadata beyond EOF. However, while
> > merkle tree is being built, delayed preallocation and unwritten extents
> > are used. After metadata construction is done, fsverity inodes becomes
> > read-only and won't be changed anymore, none of these unwritten extents
> > or preallocations in post EOF region will be used.
> > 
> > Let xfs_free_eofblocks() be called on fsverity inode as usual to remove
> > anything which is not written extent. However, inodes which are
> > undergoing merkle tree construction need to be skipped in case reclaim
> > takes place.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > ---
> >  fs/xfs/xfs_bmap_util.c | 25 ++++++++++++++++++++++---
> >  1 file changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > index 268d159339d0..7fd951992557 100644
> > --- a/fs/xfs/xfs_bmap_util.c
> > +++ b/fs/xfs/xfs_bmap_util.c
> > @@ -31,6 +31,7 @@
> >  #include "xfs_rtbitmap.h"
> >  #include "xfs_rtgroup.h"
> >  #include "xfs_zone_alloc.h"
> > +#include <linux/fsverity.h>
> >  
> >  /* Kernel only BMAP related definitions and functions */
> >  
> > @@ -553,6 +554,13 @@ xfs_can_free_eofblocks(
> >  	if (last_fsb <= end_fsb)
> >  		return false;
> >  
> > +	/*
> > +	 * Don't clean fsverity inodes which have merkle tree being built, the
> > +	 * merkle tree is written beyond EOF
> > +	 */
> > +	if (xfs_iflags_test(ip, XFS_VERITY_CONSTRUCTION))
> > +		return false;
> > +
> >  	/*
> >  	 * Check if there is an post-EOF extent to free.  If there are any
> >  	 * delalloc blocks attached to the inode (data fork delalloc
> > @@ -579,6 +587,9 @@ xfs_free_eofblocks(
> >  	struct xfs_trans	*tp;
> >  	struct xfs_mount	*mp = ip->i_mount;
> >  	int			error;
> > +	int			bmapi_flags = XFS_BMAPI_NODISCARD;
> > +	bool			has_verity =
> > +			ip->i_diflags2 & XFS_DIFLAG2_VERITY;
> >  
> >  	/* Attach the dquots to the inode up front. */
> >  	error = xfs_qm_dqattach(ip);
> > @@ -593,15 +604,20 @@ xfs_free_eofblocks(
> >  	 *
> >  	 * Note that this means we also leave speculative preallocations in
> >  	 * place for preallocated files.
> > +	 *
> > +	 * Clean up delalloc reservations for fsverity too as those won't be
> > +	 * used
> >  	 */
> > -	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
> > +	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND) ||
> > +			has_verity) {
> >  		if (ip->i_delayed_blks) {
> >  			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK,
> >  				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
> >  				LLONG_MAX, NULL);
> >  		}
> >  		xfs_inode_clear_eofblocks_tag(ip);
> > -		return 0;
> > +		if (!has_verity)
> > +			return 0;
> >  	}
> >  
> >  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_itruncate, 0, 0, 0, &tp);
> > @@ -613,6 +629,9 @@ xfs_free_eofblocks(
> >  	xfs_ilock(ip, XFS_ILOCK_EXCL);
> >  	xfs_trans_ijoin(tp, ip, 0);
> >  
> > +	if (has_verity)
> > +		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
> 
> This ought to have a comment explaining where post-eof unwritten extents
> might come from:
> 
> 	/*
> 	 * If fs-verity fails to write the full metadata, it can leave
> 	 * unwritten preallocations after EOF.  Clear all that out.
> 	 */
> 	if (has_verity)
> 		bmapi_flags |= XFS_BMAPI_UNWRITTEN;
> 
> 
> With that documented,
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Sure, I will add the comment
Thanks!

-- 
- Andrey



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
