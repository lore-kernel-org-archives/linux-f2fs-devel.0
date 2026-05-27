Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0161FCD5BD0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2026 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q4zE+zBDkVeSdWcXgFJkmecA8kObIPUnI1Dq4Sm3i9M=; b=ByMcss1/mAGZvQyoeYA/NVhmJQ
	EvvaUnfoT1Cpvdb/M/Xmci+fc/5yqTu0UWnSwq8y8a+MzO9HN7bEFwlrC4WAonRAdVaGLbDSyPr7q
	PEJMz4S6g/PYavcsNPzi8EWtHJQi1v1aTx2vhJOW1gqmV3QIZRm1DZEdJQuvO5A4fMpc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSGLw-0002vQ-Iq;
	Wed, 27 May 2026 15:39:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wSGLs-0002uz-Kd
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:39:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8tkayxaFR4WgUW5KlUVQBv4QvmTLYma6soAnDSL6BSE=; b=fDbfYdv2OsyQ9r8xC/MLc1GS5I
 gb2zAy7+NpAGx/yTYlsVikQDSEhqFDlEwfqni7X+dyc07zaaem/iossqlsIdbLB+v/By/xQugm0UH
 bo1nqkcsQXJb9qMlYrDWdPTEw7fBiaIlsj6vx9yXEkjxrWIMgkAJO7fkeYCgj0EzAo9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8tkayxaFR4WgUW5KlUVQBv4QvmTLYma6soAnDSL6BSE=; b=BkcKO3U5M+zbMG7nc7obDzsbCK
 BICyEQfMLhqha760zKzXfmnAo2OXKsAB2gfI9NEnyecG2fdbfPdjDCFsuKwuT0Q0N0RswgE/s+c0F
 19ekFKN0k5saJil2NtRqfVF3ih1GKmbl0EFzpEwj4c9VMApltVISGA5g013YdFF9Du7I=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSGLr-00088F-GC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 27 May 2026 15:39:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9DD2C43D3E;
 Wed, 27 May 2026 15:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F2C1F000E9;
 Wed, 27 May 2026 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779896353;
 bh=8tkayxaFR4WgUW5KlUVQBv4QvmTLYma6soAnDSL6BSE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=E2y8R2Hxn+xhvIjIcnHlTfkDkts7bsT+888M6AM9G1ambnFnv5F78FJW9QyRGRGyP
 +aRJbaNxmsBPyVau+poW6nye8T7/U+loHiVz5VLG0NH4eQqPZIVTpQ6MnJ1nmjSCWj
 REKXR2KOVHvb+ByZMnVAoWwowF6BgkNVf1mi6MbU6kSzNmdLk/YmtmMC3CRSUdEHBa
 nHMONcPUwmFcN6IGk5LJmqKzzuAntrUhs2W2KFTt4tyMGx1pcLaoVfm8bCs67yMBHr
 vilgqZaylNQsNnN73f7k0Z9EdAh0x0eeghvPX2zls+ciDqu/sdJd1KO1MDHLsw/DV4
 ugSTcps09ILXQ==
Date: Wed, 27 May 2026 15:39:11 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <ahcQHziLARSzFtar@google.com>
References: <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <ahYWKH9-ybDlZuJd@google.com>
 <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
 <ahZaScMpx19ZLQi4@google.com>
 <ahZlbQPzTUecMKGU@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ahZlbQPzTUecMKGU@casper.infradead.org>
X-Headers-End: 1wSGLr-00088F-GC
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

On 05/27, Matthew Wilcox wrote:
> On Wed, May 27, 2026 at 02:43:21AM +0000, Jaegeuk Kim wrote:
> > Thanks for the context. To clarify a piece I missed earlier: the model pages
> > are also utilized for inference. Our data shows that larger chunks yield
> > higher inference speeds. Consequently, I required high-order pages to optimize
> > both read throughput and inference latency. I will halt my current efforts
> > and wait for alternative suggestions.
> 
> I think your efforts would be best directed towards general support for
> large folios in f2fs.  There's still 40+ places in f2fs that use a
> struct page, and converting them all to folios would be a great help.

Ok, I'll dive into it in priority, but it'll take some time since I think we'd
better to refactor some major data structures.

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
