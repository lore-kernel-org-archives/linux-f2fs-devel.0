Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D292BC28B30
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Mar 2025 14:28:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1twMJg-0006Qs-19;
	Sun, 23 Mar 2025 14:28:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1twMJd-0006Qk-KV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Mar 2025 14:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CTqjP0pu5/py1p0o6HQAaOkcAajxuHgEAqXR8efZbpY=; b=bHHqExGQ2mxkwNbhUe5TBdNtg5
 N7LDWxlUPATDwJTtlc1d4RdLu5+v3Iu9YBKhBw24jlLuivVL4Jk0GOdsJlc0IcIfJBEQq/BHwsjRs
 RCUa4/pDDzlA6gnoFIm1DFXVf0bDkRQHriTQZQWyK//9hTgz57VU0ORjRPQcpIRJqlXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CTqjP0pu5/py1p0o6HQAaOkcAajxuHgEAqXR8efZbpY=; b=izT8Qo6vcMf+13vePikfTvfePG
 iFnLtjV0J9wLr+GobrBzrz+giVrMph4PSt/nqXvErJzhr+60kevf9PhToFEpKlOP80QKRgxBnHOHn
 YWXCQX0vl3HwRJSLEVdHam62u0QGeHvtQ+nxQ6B9KhaXR8SQnwgwyt/LLcvBPtU0vnPY=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1twMJX-0008Il-DS for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Mar 2025 14:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CTqjP0pu5/py1p0o6HQAaOkcAajxuHgEAqXR8efZbpY=; b=gKDFvi7u0cEAh1Gs42QaKro+XD
 il/rcO56sQ/sLCMARlDrkw1ZaV9ixbvG7PX48fTVyiRB2XuXM6w5HbM8/HvzApRHbmu4BQl8VrunS
 /hu/JV8ih8tcBChHVRkV9lCTyovlX7rrpAq1Vd4E2UpR6S37m5TphhC/yrVAWIlB8daMBi29A3GM/
 pGfrind04fZtKKcDQDChPJjux57WAHkjX6Nm+Td5o6PlTxnSPEEwH3rFVcD75s7c1BbfEHbR+gc7Z
 z14aoV9PdztJAMr5I34Pcg8t3RuahWutYIXnKuSZbtLZkYaFWMNI0RETy5zNsvR5UuN8W6gdHDiZ0
 li72sP4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1twMJP-00000006gA7-3OrP; Sun, 23 Mar 2025 14:28:27 +0000
Date: Sun, 23 Mar 2025 14:28:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
Message-ID: <Z-Aai24gPXWQp8qi@casper.infradead.org>
References: <CAMLCH1FEuoDxFFQ8HuUdBDMfzsyaS2LWyVh+eyGCpgxnKGa7rA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMLCH1FEuoDxFFQ8HuUdBDMfzsyaS2LWyVh+eyGCpgxnKGa7rA@mail.gmail.com>
X-Headers-End: 1twMJX-0008Il-DS
Subject: Re: [f2fs-dev] Inquiry regarding plans on vmscan pageout supporting
 fs writepages
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Mar 23, 2025 at 07:34:59PM +0800, Nanzhe Zhao wrote:
> I've recently been studying your patch 'f2fs: Remove uses of
> writepage'.  I understand the rationale behind it, especially with the
> page cache and file I/O increasingly adopting folios in place of the
> traditional page structure. This trend indeed renders the legacy
> `writepage` function in file systems not only unnecessary but
> potentially detrimental.  This is particularly true for file systems
> like F2FS, which, as you know, has already fully implemented the
> `writepages` function for all its `address_space_operations`.
> 
> However, as you've pointed out, the `pageout` function within vmscan,
> which `kswapd` uses for dirty page writeback, doesn't currently
> support calling the file system's
> `address_space_operations->writepages`.  I was wondering if you have
> any plans to improve this situation, and if so, could you perhaps
> share some insights into the general direction or approach you might
> be considering?

commit 21b4ee7029c9
Author: Dave Chinner <dchinner@redhat.com>
Date:   Tue Aug 10 18:33:41 2021 -0700

    xfs: drop ->writepage completely

    ->writepage is only used in one place - single page writeback from
    memory reclaim. We only allow such writeback from kswapd, not from
    direct memory reclaim, and so it is rarely used. When it comes from
    kswapd, it is effectively random dirty page shoot-down, which is
    horrible for IO patterns. We will already have background writeback
    trying to clean all the dirty pages in memory as efficiently as
    possible, so having kswapd interrupt our well formed IO stream only
    slows things down. So get rid of xfs_vm_writepage() completely.

    Signed-off-by: Dave Chinner <dchinner@redhat.com>
    [djwong: forward port to 5.15]
    Reviewed-by: Darrick J. Wong <djwong@kernel.org>
    Signed-off-by: Darrick J. Wong <djwong@kernel.org>


https://lore.kernel.org/linux-fsdevel/20181109151239.GD9153@infradead.org/

There's probably some other good documentation around why we're doing
this, but this is all I have handy.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
