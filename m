Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C10CC87FCA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Jul 2025 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VbOydEDfCvo3AKngmwP7Kz/UvCwLuhifNT2tBJPhf3I=; b=K0gdvfW2Gw1SCgCbzxhOMAbnPs
	0VdABKVwg9RT9f2Bs4Pw+kLgw6hhABnTfbuzTExMim7i+1D48RvjnJ2e8fNxbXYCH8uQLclbuADnz
	8OT7XJhvD+ye7I+UGK+XwhDq2+0ufrDi6NyHD//TJj0oYOssxoMmdxZf/zmRTQftkRts=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uhUD2-0004yB-9t;
	Thu, 31 Jul 2025 14:24:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+0adda02d61b3aa44babd+8012+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1uhUD0-0004y5-9h for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Jul 2025 14:24:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m+2A9w+aUv0ZDr6hyfhfJ9HUaAAeP1mYbGPx8VhkZ6U=; b=IG0rzbldL+nqmjJXXn7yq50mFH
 Iz7U8bvjkBhmZiE4A/RdxMGH+8qFVhXu6/mbLRQ42NeXlAd1yKtzaiTmvpprsMSF0d+41M/X9cp/x
 F6/kcckwNc/2k78zzRKpyjMhCEC//ZJPvANyTnE6WcYq58/ClX3L4u9KS2tSS2uH9Mww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m+2A9w+aUv0ZDr6hyfhfJ9HUaAAeP1mYbGPx8VhkZ6U=; b=QEmHBE1hX5EGMtQ1cVUJSxBSqH
 Owh5WF/Fr6NXsN9emqa3NiSdUFZAzdr/ZsDD+RTYtuqDGxGFZY5Sr1EP59qvpCgxQ5sQvasDnGg7A
 BUAkSCghPgL0R5nHZZCl8u/Pu+jPAL0gsA7Fq9LGWrMpyCc4eRht7XQpbPZdqngrh4v0=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uhUCy-0006JQ-T0 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Jul 2025 14:24:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=m+2A9w+aUv0ZDr6hyfhfJ9HUaAAeP1mYbGPx8VhkZ6U=; b=Mmtd6I12WJKczi2mR7i+xITNFM
 sOfWaZUgUz3JFXpZNwsbRLs1hhExh5YzY91cqHMoWPoeqGRHyRBM9tT3vue1c5m1lF8pGgDNaM6rP
 ubfo8sSOAbrlHFxsaX02k0svRGz6fvacssSXM6ok7m1/8qxnyZEwn7EPf8CnJfy20SZgd/HPj4SAr
 4vhUuKI8KHFZcsBZYx2POSv4GCYe/YaXtCDCTV3LOjcobIV8aZyEKGhJhCJxtGVucTJp2jhWLyO+h
 S6BOmnt96+A3t8zh7R0CoCHCN6PhILaZ/57EDI0AazF8K4EpzDigUJFgFV1RhpLavdsPdnTl3dWwY
 nB/bHQhQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1uhUCh-00000003p9x-3wsg;
 Thu, 31 Jul 2025 14:24:19 +0000
Date: Thu, 31 Jul 2025 07:24:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Message-ID: <aIt8kzlJ2sW7nKir@infradead.org>
References: <20250729160345.3420908-1-gxxa03070307@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250729160345.3420908-1-gxxa03070307@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1uhUCy-0006JQ-T0
Subject: Re: [f2fs-dev] [PATCH] fs: export some tracepoints for iotrace
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
Cc: gaoxiang17 <gaoxiang17@xiaomi.com>, quic_nguyenb@quicinc.com,
 bvanassche@acm.org, martin.petersen@oracle.com, mani@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 James.Bottomley@hansenpartnership.com, avri.altman@wdc.com,
 peter.wang@mediatek.com, alim.akhtar@samsung.com, linux-scsi@vger.kernel.org,
 jaegeuk@kernel.org, beanhuo@micron.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jul 30, 2025 at 12:03:45AM +0800, Xiang Gao wrote:
> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>

Random exports without a user of even explanation are weird.

What up with Android folks that this kind of junk keeps getting sent
over and over?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
