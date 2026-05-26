Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02530CD5BC8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 01:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FFpjFlotdqtm08G2nEtjV5A23pGaBdHG/cQA8gh0nWM=; b=TJClme5+YR3ebHl2Ht/eKzvzhQ
	rpWRw4O0+4c4wOhKMfVIbnPGLRqZIHCwoxrTXWDcRyR/TzZWGjbDNJofXq6syzL/yf5Wtjuh7cWs7
	sHmxpzZ56k1o8fpOP+olpwYg7RXuoWuUGZqLPKDv1foR+iUAZgeVrtD5aBGdAib7FedQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRgUU-0000Wr-My;
	Tue, 26 May 2026 01:21:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wRgUM-0000Wg-Ru
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 01:21:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K08IF8WJnEk+HHOzE8UXb7WzEnURtUvmOtiXBoUticQ=; b=OANeHxtKgXS0FL56GCm5bqwRfJ
 k2BPagRTuAqSIIJ43q98vkBiup/WbcvtGI8k2jNmxG1ezK/q1HxT2kv9ZnmJdPPjO6a6Mr0yTZJ9c
 O4Oi8CW2tJXCh6gwKbIbFFLO29XLKMtC2cTelCeaLW5waNn3LX5/6+KeZaJQe9o5xNyA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K08IF8WJnEk+HHOzE8UXb7WzEnURtUvmOtiXBoUticQ=; b=OkqGf94XQNEjXfPA051Fzu9zbZ
 HYp8rpJ2hemji20oEOmcKVCMUpd5/YIroxQ+2apCbGMyTZn4aGI7cx/Jsir15uVop84igCWmNcdYd
 bhANj0a+E4tdcdtPq+hEsWiXtsMPgpn3BTeCXjigNfeawaBjBuzukZ6y9NTdFvWQ5tFg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRgUL-0007CW-MD for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 01:21:47 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D1BC6008A;
 Tue, 26 May 2026 01:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC0D1F000E9;
 Tue, 26 May 2026 01:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779758495;
 bh=K08IF8WJnEk+HHOzE8UXb7WzEnURtUvmOtiXBoUticQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=n0aBwEs0x5kOqgOGmfUYYQ9pJ4qZYr13caDsJNheuSxzlcgldJfVTK5poT02FgMBr
 NwwPAddG/4BDkWWsJV7ldW85k/uSYyh+2C3X+q2lF9QrvKVRtxz93mIBkSqArTl53G
 8Kt+2kJg1gIz3ua5R6yoqVSdQchm5ka34qy2JKKa/YfuxJAHwX4WoeG/MiPeFy8WWR
 EpMEBen6Oyd4wWZ7R7L5WeMRH2Fxh6Vslu9ypoHIa8LiC+D2g5hButVboP1RRpw0Zm
 h//Q4aUcFBi4PkmMMfxqvmNluuiVym4t4ZBVAEzv/gFG9DymNyS9IaTN41kRRR7A6L
 xz/CO9YO/xZKg==
Date: Tue, 26 May 2026 01:21:33 +0000
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <ahT1nT3xsMGkyJab@google.com>
References: <ad30g9xMs9wNJhFb@infradead.org> <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com> <ahPffhaOi2CBtWof@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahPffhaOi2CBtWof@infradead.org>
X-Headers-End: 1wRgUL-0007CW-MD
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/24, Christoph Hellwig wrote:
> On Fri, May 22, 2026 at 02:04:59PM +0000, Jaegeuk Kim wrote:
> > This was a quick buddyinfo right after booting the device.
> > 
> > Before:
> > Node 0, zone   Normal  22684  42284  28704  16901   9515   4566   1854    673    181     36    758
> > 
> > After disabling EROFS large folio:
> > Node 0, zone   Normal   8486   4732   2175   1161    697    272     82     19      3      1    856
> 
> And what are you trying to say us with that?

This means, high-order pages were used up by EROFS which sets large folio by
default. So, I wanted to say the concern was based on actual data which was what
Mattew asked.

> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
