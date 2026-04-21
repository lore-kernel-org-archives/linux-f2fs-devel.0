Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57EFF94CB0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S6QRIr10xTfP0R//hMX2gKEGFaRp6FYBO+Vm3NU/8ps=; b=GaFwxGPUm5W97Cmaf0qiyROMQb
	3xnaPh/v8/K03pnm1DVhXQy5OGj5w8L1Y1l7wuNnPZbLPabAi0yt4tCptfkis4mZBIK9yuNlTt3DY
	I/UKaJKKzj6PuiL57+fH+GCq/2FMXQWxoToeXWdtNPZ8rFgaWCi9Kq485XZYEzeLZ904=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wFIwK-0003Zj-9c;
	Tue, 21 Apr 2026 21:47:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wFIwJ-0003Zd-Dx
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Apr 2026 21:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xsJBd965bmHQNB2U6c2SCaLtYBV8hX4LyuYaBfU5MII=; b=KSeJ97bTUsvGiPfMh84A12pza+
 9J920aKgDOn248JUU/xAPPIkWtznFvbMz5fIaVWCHyLI01tS8vW2rqKOoyf6SSe99uFQiWAA76Ida
 JTFzIMmA2L+MudQpKxnQhlCI7LoMSaeoaxiuvdKpseG+OEsWIpXZ5mVs+Fp3hwCYh0cU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xsJBd965bmHQNB2U6c2SCaLtYBV8hX4LyuYaBfU5MII=; b=Ta3nxb1kfiq09tlBFsS4P6Hr0V
 JS1qmvm8uBF1Q8JIzWjQ4jFcoZUHQZv8Km2mEZlezNQE5B4Q2sy+AatGRPlJk0NpY5G86oG/uzAbP
 RbTKjdUPN0o8Npk3foVdx6UXZ31HihNUH/2yC9W4SXjG6Vy7y0t0IUsPgbxWYzfpLG/Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wFIwG-0005Uz-JW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Apr 2026 21:47:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E66596183B;
 Tue, 21 Apr 2026 21:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC65C2BCB0;
 Tue, 21 Apr 2026 21:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776808038;
 bh=oSPokO+q3plCIej+MKM68XW8qDkR6dMa04YKSO3bIGw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=r2jEQ64GDftqTVQLHKezLKKWKzDIZieUE0l8/KquLk+CrY+mskzigarYZ13lyk+v5
 UY58aEU9eccI98ZWyWEAdL4lLGL46YYwwNXaz+4PDrZy9KYTdwC+3/5H4ZAmbgS4kp
 zrqVFfL+5SMRgZGqDkbiyaItgl7wXZ6jr7Uh7z9Md8odOn8jmTGbPiSIx8nTEWWHe/
 tbHSdk2JSAwS84I1LFn8UHjjQKNzMCDTPh47/K04vYKfFsNbxbtRnyRmXvL3XBexx/
 RB9HdDTafglw9PZ0xJqhD/V9IIq+MsVrgFz2YOlGp7gTsUR8Ajq9KJ8+iYchnjiyf5
 3FirERO2gFrfg==
Date: Tue, 21 Apr 2026 14:47:16 -0700
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260421214716.GD37143@quark>
References: <20260420114714.1621982-1-aalbersh@kernel.org>
 <20260420114714.1621982-5-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260420114714.1621982-5-aalbersh@kernel.org>
X-Headers-End: 1wFIwG-0005Uz-JW
Subject: Re: [f2fs-dev] [PATCH v8 04/22] fsverity: generate and store
 zero-block hash
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
Cc: fsverity@lists.linux.dev, djwong@kernel.org, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Apr 20, 2026 at 01:46:51PM +0200, Andrey Albershteyn wrote:
> +void fsverity_fill_zerohash(struct folio *folio, size_t offset, size_t len,
> +			      struct fsverity_info *vi)
[...]
> +void fsverity_fill_zerohash(struct folio *folio, size_t poff, size_t plen,
> +			      struct fsverity_info *vi);
[...]
> +static inline void fsverity_fill_zerohash(struct folio *folio, size_t poff,
> +		size_t plen, struct fsverity_info *vi)

The parameters should have the same name at each declaration site.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
