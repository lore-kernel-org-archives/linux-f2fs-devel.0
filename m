Return-Path: <SRS0=zARH=4J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B6EC35646
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:22:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C705208E4;
	Fri, 21 Feb 2020 17:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fJ89nAdj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SiETqF3c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZtZ/zzjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C705208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1j5C0t-0004tV-7W; Fri, 21 Feb 2020 17:22:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+b8b070cac54c30a96dd5+6025+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1j5C0s-0004tP-61
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 17:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+9zPArLElNepmFofDfBeZ2fYd9Ky2C/8KNsJoicGJSs=; b=fJ89nAdjdWNNikMLp5KfKCdYTK
 1FWRwi62P7QnZDLcWk5LKOVi8PV1Giu3SsWjH/dmuUlmkoPC6toOkRDaWeoXRKOMwIaxSuXkRNkao
 1wNBtJOCtxofyw99oCBPEktpBsPt7OELQYvmSu6tDNFi53J4GGzZZhW3X84knMN1rG78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+9zPArLElNepmFofDfBeZ2fYd9Ky2C/8KNsJoicGJSs=; b=SiETqF3cPOwLsgY7s5Gci05DfY
 ovG6DzXiujZI8l2yojlxoVvhCF0ON6Jry27c0M3lbZnQbcOkZZvetlJCcOZrDwx9Rb+aRUnAanQyC
 niA/7qYPuDD3Tj3iOQlCQNbdpF3lYx8n27c+k/YCkvBixKU1DUY3LLPaPXr113hPANn4=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1j5C0o-003TBJ-Jd
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Feb 2020 17:22:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+9zPArLElNepmFofDfBeZ2fYd9Ky2C/8KNsJoicGJSs=; b=ZtZ/zzjY4QZauehBMVxj/JluwD
 ttlA/fYN6KD+QSaa+9jUB3VqWsDBsferiztcwCniVqNoF2ha+FpTKL5OYooAz/UWnxnMRkL0Tr61M
 ECpP1oIkN5m1Oiwa0fCw1H+aEEkmHuM6wTaT0XPFWOkOBHon+CU+NwflwkJUepw0ySejq4gZrgV7T
 bB9uMG4ytHCrq1FyXdhLV+ZVej6lXAfjQKiBYznpFK8uxQ/uEETJtLs6dyXIg2gD/RdjLdYYwl2kt
 21LcQdDeGezUMi1eSmieYK2Ue79KohVX8CVofhlg+syNjZEj1wpcEXKw8Sr6/nRFek9UH7v2vCqmA
 11AtBGCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1j5C0i-00067Z-QR; Fri, 21 Feb 2020 17:22:44 +0000
Date: Fri, 21 Feb 2020 09:22:44 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200221172244.GC438@infradead.org>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-7-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-7-satyat@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1j5C0o-003TBJ-Jd
Subject: Re: [f2fs-dev] [PATCH v7 6/9] scsi: ufs: Add inline encryption
 support to UFS
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Feb 21, 2020 at 03:50:47AM -0800, Satya Tangirala wrote:
> Wire up ufshcd.c with the UFS Crypto API, the block layer inline
> encryption additions and the keyslot manager.
> 
> Also, introduce UFSHCD_QUIRK_BROKEN_CRYPTO that certain UFS drivers
> that don't yet support inline encryption need to use - taken from
> patches by John Stultz <john.stultz@linaro.org>
> (https://android-review.googlesource.com/c/kernel/common/+/1162224/5)
> (https://android-review.googlesource.com/c/kernel/common/+/1162225/5)
> (https://android-review.googlesource.com/c/kernel/common/+/1164506/1)

Between all these quirks, with what upstream SOC does this feature
actually work?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
