Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EA7CC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PFvSyz9qa2+NZo+2dOwH8dVwORKXYu6d7IdA/rgD/3g=; b=NC3g8IEaPALpbk/WmXRyGuFbqb
	iU1cXEY6RXer+K8IjVe2hyMNBNn7eMNhLk0JYjeUaL+tNfxxIPRpMyc3+8Dd9+7qpNef6FLBkdpIa
	YtdDiO5bKZup8HO1NX1GahKMckGJqxAQ5RVDrX82mkgQo0fy1XkZt1HwVaa25barrAXc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGsGF-0001WU-36;
	Wed, 14 Oct 2026 06:14:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGsFw-0001WE-5M
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:14:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5aynIBdykWUyiJc5wo5/fTgc0Cz2299hKU/OS3JyPo4=; b=fZjfg6STSF8bdBYBcYgza+xAPX
 Zw1xuPQCATXRLgchfIut6Y0uO3yhP4lI88gGrug7UH23hoJhSG1VqNYH6rQy4SD/gE6xOe33aMpGH
 KYsaiNr9Rw9aCrg55yWwuwbXAOlNzI6aABzjDmgJZ7A1MswTS2W3Jo8Djuh8/KwV8WOs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5aynIBdykWUyiJc5wo5/fTgc0Cz2299hKU/OS3JyPo4=; b=A/UtqntC6kx3NZ1N+Q42OhKRSD
 1y1GHdtCoxhdPSNMgk1CnW525W6+UnZ9oYnHpMa1+4pVZOb4lBlb5AHsY1IUVHiAzel65MmHdrxNU
 x5hfy4HdHTkCk0YZUR2ZisfAqgsslbVAI3giQenz9wRkXGuI3fhnbZvjTY0pmbEXxN5c=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGsFq-0007vG-89 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:14:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D15E60213;
 Wed, 14 Oct 2026 06:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8568D1F000FF;
 Wed, 14 Oct 2026 06:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791958456;
 bh=5aynIBdykWUyiJc5wo5/fTgc0Cz2299hKU/OS3JyPo4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=oLtRGGhUG5Yh9pfLh+xYlDOuF2HGHqmem2ewJTR9Yo2nugNvCPpz5At20WX93MJux
 Z4XA/uJpk40qPtankMdCXYBVEWzG/jZq32GeQtZPAx5suTJAPXJguGgvbpVQ2PPZro
 RAYnVJnt0ffJivnvKndKFM1tB6WMEl92JEKiqoHpFt2QLK7NBv97n1UjdVImBzi/9n
 NCZysmm/nUZ9XPNtqJb5E28tfJu0LBSRHpb94oE3+QpEloIvLNrMQEtkRh89W+RHti
 h6KVbTI8hCcXsRKMXL2tBh5JO4mnOtxr+t/j6KwAOnKnRw6ld29xkwxNH8xYU6xZ3H
 2akFH01tY1RPA==
Message-ID: <9efd2ca3-ae57-428c-97c7-bc2300ba9a42@kernel.org>
Date: Wed, 14 Oct 2026 14:14:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kaixuan Li <kaixuanli0131@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260919130925.1899994-1-kaixuanli0131@gmail.com>
Content-Language: en-US
In-Reply-To: <20260919130925.1899994-1-kaixuanli0131@gmail.com>
X-Headers-End: 1xGsFq-0007vG-89
Subject: Re: [f2fs-dev] [PATCH] f2fs: bound the SIT/NAT bitmaps by the
 checkpoint pack
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/19/26 21:09, Kaixuan Li wrote:
> sit_ver_bitmap_bytesize and nat_ver_bitmap_bytesize are used as memcpy
> lengths into and out of sbi->ckpt, which is sized from cp_payload alone,
> and nothing compares either length against that allocation.
> 
> sanity_check_ckpt() has checked these two fields since c77ec61ca0a4, which
> added them after a crafted image overran build_sit_info(). That check ties
> each length to a segment count; it never compares either against the
> allocation, which is the half this adds.
> 
> Mounting over-reads in build_sit_info() and build_node_manager(), and the
> first checkpoint writes the same lengths back through the same pointers,
> so the over-read's contents reach the on-disk checkpoint. An unmount is
> enough; the filesystem does not have to be used.
> 
> Bound both ends the way __bitmap_ptr() lays them out. The three branches
> differ, so a single sum of the two lengths would still admit a small
> overflow when cp_payload is non-zero.
> 
> Fixes: c77ec61ca0a4 ("f2fs: fix to do sanity check with {sit,nat}_ver_bitmap_bytesize")

It looks the overflow issue exists since the beginning, w/o c77ec61ca0a4,
{sit,nat}_ver_bitmap_bytesize was not checked at all, c77ec61ca0a4 just
added partial check, so how about:

Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
Cc: stable@kernel.org

> Signed-off-by: Kaixuan Li <kaixuanli0131@gmail.com>
Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
