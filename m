Return-Path: <SRS0=D49P=65=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2679C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 May 2020 14:42:40 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0D7A20671;
	Fri, 15 May 2020 14:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bnz6WDYT";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GIUrYFr/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UR/nOTln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0D7A20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jZbXr-0003Ma-Ip; Fri, 15 May 2020 14:42:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+e5f7f93d3739a79b60a3+6109+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jZbXq-0003MQ-HM
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 14:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3iIrLwrSNZL+S3txYZ5ooYztJBCNqoUdcfH+RABdtvQ=; b=bnz6WDYTgLuDW2k/dhxgEYhzZu
 aNkerO4Zb6jRU49cGvDmAHom3JxQ6Qz5ekmezwrFmQfqmczSiSD0ZVjjlYa5sG3yj+EKufbLL9Nlp
 u65ImAeW25uBbZSKGb8Teqt/bLcUyDzfJvx42/4pQyoLzo+DwrI7EbgztzOFhcRRpMrw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3iIrLwrSNZL+S3txYZ5ooYztJBCNqoUdcfH+RABdtvQ=; b=GIUrYFr/F0Boq37SHJvtjP0vun
 jK9gRs9qnA3qL8erPVUQ/R0zn18lpSe4BD6h6o5YT80wyMhQaMlaGEy6zNqLiWcFgkt3Gg0TO9tGU
 yYDOtdSX/sGPoaVmAdcjuROnoFHdH5L5DsLpumJmOVs8THP1sYLSnBj5ioEVs4FkvOQs=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jZbXm-00Bhfu-5g
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 May 2020 14:42:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3iIrLwrSNZL+S3txYZ5ooYztJBCNqoUdcfH+RABdtvQ=; b=UR/nOTlnhIjsUEaBJZCcE3BngJ
 mfu05i2j+WxKcr7aadUXmtCEMRqOGo8WlZiQcx/CF8O8Rt7VlltOFibGIiO9P22FMxwIm7yBF8pe9
 eEuctwJJMTPdOLuB8TUsI66Z8LbJfV8pRhC6x0MIbl2R5sDpGINXt46eX1O7UBNhHMd1KH7QjKpiZ
 /5Zl8grCV+zYizEQ8IUVoKnDv4so/Q+I9YBcJP6FHitob64xgOTqY8THukAMIu6SoYdmnPlFrqER/
 Sz/OPP9samLEqnBB+HoFo8cCU8Zk0RqWmPgXOuI9l/9nOTkQMdZWW+2MZHgH6F/gb7Upu6y68wMpy
 mKCQoBMg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jZbXc-00040w-57; Fri, 15 May 2020 14:42:24 +0000
Date: Fri, 15 May 2020 07:42:24 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200515144224.GA12040@infradead.org>
References: <20200514003727.69001-1-satyat@google.com>
 <20200514051053.GA14829@sol.localdomain>
 <8fa1aafe-1725-e586-ede3-a3273e674470@kernel.dk>
 <20200515074127.GA13926@infradead.org>
 <20200515122540.GA143740@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515122540.GA143740@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1jZbXm-00Bhfu-5g
Subject: Re: [f2fs-dev] [PATCH v13 00/12] Inline Encryption Support
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
 Kuohong Wang <kuohong.wang@mediatek.com>, Kim Boojin <boojin.kim@samsung.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 15, 2020 at 12:25:40PM +0000, Satya Tangirala wrote:
> One of the nice things about the current design is that regardless of what
> request queue an FS sends an encrypted bio to, blk-crypto will be able to handle
> the encryption (whether by using hardware inline encryption, or using the
> blk-crypto-fallback). The FS itself does not need to worry about what the
> request queue is.

True.  Which just makes me despise that design with the pointless
fallback even more..


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
