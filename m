Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113F1CD5BCF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 26 May 2026 03:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ivyfFn8c4Sctw+OqIU2ZNy7r09nNfuw+acL40l0Jcnk=; b=JmSfRw1NANeBt4HEtmNwt+Wojk
	oF43EtzaHMsv82DCuCfN3U0dxc5mepmxBOj/8GLwzhw0UzrX/jS43Pf6MfK0+FvrH8ycX31EDPmfP
	AMRjA9VKEA5J7cIzf1229VOOe/5n3VmMESF4uPipfrrabVEIOXK2vPS7vAED9z7snr1o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRilt-0006HR-Il;
	Tue, 26 May 2026 03:48:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wRils-0006HD-61
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 03:48:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DxyY+bYQ0Eo648ljGRU7X1Wi24vXYHPFWC0Fu00rbQo=; b=MNtdLhoWNeWZfNMIBqLGAlp3Wf
 43A/mRq0Adp/TD4wCAnGhhEa1lLXTOVokrFLW7nuKpiP6heeYpqZx+HScmD4W8+do0kGXltSMhQXe
 19QTezymxT4tHY3Q202dD6BPIy3B79UwzfCK3V8icdQ9igfC3GBhkEDcIr/oi8dMi0po=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DxyY+bYQ0Eo648ljGRU7X1Wi24vXYHPFWC0Fu00rbQo=; b=ES2tC4F1gC8XsDglz9XJXvBYQL
 YR2kkblnqw88NlAbWOemud1BYoA3Xt8aClQQNiSw6BZFAAIoAHszdShjSxcBzmW1u3GxS7Z/Iyd6d
 MO22LYpJUrzbXi/GBr2xngYTaUlUYjj80vXBId9b+VcbUwysNITSfESo3wNfyA+Usxto=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRilq-00078z-9R for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 26 May 2026 03:48:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 36CBF43615;
 Tue, 26 May 2026 03:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B481F000E9;
 Tue, 26 May 2026 03:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779767268;
 bh=DxyY+bYQ0Eo648ljGRU7X1Wi24vXYHPFWC0Fu00rbQo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=nmtVWfiMTmNf6D+IX+7K3ePXqNYLegK8TT6JQ1uNfPCg1/lZNl1hdy2I9ZyVlBdqc
 XUGbbL3VR3ElWJPiiOgM97mnVnP0BqU2QD0SV2hFa2Eib8ci6/5rLW9rls6OtN4nk3
 uIGXqzOAXE8tKcd13d5ANdSxe7aDhjCbF1akk4opPo99gdBrvU8MtwuU7j2b1g+TXX
 fqYRTf5visUjVSFpVAG9EwuqGwtJkX1CPP6lnk6zNbZpnGVVigaaOGODi3dYe5/kPY
 t5yaYxKVlUmVmfPF7Mr+6NnK8zrgsv5stXOUaO6dCmRV40JC5G6bXFk3A4WQ5NnPEz
 s9pYjIfB/RoEQ==
Date: Tue, 26 May 2026 03:47:46 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <ahUX4tBeLykdQNxY@google.com>
References: <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com> <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
 <ahUF7HqSKFJ422bU@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahUF7HqSKFJ422bU@casper.infradead.org>
X-Headers-End: 1wRilq-00078z-9R
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
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, Akilesh Kailash <akailash@google.com>,
 Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/26, Matthew Wilcox wrote:
> On Tue, May 26, 2026 at 01:21:33AM +0000, Jaegeuk Kim wrote:
> > On 05/24, Christoph Hellwig wrote:
> > > On Fri, May 22, 2026 at 02:04:59PM +0000, Jaegeuk Kim wrote:
> > > > This was a quick buddyinfo right after booting the device.
> > > > 
> > > > Before:
> > > > Node 0, zone   Normal  22684  42284  28704  16901   9515   4566   1854    673    181     36    758
> > > > 
> > > > After disabling EROFS large folio:
> > > > Node 0, zone   Normal   8486   4732   2175   1161    697    272     82     19      3      1    856
> > > 
> > > And what are you trying to say us with that?
> > 
> > This means, high-order pages were used up by EROFS which sets large folio by
> > default. So, I wanted to say the concern was based on actual data which was what
> > Mattew asked.
> 
> This isn't that though.  What you actually need is to show that high order
> allocations are _failing_.  The MM is far more complicated than you seem
> to understand.  There isn't a fixed number of large folios available;
> when we try to allocate memory, we do reclaim.  And if there's large
> folios on the LRU list, you'll get them.
> 
> If what you want is large folios readily available, then what you want
> is large folios used _everywhere_ because then they're easy to get!
> If there's small folios in use, you need to reclaim a lot of memory in
> order to reassemble large folios (it's the birthday paradox, similar to
> the hash collision problem).

Thanks for the feedback. Actually, I tried to do compact_memory before doing
read() for AI loading, but I got complaints where it took hundreds milliseconds
to run that compact_memory. Is there a good way to secure high-order pages before
that read()? It was quite hard to project when it will happen.

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
