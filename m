Return-Path: <SRS0=O1Ha=ZD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A19C43331
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Nov 2019 10:23:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD55214DB;
	Mon, 11 Nov 2019 10:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="aft7O959";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GcOscFRz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWDUAfwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD55214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iU6r5-0003Dn-0h; Mon, 11 Nov 2019 10:23:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+751287479349e3a6a75e+5923+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1iU6r2-0003Df-Te
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Nov 2019 10:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rsrc0hw15XFvUS1BF0cnd7QBR4nqLE43XWK8jb8pnzE=; b=aft7O959n0+AmTTXjeKOkKiWMu
 0fLGvUckYDYFzqiFo0k2W3JmTsWQNSD7cA9Gggz4FbPvbF3eD4Vl+SqyoDn96CvrXPfaXVFMiM5xn
 KB8cThzaTfpl1sn2ydZhnwtHKHDUD8b2POeRnEm76iDt1nxiO1ERPDwW5bIlodPrdTtw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rsrc0hw15XFvUS1BF0cnd7QBR4nqLE43XWK8jb8pnzE=; b=GcOscFRz18kZa1j81xruD5hERh
 V+1pTX3t2Igzu9QS64bKDJr/wt1XcbWnKVd1h8WHtMbT2l6+ZE2/GRM85HNPkURTeTnhtXfc57/jB
 9Wgs2UzQ259t7xhKdP9MTaxwLLi/VmInFYjU33Y5BytAQ/JMkkY6TPRLnK4qZrD7FCDI=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iU6r1-00Bu32-7U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Nov 2019 10:23:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rsrc0hw15XFvUS1BF0cnd7QBR4nqLE43XWK8jb8pnzE=; b=jWDUAfwSsKiB0sckHhneGHYAj
 9OnETJBBXAfFSPzpdDJfeXV4WXPcmqdi5e1wBm5Szpjelrjnp8kPWC+XJwclLLzwj30ej4PaaImBm
 LiSV0zVnyKhPDlPe1CArH8J65tsP+xgbDrjRzdVr6+SQR2fJQjKunQG34NuP0GmwngqietPNezzvG
 scrPh0QEEe/Oc3tUIzAI0ojgTOOVvlcheInxaeMlTu27Fk6/APNgKpwiA3omvAtl31JvjNL3KFmxR
 oXnih/xP1XUO2YMOKlYG15xKFJwiUuTAvzKg5jbtdlQE07t1+TtOS8w0XaRa4g+yVyGCaQPB/nJ/X
 mRYp6VdZw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iU6qW-0000gA-Fm; Mon, 11 Nov 2019 10:22:56 +0000
Date: Mon, 11 Nov 2019 02:22:55 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <20191111102255.GB727@infradead.org>
References: <20191111023930.638129-1-damien.lemoal@wdc.com>
 <20191111023930.638129-9-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191111023930.638129-9-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1iU6r1-00Bu32-7U
Subject: Re: [f2fs-dev] [PATCH v2 8/9] scsi: sd_zbc: Cleanup
 sd_zbc_alloc_report_buffer()
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
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, dm-devel@redhat.com, linux-scsi@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Nov 11, 2019 at 11:39:29AM +0900, Damien Le Moal wrote:
> There is no need to arbitrarily limit the size of a report zone to the
> number of zones defined by SD_ZBC_REPORT_MAX_ZONES. Rather, simply
> calculate the report buffer size needed for the requested number of
> zones without exceeding the device total number of zones. This buffer
> size limitation to the hardware maximum transfer size and page mapping
> capabilities is kept unchanged. Starting with this initial buffer size,
> the allocation is optimized by iterating over decreasing buffer size
> until the allocation succeeds (each iteration is allowed to fail fast
> using the __GFP_NORETRY flag). This ensures forward progress for zone
> reports and avoids failures of zones revalidation under memory pressure.
> 
> While at it, also replace the hard coded 512 B sector size with the
> SECTOR_SIZE macro.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks fine even with the __vmalloc usage:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
