Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F7FC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OfPvGIt8D5DygSr7GBBCO3//iaEH2xQp/T/xNbXmVGY=; b=bwuhoyDWiFbd8cpAL5LhjNYZ0a
	ByiQx4dDdVIXDsmTeYoQKu1k+l5AcYgTIik7hh3NcRvaxZYzFtWkqdliyW9X87kwykal9Jxh3cB3J
	0L/J8SL6U4/hsPy3x12quABQf0Old2AKEt7BHQIn944ZIoDLYgwn2gxv1ie/6VlOqLgM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wiJA8-0007wA-F8;
	Fri, 10 Jul 2026 21:53:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wiJA7-0007w3-Tm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 21:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bacwDZsOZFP+i+Bl8YQK08roVp2/1oQDKcRl9Y/BMBg=; b=T+ERHwp6FG1KPu952EXBVV0XHu
 qdw3eAwObHSyySicOkis98vjCnoz4BZblDuHk+mKyxpXo4eqN+3DRNJ+QyZ+UvUp7mwHf5p1EiGmG
 PCWAwj+Nn7imuEt29Zff+zG+C3rGOIS17flDvublk9SAWZqwI71dFAAbkQmb8Zz84ARs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bacwDZsOZFP+i+Bl8YQK08roVp2/1oQDKcRl9Y/BMBg=; b=HbiqBCFxCwt13Me3g5hsQK6zXO
 GAAwyv/yo1yiOuODQh2xdSZruiOapwZWV+HmsH+0LDqH+FE7xjJQOInmrY6x2kAYKVCiS6bRpK+VT
 bI+gzK41MttCg/BKo1g2Zf0DZEQk3qydPz3WoIQfvZfTW/uxG5ca9E8D04AmIa5oZLK0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wiJA8-0008Pm-7q for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 21:53:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DEFB943CCD;
 Fri, 10 Jul 2026 21:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE381F00ACA;
 Fri, 10 Jul 2026 21:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783720410;
 bh=bacwDZsOZFP+i+Bl8YQK08roVp2/1oQDKcRl9Y/BMBg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Ortp2wtX2bNnnSzSOao5Jx2OTEF/Tk5MQuajBlAyNVNLoJRfnhIv0TUdBRCZmc6gE
 p/RnFzOhdxUubLz1o0YPqF8KL6o0kNnl6SG0X6306GtlCKcQ98dOce8LOBJ2xSzDAC
 vFf3+DbYtoeliLAb3vMsUgVTxvP3ngPahCkKGi8rro3SEhjjFPu19pS9Uw1YWKouCZ
 pkCXlLQQr+LbKlelipVh1MOzN7wOf0lpJ0Fp3Uqmzd0v6BU0cbQ9T3CevbEsn616B3
 zguA0fKb8ZrXrzWNUGQqScryx4RGO7hHhrHIuy5RQV3+RuXP+zhUz/tEJWmUMT1a+2
 L/zf83kawyWzA==
Date: Fri, 10 Jul 2026 17:53:28 -0400
To: Keith Busch <kbusch@meta.com>
Message-ID: <20260710215328.GE1911@quark>
References: <20260710210646.3576365-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710210646.3576365-1-kbusch@meta.com>
X-Headers-End: 1wiJA8-0008Pm-7q
Subject: Re: [f2fs-dev] [PATCHv2 0/5] direct-io file extended attributes
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: axboe@kernel.dk, linux-xfs@vger.kernel.org, brauner@kernel.org,
 aalbersh@kernel.org, cem@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, tytso@mit.edu,
 jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 10, 2026 at 02:06:41PM -0700, Keith Busch via Linux-f2fs-devel wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The attributes reported through statx are incomplete for applications to
> fully know exactly how IO construction is valid or not. The statx call
> can report minimum memory alignment and total granularity, but it
> doesn't show the underlying gap boundary requirements or max segments
> per granule.
> 
> This series adds the minimum to the extended file attributes through
> file_getattr. I hear this is the preferred interface for reporting such
> things over adding more fields to statx. In order to get everything
> under a single syscall, some of the attributes are duplicated from
> statx.

Okay, in v2 we at least now know that the existing statx UAPI was
considered.  Could you give a specific real-world example (with the
actual values of each parameter) where it's not sufficient?  Without
that there isn't really any way to evaluate this proposal.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
