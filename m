Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0094C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kQdU6rlgRZl131huqMOX+3q4TkcczqI6ej2Cc++0w+Q=; b=lZizjm7upWgiGXbFxGLvnUIRL8
	t0Ym0S7wFP3n8JmTMRe86g2oL7FXlVCWATBhGBwP7zLV9HmBBcwlgdW2HtUVrOvUwrAkkMjIFQ+IK
	iTNTgSVGe0NfuPHVzRk5e82vQ/gLfF1EwD1iEv4tJ6MiYVhpaM226RcAzhBSGqaLf2L4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wxCXS-0005nC-Tq;
	Thu, 20 Aug 2026 23:51:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wxCX7-0005Ly-9c
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 23:50:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QRZ+PTDJY57nN80ihzFkuyF+etn9biA6akSbuthcJ34=; b=PMoKWDGsUsE22YVKYZgjNdApMC
 vro7GJbnDcE1SThUshcfjJHWeXoVciwX8OsbXjYA/u+RNN/hKlTVw3VYQGepVG1LjrnVmEnjJs58Y
 Vnqmolj5x1DP4Ge+eYmW4NXqcwAXscPQu+ZQMXkWHtLt+XY4oO4HVCvPIKkHTnkAxTvc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QRZ+PTDJY57nN80ihzFkuyF+etn9biA6akSbuthcJ34=; b=Th/t4pqTl5obO6LPOIM6VPFzLJ
 XoQU1WaTOn6b+BrgbGFcttePI9nHLhA3CROgtYTOjLHtYRR1nCcBTqwIM5FK9KMr4U58riiP5t5dD
 qT0IGk4Fyc81GpZv47/RjxGMdIYb3Ws3oHLm1eSc/4M+0CIEjU5E+Bhqks/dIddMzDJg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxCX4-0005ls-8L for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 23:50:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 924B560A58;
 Thu, 20 Aug 2026 23:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFB41F000E9;
 Thu, 20 Aug 2026 23:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787269844;
 bh=QRZ+PTDJY57nN80ihzFkuyF+etn9biA6akSbuthcJ34=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bR55DVViWaTUbBrmSFAtG2etlVFOfgO8u1XLbP0C14GkcBeUv3NmvO28pXXullVwO
 OH08nh+WEdjfa3/BcjIFwckU4tfyQDZdFJ0rI612dADw5vjA5RZ4Z9P/QxYq3qNR1Q
 6NfHF1goFnzZbnX80/PAVfyL8OP289wJP9g16567UiUMp1BwuLOOtnoQSQiGQueBAL
 eR1lvdA+TQLx+dFZsP3ZbPFOWe5HR47ASDyxR/i9PqxQulapkl/Se9sfqzYgovfEV+
 xWMylRecxmh69TclPBCAVkJVsKfpcaD2fT7veLaNY3IV+EsS0LkBizc9d2LTddIsaU
 fiV6IVLbEfPhw==
Message-ID: <b12d9999-44b8-4b82-8d6d-72ddcb398cff@kernel.org>
Date: Fri, 21 Aug 2026 07:50:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260819180635.1165300-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260819180635.1165300-1-daeho43@gmail.com>
X-Headers-End: 1wxCX4-0005ls-8L
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to migrate all curseg types during
 free_segment_range
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
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/20/26 02:06, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In free_segment_range(), the curseg evacuation loop only iterates up to
> NR_CURSEG_PERSIST_TYPE (0..5), missing non-persistent in-memory curseg
> types such as CURSEG_COLD_DATA_PINNED and CURSEG_ALL_DATA_ATGC.
> 
> Even though these in-memory curseg types are not saved in the on-disk
> checkpoint header, they still occupy active physical segments at runtime.
> If an active in-memory curseg happens to be allocated within the segment
> range being truncated during filesystem shrink, failing to evacuate it
> will cause subsequent writes to the curseg attempting out-of-bounds I/O
> on the truncated storage range.
> 
> Fix this by expanding the curseg evacuation loop upper bound to
> NR_CURSEG_TYPE to ensure all active curseg types are safely migrated
> out of the target range.
> 
> Fixes: d0b9e42ab615 ("f2fs: introduce inmem curseg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
