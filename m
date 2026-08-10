Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012B3C5AD4E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xO7lmEQXBdsHvykR5cXWtIFxpblaFTSg7irKTic07tQ=; b=Q4iR65KVIzxR74OuP7UqdEs+GU
	UdkfP4m+8D+o0289FnITv7154e73tsTN8Psbj+3xULw6M679051ooCqQXUwTSZkty8bB3bEkhVCoc
	ueRDyEn1Bnp9enlIxXzGLig/774Hcx18qxCP6isOyM9+O+0pOGHfRJ3/GohF0RoaVI9M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtN03-000602-3R;
	Mon, 10 Aug 2026 10:12:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wtN02-0005zw-LV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 10:12:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KIkTN4JuGGt2D84FopRqoncsNtDcRU7XvHnOV8Ppu3w=; b=MuB8DqgbXpprKCu9qJ2a4zPvbQ
 4l5Kjpur4cHtUD8ge4v+cI9sBtvapnXW0pOAZiKqk/w4TRVfyPPYBfBz73DVK4KQTiQn5bIvme6Rx
 clNeNXvIgnVCsuZdn6AEDAaRGVyrIIimrQEx8uPUXuhVFmVCoPW51yaOKXZaXDoPthXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KIkTN4JuGGt2D84FopRqoncsNtDcRU7XvHnOV8Ppu3w=; b=MFE+OVsePcrC/var1ZO52DkRHs
 FxWmNQLML2kVtl7rsxefzxVWtV7nKiLsjhIJqX1SbjlkV+1OR5oBZtdwG47B3eNLccbEf0MoQ+w02
 Y+eNmi9ftm16nDf1EKJdR8JnK3X/ip+lHB0kEKUlsEJcmzOMNPOjkIxk5HDnCdXnTtNo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtN05-0005bI-Su for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 10:12:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D3D6600B1;
 Mon, 10 Aug 2026 10:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471EC1F000E9;
 Mon, 10 Aug 2026 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786356768;
 bh=KIkTN4JuGGt2D84FopRqoncsNtDcRU7XvHnOV8Ppu3w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=a3ldmIoKJ6aS5oeOn84dX5cdaAdUlxjON2Cz6km02r68v6qDkiC8xv0L0bfso8OUK
 RyL6Ly09Kum8k5G294rHf+YoybJYRqyVkrF7hTg+DIKOEmWrnYOkMEU4GsSvI08DeI
 vKlAxuLHt+1OZ1Dm4X1zSScvaN3vyy/Zo9+M/lShAWEfe4imjyqHLqVsyfRGFRL5sc
 sZQTqxrdUpASVcG9+5fJu1UA8Mly6+XaM3Wq/JCc5RC/DhFJThjEkgmb88zSZsHZa6
 g7c7egKZP582k71IyUvIJN+Zmmx7CJuqrY/wB9hQsQYVysrWY7poiYKBtqZ5AC7owl
 wxwG0zCPtlSeA==
Date: Mon, 10 Aug 2026 12:12:42 +0200
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org
Message-ID: <anmhwrqO45H-oEl4@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-6-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-6-aalbersh@kernel.org>
X-Headers-End: 1wtN05-0005bI-Su
Subject: Re: [f2fs-dev] [PATCH v14 05/21] fsverity: improve flushing
 performance of fsverity_fill_zerohash
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
Cc: djwong@kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-08-03 22:07:55, Andrey Albershteyn wrote:
> The current version calls flush_dcache_folio(), in memcpy_to_folio(), to
> flush whole folio on every digest (which is 128 for 4k) on the HIGHMEM
> systems. Open code folio mapping and flushing to copy all digests at
> once.
> 
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Link: https://lore.kernel.org/linux-fsdevel/20260401222717.GH2466@quark/
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>

I will drop this patch

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
