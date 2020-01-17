Return-Path: <SRS0=qGLh=3G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F0C33CB1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jan 2020 08:52:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2572072B;
	Fri, 17 Jan 2020 08:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TV3rjcqu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cbFROteU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xe/CtTAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2572072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1isNMc-0006lx-Rp; Fri, 17 Jan 2020 08:52:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+99029fa5cb4ba764ed81+5990+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1isNMb-0006lO-Nv
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jan 2020 08:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uk9hxsXkJLJEIYTwSPwZJzvzik2eaj4S5b5zonlGVPQ=; b=TV3rjcqu+/iEKoBKj2tMkiotiW
 jMASfTbQuf8aW/jc33f+oPUtShHe2VegHAL3H9lLyCUQcc8k/T2YfvuDhHEEu1Zqk3kDjAh0IcSal
 hWNXIffugP9EZjJasvz57eCNz/w5jy1vkKak91XzY0qvH4uoSCHcC1Gd2SBceKYEe9SU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uk9hxsXkJLJEIYTwSPwZJzvzik2eaj4S5b5zonlGVPQ=; b=cbFROteUASBCG5KX5JpGqBDmKA
 Zge9Xu8K1pkcC2U6d2+Zfzb4Ns8PB2xMxmdWZPH9sPI9mcTioMVl0phndzJiS2wO0b2EkGQ6AJUP1
 /LggmCBl4wam6enKzjBIOpduxvurnKKvmbDSCUfLG+M1HS5pjqnEUtDmQHqGC/U3rBKc=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1isNMa-007z8x-F6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jan 2020 08:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uk9hxsXkJLJEIYTwSPwZJzvzik2eaj4S5b5zonlGVPQ=; b=Xe/CtTAFsYpJiKhxglqQxcAqx
 1AQ17yCuDFnvlbeQtnVS4VfE/kRKCfkJD3sitm2mM0G4dCe77//iKVnxbl8AZv9RFNUDF7ZUDV4Lc
 smvCh5aM31Ilh1kWMdVSO4reC7dFS0i3NVL+2lZGOzRZKTWWPuZi8fZK1MWWLq16HQ6KvLHlyXsVf
 yaUfSde9vSsxFQRQGFL3nwNpVYGIVcnyjXFys/E8MI8n3Llg+Io7Il+cd6tlJjxc45r0ZbzMQf2Kg
 hJrKxm6h2/id5QP+c0f9SFr2oTVcJx51WzrIDd7fN5HIVlkMaWm6RyCz7RqXcEA5TPPJxaSdsj9Sm
 muWh7jG7g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1isNMQ-0003GX-3o; Fri, 17 Jan 2020 08:52:10 +0000
Date: Fri, 17 Jan 2020 00:52:10 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200117085210.GA5473@infradead.org>
References: <20191218145136.172774-1-satyat@google.com>
 <20200108140556.GB2896@infradead.org>
 <20200108184305.GA173657@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200108184305.GA173657@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1isNMa-007z8x-F6
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

Hi Satya,

On Wed, Jan 08, 2020 at 10:43:05AM -0800, Satya Tangirala wrote:
> The fallback actually is in a separate file, and the software only fields
> are not allocated in the hardware case anymore, either - I should have
> made that clear(er) in the coverletter.

I see this now, thanks.  Either the changes weren't pushed to the
fscrypt report by the time I saw you mail, or I managed to look at a
stale local copy.

> Alright, I'll look into this. I still think that the keyslot manager
> should maybe go in a separate file because it does a specific, fairly
> self contained task and isn't just block layer code - it's the interface
> between the device drivers and any upper layer.

So are various other functions in the code like bio_crypt_clone or
bio_crypt_should_process.  Also the keyslot_* naming is way to generic,
it really needs a blk_ or blk_crypto_ prefix.

> > Also what I don't understand is why this managed key-slots on a per-bio
> > basis.  Wou;dn't it make a whole lot more sense to manage them on a
> > struct request basis once most of the merging has been performed?
> I don't immediately see an issue with making it work on a struct request
> basis. I'll look into this more carefully.

I think that should end up being simpler and more efficient.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
