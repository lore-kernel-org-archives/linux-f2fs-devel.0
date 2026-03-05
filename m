Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D451F33A6B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofrahNIYevUqU0nqXcODtr7/vnfmrSMMUQcPIXF18wQ=; b=cUCvvgW6ny06WndqadhStrNVOg
	LEJhBTNYkHL3osMIQbaE469Dvh6AJZTJiv2bqmGzhIATt+IgE/YOgtG3bIlB7VHZybzPrSr07hb6l
	db7W/KwEwGJmMe3WDSHC2a5Gy7jZzaZm5y0MgJPuojiCnBuwK2R93AgGBc6S7LOUW1TI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vy9SP-00029J-Ud;
	Thu, 05 Mar 2026 14:13:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+2e11e6930e970eb8572e+8229+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vy9SN-00029D-NQ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 14:13:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TJHqUqNeTMnXyeDzlG2Ut7/dGbTr+YA33QxUyT5WrQw=; b=MjFOKtFEr2t7f2Wq1Z5lgJdjRs
 UalHXTabSCBlU5j16IztP9/ehKapwHRtobpBGgXUNmaKMOkFNpRRrT4/eCBrNoXLco1clqX9gBUQ2
 W8QscHeryrfUYZ3h1FDrvHu+LRdC3taFzJO1AoNWzuT6Ajr3Vx2CztvbY8gLAOYixKw4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TJHqUqNeTMnXyeDzlG2Ut7/dGbTr+YA33QxUyT5WrQw=; b=d3p/vDQMLVpdfdIq7I3nzXqdZL
 UMp9I4QJJMNgNw/yHGbnDZxhCXs5253UaDNjGcj1XYNUAf+eiNSHC+gjxqv32GxTCubUivUwC4fFI
 9FQqZ1vhNFmjHPRJtwehf8x2pl351bEDEfXWn09i9ESv/K/wgLpBOKdyq/Yp6x+pD4Vo=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vy9SN-0003aF-Dh for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Mar 2026 14:13:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=TJHqUqNeTMnXyeDzlG2Ut7/dGbTr+YA33QxUyT5WrQw=; b=JZFHlKMrZ1roVh1G0oP4L2vexm
 FrZLBd0jy6czxnRKQ/Lp3Npu1Qkrd7nbareKkkH2li+1DxXvSs8mlSnt2tdCuiE4YnjL/3vgEJ6CJ
 m9GkA7a20axqbOCR/1dnVqK9zB5Z3dhfQkuoOK3kNxyT6XDzbneSodjsnP1MlYd/5Z2L9eUpBHMQJ
 pzhwzOFNoBtT+4onbzGRsbncLY5EMgD8EEesXVvOH3CyEFYYFOfMKFZKt4m86vEcMuEuh+INhV23+
 H/NL9mqTOZOo53eCjEvvM5LdzVOUt2x4shKhcQqbcqy4upmn6LNgg8Exm0P0vds/XCM8XadKBu7QI
 +e3ZJO5w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vy9SH-00000001vXu-2o3v;
 Thu, 05 Mar 2026 14:13:33 +0000
Date: Thu, 5 Mar 2026 06:13:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Message-ID: <aamPjXeF0qHlhJZu@infradead.org>
References: <20260304190424.291743-1-agruenba@redhat.com>
 <20260304190424.291743-3-agruenba@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260304190424.291743-3-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vy9SN-0003aF-Dh
Subject: Re: [f2fs-dev] [PATCH 2/4] block: get rid of blk_status_to_{errno,
 str} inconsistency
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
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Mar 04, 2026 at 08:04:07PM +0100, Andreas Gruenbacher wrote:
> Change blk_status_to_str() to be consistent with blk_status_to_errno()
> and return "I/O" for undefined status codes.
> 
> With that, the fallback case in the blk_errors array can be removed with
> no change in behavior.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

While you're at it: blk_status_to_str is exported, but as no modular
users, can you also drop the export?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
