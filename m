Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE762109C028
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MNGQwhJn8EJkMDRXGAYk0doN45nziXfoDLOLtSk0XLQ=; b=EhwHyxcr5DewP2ryguL/Ed0Ed4
	gLE3Ix8PXIIHpDZQ3fnBycYkY99V3/HdvfjVU4JKJ2j2q4r3SN/qqNp/OiXGP0MDS4/cxCgsHtanM
	HPzdDHqdSQq/UU6NgOwxzWPfBT0IyRSFbhIBvpBfgGehZsdD8pRiolq/Odrcc4cSDaZE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5Pqf-0006MI-UC;
	Wed, 25 Mar 2026 15:08:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w5Pqd-0006MB-9J
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:08:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3zCbkguP0jkC6VOPb3S101Ci6Vpq1yGoPJY3EKoY2/0=; b=YmazuDjiWgV/UK7vnA/YSQZG/H
 V6d1Ilpl71apc/Oy1oTnF1DB7S+T5eOKZL0FpQQtJQCp35dEiWncm+NqGPnNM2r42WinJOOlM8tge
 kmK6x4Rj/Z+dLuciITDKVH5IKkun02YhoZBxQZoR+Ua/qVirTTrtXgD34bIzsA7HWVCg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3zCbkguP0jkC6VOPb3S101Ci6Vpq1yGoPJY3EKoY2/0=; b=dczVUu7tSWMiAGtq0L1w9net6R
 LB3/nR2cB4Olx5IQW19KcI1kW1tq4vQaOmN3W7l0iBTDjsIrYgl8cOeKPlsAmEqL9SGRNHVURp6H5
 CPG+SXqyepE4XdXYOyD+gcRC9lueDks07NJkeWLVdAw8N2LlTNyioCEUwywO2746lEQQ=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5Pqc-0007Ad-HV for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:08:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8FF9C68D0A; Wed, 25 Mar 2026 09:00:22 +0100 (CET)
Date: Wed, 25 Mar 2026 09:00:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260325080021.GF952@lst.de>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-8-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319170231.1455553-8-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w5Pqc-0007Ad-HV
Subject: Re: [f2fs-dev] [PATCH v5 07/25] iomap: introduce IOMAP_F_FSVERITY
 and teach writeback to handle fsverity
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> @@ -353,9 +353,16 @@ static inline bool iomap_block_needs_zeroing(const struct iomap_iter *iter,
>  {
>  	const struct iomap *srcmap = iomap_iter_srcmap(iter);
>  
> -	return srcmap->type != IOMAP_MAPPED ||
> -		(srcmap->flags & IOMAP_F_NEW) ||
> -		pos >= i_size_read(iter->inode);
> +	if (srcmap->type != IOMAP_MAPPED)
> +		return true;
> +
> +	if (srcmap->flags & IOMAP_F_NEW)
> +		return true;
> +
> +	if (srcmap->flags & IOMAP_F_FSVERITY)
> +		return false;
> +
> +	return pos >= i_size_read(iter->inode);

This might be a good time to document the various reasons for needing
zeroing.

> +/*
> + * IO happens beyond inode EOF, fsverity metadata is stored there
> + */
> +#define IOMAP_F_FSVERITY	(1U << 10)

This comment feels a bit too sparse.  Here is my interpretation of what
this flag does:

/*
 * Indicates reads and writes of fsverity metadata.
 *
 * Fsverity metadata is stored after the regular file data and thus beyond
 * i_size.
 */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
