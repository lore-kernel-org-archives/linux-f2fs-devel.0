Return-Path: <SRS0=Z6GX=3X=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F66C3524D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:16:12 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510852070A;
	Mon,  3 Feb 2020 09:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XG5Bq9Cx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UXV6fYU3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ij6N7tAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510852070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iyXpz-0007Ag-Q3; Mon, 03 Feb 2020 09:16:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+57336caf17137e9598f7+6007+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1iyXpy-0007AV-QS
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 03 Feb 2020 09:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2WbZ053ra9RftP4cOTLZDHvYMDipdLzrXoaF3acCxEw=; b=XG5Bq9CxIS++xpsDFlmJRhMNow
 L59qgrvsGWNN91etPRo/hpeR79slFIq2jTozIIRugromNuZw3h3/GGoY7zr7MT65X4FdXNOF2jQ2o
 A3rQJAU+WA2nNPlBldJrTa0EoBYkwm6jyd6SxAUNQ8mfN/YrNygEGBDnLrzclKmKgsAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2WbZ053ra9RftP4cOTLZDHvYMDipdLzrXoaF3acCxEw=; b=UXV6fYU3dTvft32iGn4YjSmEYo
 iZiymQ91li0n3excQfb6RfoNrxaE3ZAwmeofbNdEfHbcliVdwCNe1dQF/TCvhu9STl44u+4QSyGrS
 QBQqiKZrv8LCifHm9TGvq+2a7y0v0RBK4MdVBFtv5jLQZMmJwQIq6jhwZTd3pMYI1D2Y=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iyXpx-008vUS-Jc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 03 Feb 2020 09:16:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=2WbZ053ra9RftP4cOTLZDHvYMDipdLzrXoaF3acCxEw=; b=Ij6N7tAj9PNAsgWcYPONFwkGZF
 6/rsne7c76sZHSwBndrw6DFgF3uBY46PqcDbd+uKJmjLT9wDAVNDx8sRlDLgx5DhezaRIdS/dBRjB
 9giP2kzRCHbCjI8Mj06U8v5KNWqPCF3dEGOTL5qpFe721cYEOYoxEs3V4wOKHUJiLSlyBWdQc2GkB
 n80ACVEhQIaFwxrD6aoy8L6rbIihA+yFTg2OsA74L0ZLb/l1C5ZX0ILlQYpxyIj4lha7cqGPC4gKC
 d8Dd6GHgEQozCR0p+BobWCl6EVFm1aPrqM+NnSgBu/8CwEkE5hWgeXljriobRDRdgJwsCvR09tpa9
 vZpgFz5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iyXpm-0000Mh-HM; Mon, 03 Feb 2020 09:15:58 +0000
Date: Mon, 3 Feb 2020 01:15:58 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200203091558.GA28527@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
 <20200117085210.GA5473@infradead.org>
 <20200201005341.GA134917@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200201005341.GA134917@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1iyXpx-008vUS-Jc
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Inline Encryption Support
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
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 Kim Boojin <boojin.kim@samsung.com>, Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jan 31, 2020 at 04:53:41PM -0800, Satya Tangirala wrote:
> So I tried reading through more of blk-mq and the IO schedulers to figure
> out how to do this. As far as I can tell, requests may be merged with
> each other until they're taken off the scheduler. So ideally, we'd
> program a keyslot for a request when it's taken off the scheduler, but
> this happens from within an atomic context. Otoh, programming a keyslot
> might cause the thread to sleep (in the event that all keyslots are in use
> by other in-flight requests). Unless I'm missing something, or you had some
> other different idea in mind, I think it's a lot easier to stick to letting
> blk-crypto program keyslots and manage them per-bio...

But as far as I understand from reading the code it only sleeps because
it waits for another key slot to be released.  Which is exactly like
any other resource constraint in the storage device.  In that case
->queue_rq returns BLK_STS_RESOURCE (or you do the equivalent in the
blk-mq code) and the queue gets woken again once the resource is
available.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
