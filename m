Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53B7CDB479
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QHVInfWpr7IxX/6jTdeooZMH31wCMaucKxRD8MUzUTc=; b=HSiFBwbzHje5yk5DN8hQDkf1U8
	EmhqJZHxO58K2kxDj2edrWeiXSaU7Yi06zlQRXKWWLXdVyIr5NvPWpQAFFnL+9hXETcCDhxmqbikg
	c57/e+5qs9Qb+IcFNrKWZFN7LwfcTQo8AW09j/2bqxiV7xSl2ZXf7SolTed+3Wwh2TQ8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wcT6L-0006NY-7v;
	Wed, 24 Jun 2026 19:17:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wcT6J-0006NQ-1g
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 19:17:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bqBc39xoDehUWuVu6AI6mn/gD7zXjqbqDQU6DrDbctI=; b=gchsjRF057wH5GYsWIE3uCKK7z
 uCtZfU6mbtZqx5mPtyrrK76CZW0IegtTNQknHBacdAloABlqifxzUVLwFXIQWbPHqZit4tQUwlIp6
 N9Bi1k75SVNy4Rid9x4i0ouV4kIrh+QGvZUBcloTLz4RYYy3jmQwcCXQNmKwpT+aLkm8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bqBc39xoDehUWuVu6AI6mn/gD7zXjqbqDQU6DrDbctI=; b=i
 VEW0HkHfFSefaDza4jkZdfMRWcNZk6uMuEq3v3PaJ+asQaK+UEjDS2gIj23+SlGAlRcxX7yPW+Nib
 TJlmHi9Q0MhGDWJv6U439+T/ldZFaPnV2JtbMCBBVYqmXVJzADek4d7A8agFTxU6YDnbyynhcnFTS
 gT9Twi4EhOqWhOsE=;
Received: from [90.155.50.34] (helo=casper.infradead.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wcT6H-0006Wn-L7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 19:17:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=bqBc39xoDehUWuVu6AI6mn/gD7zXjqbqDQU6DrDbctI=; b=P3Blr/FQoLsDznHwZjUUmuCF4A
 sZb56+wF7UCTV/Y/5WVd1/j4fTMY21gJkKubCLELbgnA7qjvYu5AnU5KUlaftQ7Tdp5QRFpkBnf1Q
 xsPtZtPJYHPsuYRowtANcexfKkz4HXgiI+rsilTZahhtJKw5IsgWQ/HyRe3bY5+u9hflDjOTiSAe6
 T+zWrOLGCrgsEhfzjLDbMJWzPpeZwOvXpUUPE6yCI/NMORylPALoZBEkHbI80ZmduQ3RAKlA6Etqe
 BKY70iGiBmTGe/HkgV2UV2+AlSd/cil7U/0+LnURnH6yypLT0JKTEKkNc1yesAjt5+nvfQ+pCsiSZ
 LWiKhpjw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wcT69-00000008Zuo-2VOT;
 Wed, 24 Jun 2026 19:17:22 +0000
Date: Wed, 24 Jun 2026 20:17:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jiucheng Xu <jiucheng.xu@amlogic.com>
Message-ID: <ajwtQRawMxcQkyo8@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1wcT6H-0006Wn-L7
Subject: [f2fs-dev] Use of FGP_NOFS in f2fs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jiucheng,

I am trying to remove FGP_NOFS from the kernel and the last remaining
user was added by you last year in commit 2308de27c03d.  I'm trying to
understand why.  Did you see an actual problem if you do not use it,
or was it theoretical?  The commit message says "to avoid potential
deadlock issues", but it's not clear to me whether you know they are
there, or only think they are there.

I'd really like to understand what the issues are as the normal issues
which make calling into the filesystem (holding another folio locked,
holding a mutex relied upon by reclaim) don't seem to be present.
So if there is something, I'm not sure what it is.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
