Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F265CCA6007
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HihK1e4ElVXLI6qQOF+hTLF6STp6K3ZQ5o18idsqM+Q=; b=Vh2pD3a9EGyIZfqlg8MKb8gKrT
	FYb3kv1pEbv+EXN2KntKxc+l/TF0n7zaPRWqdQJWQyUkC4OLADo/F+eFL5bsGQ3W2vg7ABXMsOO4M
	xbImr6y1fwufnYqagEq4iKBzYTDcOqCzI0PpcvM3hsSkVoP9WIRIUUPWrbuJkQsuKA6g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEkZ0-00031b-Og;
	Thu, 08 Oct 2026 09:37:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+5ec9ac32e36676a6fdc4+8446+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1xEkZ0-00031T-Gm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LMJg22Psx8nLoW1hY1581RbqFqeaOcssi/dsbMbo4uc=; b=Gh7712CtRxpip+2Oh8IVBa24/D
 jTAtjMGtmEzeLC3gWEtpMq5zOtfmrrSpuCFnu+jxF/MkIflusz4Su8Odhqk6BSnqmh2naBQTZXRLC
 FTja+7oKEXX9D5A/IbEyV/131dqaSpR9RojTyAKO2Cl+TbHUPHDw7ek/U8Rd1ZmhOJU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LMJg22Psx8nLoW1hY1581RbqFqeaOcssi/dsbMbo4uc=; b=jQJoAMXXTVG9U39Alhx/eZUQvU
 TW3cGal91fUG/LYLFBWQyZSkcj0f64F2+u8na1b/ciulINbLnb1zyLvtR49+kHvDjIs1T++QkBFy6
 bh/HZMYY6yXSw/diERKj7S9b2cgWhWdWSKAqnQhV0vIUh9LWCOPhfsJZ9m12k+f1Vxdc=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEkYz-0001KO-QT for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:37:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=LMJg22Psx8nLoW1hY1581RbqFqeaOcssi/dsbMbo4uc=; b=aOmAULkQ8BR0cb/Dr8TF5kAQba
 opM0exc8YGP/P3OWCWHoEne0bgO5aTsYv+ZAhQfZNiv4dTAB+PolbVEWUunXupxzs+jiAbahKDUYV
 u3w3+N74ZzT+kZkRVaCYyMFOqc8rTK7Ieb7iyozdYlUJx+buV9PIY7GigFPIT/UEj7R5r0zhsalwh
 g1RhjSCSR271KRQvlODtA5iNKRMVtKmhVyW6Llj4CrtlvwCXa9q53H4RKx9EW0q9ux4f11DdiJujb
 q9Vd2IFY8YC4qwscExkQhLd502raMqrecafknyxJaFKxPH5ShLGGSBTgf7CiOjZZ01mkgSqC5aUrc
 TZhY6cBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1xEkYu-000000040zi-1Zq1;
 Thu, 08 Oct 2026 09:37:16 +0000
Date: Thu, 8 Oct 2026 02:37:16 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Prusakowski <jprusakowski@google.com>
Message-ID: <asdkTCwh9hW5gkEJ@infradead.org>
References: <20261008093317.2792726-1-jprusakowski@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261008093317.2792726-1-jprusakowski@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1xEkYz-0001KO-QT
Subject: Re: [f2fs-dev] [PATCH] generic/622: increase sleep time for
 lazytime expiration on compressed f2fs
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

> Increase the sleep duration in expire_timestamps() from 2 to 4 seconds
> when running on F2FS in compress mode to give sufficient margin for the
> flusher thread to reliably expire the lazytime inode and dirty the inode
> page before shutdown.

Please just increase the timeout unconditionally and add a comment
explaining it.  While there are some historic hacks like this, generic
tests really should not have file system specific conditionals.

> Change-Id: I208bf14c189b54cc209059b0fd2de9e403a073f2

And please don't add useless not-standard patch trailers.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
