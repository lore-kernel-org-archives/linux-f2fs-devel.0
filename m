Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9213C35274
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Dec 2023 09:50:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rFAGZ-0005GX-3F;
	Mon, 18 Dec 2023 09:50:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1rFAGU-0005GR-Q2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Dec 2023 09:50:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oxM5yLVr0n6IOGhTNsfrXoT6lqo5lAx7H6S1jy8rfks=; b=CSKGV/B4eVcqr+G/ezjBRbgNt5
 WEodFs+RYSR9M0vLIQN8AiwCCNfz5LBkwkGO+2IUW5OW50JfxgT4lbQD2eST9k2n662Kw7g13Xk2j
 KEyT3yWPOHgSNJX4N5bx/p01NAQj1TuREIGd5/Q0lbTDIFozWRSRJ/d2D4eoBlk8gHcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oxM5yLVr0n6IOGhTNsfrXoT6lqo5lAx7H6S1jy8rfks=; b=kyGgOzqjCxaaCPH+35ZfWu79vj
 C6RgkFqs0mpCN6B7Eg98puTGGWSliV7oDKs0LzJltZV6tQHSgGm8+jHfqRkftfCdRD0PXS+R5ewsB
 GTPY1NxqFB4932JGiHwUFbYj7Pw1u1jxDLZf+IFruyMisT47HkTvtWHbI2hBF12QHFhY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rFAGS-00055G-Nt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Dec 2023 09:50:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4F69160D37;
 Mon, 18 Dec 2023 09:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2461FC433C8;
 Mon, 18 Dec 2023 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702893010;
 bh=kliH95p4M6Xr4U/JBggiZ+H3u6I+liKEwWc2N1aGs18=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FjXofiJhW9jL1rJtTbtwM+I1TO2JOPuwQLWysbLSk8VmfoJOporitqoAdo9zgM4tg
 KebfTmvh2aktzrLEqFs/N0kl0uX4DvMaJgNWC5QM13PqxOrnSgLHN1nqp1uAZO8aBo
 7JeNjhm1+aVR3evMPZK7qGpZIohwlWocUFheFK/AptmYfRw8IxPGb+DpyXqm17UJf9
 wnuJBeilC1v2AgUTB+kvoBQeW3XHlcSMvr9hL2xfyetrXq63JhRlMZaNt6WyUy3gVx
 cvhYq19/9JgtCumFTXIsxg1N+G7htDR9zvV6CTBfugqodVINZSHaYzg9bz+6On7/xx
 yTtMD2cAMlOqQ==
Message-ID: <816f252c-191f-4517-931a-3d7b14dac654@kernel.org>
Date: Mon, 18 Dec 2023 18:50:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-5-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-5-hch@lst.de>
X-Headers-End: 1rFAGS-00055G-Nt
Subject: Re: [f2fs-dev] [PATCH 4/5] block: simplify disk_set_zoned
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
Cc: dm-devel@lists.linux.dev, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/12/18 1:53, Christoph Hellwig wrote:
> Only use disk_set_zoned to actually enable zoned device support.
> For clearing it, call disk_clear_zoned, which is renamed from
> disk_clear_zone_settings and now directly clears the zoned flag as
> well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
