Return-Path: <SRS0=IwMA=6M=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE402C83004
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2020 05:20:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9954B206A1;
	Tue, 28 Apr 2020 05:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="j7nymMC2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="CBWxasC7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejvrm4cY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9954B206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jTIf9-0001u5-UD; Tue, 28 Apr 2020 05:20:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+04e88780fe354b781c6f+6092+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1jTIf8-0001ty-36
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Apr 2020 05:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N449VoWVR375Ueo46T0G2hb5JRZUT8vtjXxmy+kIL1M=; b=j7nymMC2NbvSRpW8g9zrulELRI
 T71ftFQsMhbxcxdy7W+msBr2Lq1aN20hIcj+NbPNDLumEd6QTb1/CVTR7igOPhQvXzrx7OojiAx60
 yGzkZMZo7rW9xN2ksnDaEgfkLk9bavb9PIROdtBgHL/SCersNuJUloenoaUMMjFl12/M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N449VoWVR375Ueo46T0G2hb5JRZUT8vtjXxmy+kIL1M=; b=CBWxasC7WjhH3jny8tUpU9jOmo
 7Lzsyj2wbavxHjICR3C+hLdg+dxLRw4bqzd+G25MV4Mt3PASjFLpdJTxFERnqZMt/HiSh3wpoUqfX
 4C4oH69FCO0duizNnO9N42iZ3jeOpWuG1yrSeTpsAui4ncdIMJ+97+VwNYa2ovi1bqgw=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jTIf6-00HAwl-6L
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Apr 2020 05:20:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=N449VoWVR375Ueo46T0G2hb5JRZUT8vtjXxmy+kIL1M=; b=ejvrm4cY1yi+VTSCq/t35ySQyX
 UPercnk+hk9IJM/1hiaxfTZnhuAUZKJLcTDqAnOhGhTbH7t2HYgu560oHc3D2+l5Cn34+crYZhQFQ
 Cwak6HIDVECaaNRVzEN1HBXHvRwz9zBGQVZpiJP5Ebvv/t5abbG/KGRs2Lh0InESVWPk9wGYg47Us
 DdM/Ux4lqUNnrcuGuo/Tz7GgeYs80wNbXlUzywNEkdE6mkms9v39QHeKHoKVkqJJj6EMkP7EPJ0l+
 vZ0W3pJd7gUXalqLQB4ULw2ydhQp2xEmvF6tlfO4qLLpKizPgdivo/DqLzb3yTj3zah1VUvkM3L/8
 oni4IHig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jTIey-0004fp-Vi; Tue, 28 Apr 2020 05:19:56 +0000
Date: Mon, 27 Apr 2020 22:19:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20200428051956.GB24105@infradead.org>
References: <20200408035654.247908-1-satyat@google.com>
 <20200408035654.247908-3-satyat@google.com>
 <20200422092250.GA12290@infradead.org>
 <20200428021441.GA52406@google.com>
 <20200428024614.GA251491@gmail.com>
 <20200428025708.GB251491@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200428025708.GB251491@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1jTIf6-00HAwl-6L
Subject: Re: [f2fs-dev] [PATCH v10 02/12] block: Keyslot Manager for Inline
 Encryption
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
Cc: linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 Satya Tangirala <satyat@google.com>, Christoph Hellwig <hch@infradead.org>,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Apr 27, 2020 at 07:57:08PM -0700, Eric Biggers wrote:
> Or maybe 'struct blk_ksm_keyslot' should contain a pointer to the
> 'struct blk_crypto_key' rather than a copy of it?  If we did that, then:
> 
> - Each duplicate blk_crypto_key would use its own keyslot and not interfere with
>   any others.
> 
> - blk_crypto_evict_key() would be *required* to be called.
> 
> - It would be a kernel bug if blk_crypto_evict_key() were called with any
>   pending I/O, so WARN_ON_ONCE() would be the right thing to do.
> 
> - The hash function used to find a key's keyslot would be
>   hash_ptr(blk_crypto_key, ksm->log_slot_hashtable_size) instead of
>   SipHash(key=perboot_key, data=raw_key).
>   
> I might be forgetting something; was there a reason we didn't do that?
> It wouldn't be as robust against users forgetting to call
> blk_crypto_evict_key(), but that would be a bug anyway.

The above sounds pretty sensible to me (but I'm everything but an expert
in the area).


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
