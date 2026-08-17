Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B6AC5DF66
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vez+J3rRENBUnX+eW3OEWxbA/zkRbUQUr1Qil00KjNI=; b=KtfyQ7cc8Wt7pDIGArZVuZqvls
	8m0Qa/d8n1D3ThjN8TWHAzCXqqo/QL5+DyX/TVKQdE4q5HP+SlM1s8EwP1F3Kp8Feurb813lexTk7
	FTyIaN/q2KnCoxxX5Z5pvheIru2WoRWNec6yMdTlcPqZV4C4kVfwnelxoCskQmpoZSbg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvzOw-0001d7-HF;
	Mon, 17 Aug 2026 15:37:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wvzOv-0001cv-HK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 15:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SiFMhNBo85XeONQYI7xMysmswB/FDKlJ+i51HWi9xO0=; b=B1ppJc1oOtW2nm98t4Qi810pzQ
 17L/HZNWrftXXqvuszqxWVZT1UzaXCojj4dwO+ywCSZzMMMuIlhYredJ9AeeRyu1vI8AzFX3vke00
 qf4Gne64f0kKGCSI5R8oS+9V8kwbqG+DgKVyTX+Ri9tu27lC0PupCcKelbVPuQ2DjKjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SiFMhNBo85XeONQYI7xMysmswB/FDKlJ+i51HWi9xO0=; b=kFEQokNEU9Z11MzdJIbltLmLZ1
 JANKhb24UENY6fzyaWOnjMYdiNcEhRRRXmebZw+E57TkO2lCr2UUw4ZwYr0YhDDGOpk3DI1lfMB8G
 fj+JdBgNipHadi1+o768nDYfVwW3ZRw256le6XGmDkF11Tu0ar+fcGtYA5wYX2VYxufA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvzOy-0003bn-95 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 15:37:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A86E416D5;
 Mon, 17 Aug 2026 15:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56531F000E9;
 Mon, 17 Aug 2026 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786981039;
 bh=SiFMhNBo85XeONQYI7xMysmswB/FDKlJ+i51HWi9xO0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YGUAcbzZ5cNJGgU4kbM36LvX8HXYWptaedVRNfDWS7UgO1DwWF/UPjl03V1ss/rQj
 hUFeQX8CoOWt3AwUeaPDRSsM0CKLuOXtG5McpewY2MmN/xtH15oo2JytenZjFrUKzB
 ja8fV4RBqzEiERzmEZ3HasocYKuInrX8t346KnDsYft2AmUpzevAFurIxUsthbhjfA
 mq+I+pACO2iP41xjR27lbtgwcgo20gce2YbwGNpYAbc7NIo3YijQPTnWxfnaPc9y4L
 VdJ0DnhYiFn80BuTXB/SLOsb5AoQ1C8us5MgfDk7SSBsMvlo8rqq9zUNhEz5lQoLMC
 QOLHcx0Z5GUPw==
Date: Mon, 17 Aug 2026 17:37:13 +0200
To: Christoph Hellwig <hch@lst.de>
Message-ID: <aoMZaqbKxmp9lhKs@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260814092448.1818082-1-aalbersh@kernel.org>
 <20260817070240.GA17371@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260817070240.GA17371@lst.de>
X-Headers-End: 1wvzOy-0003bn-95
Subject: Re: [f2fs-dev] [PATCH v15 00/25] fs-verity support for XFS with
 post EOF merkle tree
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, djwong@kernel.org,
 Carlos Maiolino <cem@kernel.org>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-08-17 09:02:40, Christoph Hellwig wrote:
> On Fri, Aug 14, 2026 at 11:24:17AM +0200, Andrey Albershteyn wrote:
> > Hi all,
> > 
> > This is next revision of fsverity for XFS.
> > 
> > Range-diff with v14 also below.
> > 
> > Patches without review:
> > [PATCH v15 07/25] block: add task-context bio completion
> > [PATCH v15 08/25] block: don't delay bio task completions
> > [PATCH v15 16/25] xfs: handle fsverity I/O in write/read path
> > [PATCH v15 18/25] xfs: make xfs_free_eofblocks() work with fsverity
> > 
> > The patchset include some patches from lazy-bounce@hch-misc series for
> > BIO completion in task context
> 
> A different version of that landed in the block tree.  

oh didn't know that

> So let's hash
> out how we want to handle this for the 7.4-rc merge window after the
> dust for the current merges settles.

7.3-rc?

> I can have the lazy bounce series
> ready early for the merge window, and should be able to send it out
> once all depdendency trees hit mainline.  Does that sound good?
> Or should we split the minimum requirements into a separate
> branch?

Then the only patches I will need is IOMAP_IOEND_INTEGRITY with the
helper. This is probably a bit too small change for separate series,
but this will also work.
I'm fine with waiting for lazy bounce, as I still will have at least
one more revision.

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
