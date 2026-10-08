Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BD1CA6007
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=30gpHlDleqE4VdPKmOM4OB3q07sqm5cr7qtKt6jxUOM=; b=YnKKi5Mve9Dk+YGO0VmK6ishTq
	eGzE5QzwwgMb86NNp3iVI2099C+mpzaFZS4jgvGFMLYQ/ju+WHZktkgb7nNHcLha1QPknNbw/kgNM
	hRUil78De+6R/JDRwv228e76b5Rj+6L06n1pT++b1lpsEcMvAl/9PWS3IMG8jxetW8z8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEkX7-0002pu-DQ;
	Thu, 08 Oct 2026 09:35:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+5ec9ac32e36676a6fdc4+8446+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1xEkWk-0002ny-TL for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:35:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lWs3Xui8tqzOT+Iim/sKgGnj6GLZQ+VEGbwmVkfcQiA=; b=RzhLLtqUz1eGAr/I2aGWKq9Fss
 WGGRETAUOIDbtKvYCPrBsl+6NZMXvi7mqTgzzMSYsHwma2fVcwZHYpGgK9YNTW0M7yt3OnsIJ438S
 /nFg1JvK9BDyDDQasI39kPdiKvpTo16YXN8d91uD/gOW6aI1GQJEIoSFbDBpmSbH4bbs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lWs3Xui8tqzOT+Iim/sKgGnj6GLZQ+VEGbwmVkfcQiA=; b=eKFj01zWwz5NI3YwSPXRdVDFxj
 Uws5lit2P1eSxlWOy9gMMdVSOggjh0xkRC62vP8gwKGmugtvDsyIhOBZiuXBU0H9pRqT+eL+tpkXh
 Vz+BFmPlvVAQfLt2Y2Z+DuKqnC9EOpWeo2zE5fPZaQkxVtMCwd20Bcvp7zLCAOJf/ECc=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEkWj-0004Zz-Fx for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:35:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lWs3Xui8tqzOT+Iim/sKgGnj6GLZQ+VEGbwmVkfcQiA=; b=ur46IEAIB+u8Gj/UcYMxntPmwg
 ifzgFw3GqFDQ7WJrSBZZg1z6Wy6cO1wyl7HMIbrIeRO5C0GEeB1kdDa6m3TDt2gv+JyhLqj4aan4Q
 mu/otUdrUvwLGIh61+6aaLJXXJZgDxwbIoYvGZoq7ayQtAkOyiU6liqDcLnqyLZtB1ktMxzhJrwow
 67yiCQyclQNNc3tZEWNDnwW5nd2TSueftNoNGqoYSZ+w8ddQDvmb08Kov59/tPYNlZtcxvHL/8FrJ
 wTOenwsdsi/Byd0GjfOGgu4q9GBs7laM9FYrWsI3rC/ikfHZO8eYnUQHaWo7XN0P6sjLJrI4WJ7f/
 GoQswUTw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1xEkWd-000000040mr-2bI0;
 Thu, 08 Oct 2026 09:34:55 +0000
Date: Thu, 8 Oct 2026 02:34:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Message-ID: <asdjv0byRIgx2DBO@infradead.org>
References: <20261008093102.2791457-1-jprusakowski@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261008093102.2791457-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1xEkWj-0004Zz-Fx
Subject: Re: [f2fs-dev] [PATCH] generic/794: add fsync_mode=strict mount
 option for f2fs
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It looks like this sneaked into the other tests, but this option
is bullshit and we should remove it from the other tests.

The f2fs default is simply broken, and the justification in the
documentation is incorrect.  f2fs should absolutely fail all these
tests in default mode because it actually is broken.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
