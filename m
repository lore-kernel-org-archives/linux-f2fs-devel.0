Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D22C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/Fasp7JiXP55vvMfnCdfZJfHtgl1RO9+2JqI2yPvW8=; b=d8paho2DoZobTyhHgoFSPuogvd
	qsbL+4sYECR3bdA+mqFPKlGTzJhWqisfYG1OpBiltRIO1rRYFxhFfa5MEkSvx6Dc9bVWB1XGVn9pO
	VHEkCDMG5kHOaG1DAK9SMm1tI2kB8dGNnR+nHAYcvJlumfb17FEBaclWb99OplpSexX4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzwDx-0002vN-GR;
	Fri, 28 Aug 2026 13:02:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wzwDS-0002qw-5V
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:01:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fL5mMIwmmDluqgLzIsaCvXtwyjBSi3fUOKO2iyL8nZc=; b=E2mhPqi6I+i+moQTuxGjS7HGXP
 IaR23JSYVyZ/VGUp6yRVwYp+WVwPn/r2TGctZV6XaRKcdL6ed4xIpxl3HgGmOKluoy85X7khrUPLp
 YtSfecA5BH0XZQ8RdtsNtbMo4o3HU1i7Zg/NQfrCBMA1auYxycVydOcEbr76MAJIsrUM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fL5mMIwmmDluqgLzIsaCvXtwyjBSi3fUOKO2iyL8nZc=; b=l3JpBJ+oNN/s9v+o4aNX24Q9HN
 FBWlK+CTCXoUo3PXWeJEjWoOK3O5+psR9mq3igiFIdFk+B0lKD74ljOGX5DvP0Yivi+9fIdU/O7P3
 W0ybVJztDQyCRNZn/TsX5+79LBLJNoYOJBdjEFqoswgGcZCclaRPs4ZQ1XcVDKLESb7k=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzwDO-0005fb-Az for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 13:01:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CD5E40A9D;
 Fri, 28 Aug 2026 13:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64541F000E9;
 Fri, 28 Aug 2026 13:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787922098;
 bh=fL5mMIwmmDluqgLzIsaCvXtwyjBSi3fUOKO2iyL8nZc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=XtaRaHP0TJXMJMQj0Er6XCFY1WMB02eV6Dqv7MJ0jw4KqwN+CG3APTRmnBeDfObK4
 67ECsFGebhl0ETTlzAvI4bUJgPgOWuNMwmp7CH51yGpCT799T+UB5kBE39moT0OgQQ
 Xs/vtlAsq1oW6l8D7kBDjcUarOh60OHUvF4w8lZnZSz3Faf0/cg1UsUeyrCkfDym9C
 cncwBPnIIh7ayRUr/pMqHIJFbgHrqquyTDPMkr7xhwxRIWiBrjs+ik+7cO8v1Yj88+
 0uYI76jTXGgcwjc9qRuESwDijF57BKe1wCY5GIZT2sclQpuP3PtT/p2MO7wVg4RJAJ
 uogK+bHGfSSUw==
Message-ID: <d1225b18-7e4f-4214-a618-c359ed5d59ac@kernel.org>
Date: Fri, 28 Aug 2026 21:01:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260824100752.3890850-1-qwjhust@gmail.com>
Content-Language: en-US
In-Reply-To: <20260824100752.3890850-1-qwjhust@gmail.com>
X-Headers-End: 1wzwDO-0005fb-Az
Subject: Re: [f2fs-dev] [PATCH v1 00/12] f2fs: introduce metadata cache
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Wenjie,

Thanks for sharing the info, I guess we can discuss after we upstream
this serial. :)

On 8/24/26 18:07, Wenjie Qi wrote:
> Hi Chao,
> 
> At Xiaomi, we have an out-of-tree F2FS node-cache prototype for mobile
> workloads that retains clean node contents in compressed memory after
> page-cache reclaim.  This is different from this series:
> F2FS_NODE_CACHE is the primary cache and can hold dirty authoritative
> data, while our compressed contents are clean and disposable.
> 
> In our mobile workloads, clean F2FS node pages can represent roughly
> 100 MB of uncompressed working-set memory.  We have observed an LZ4
> payload-to-original ratio of about 0.1 for these pages, excluding
> zsmalloc fragmentation, entry metadata, and workspaces.  Node reads are
> also on latency-sensitive paths, while memory pressure can repeatedly
> reclaim and later reread the same node pages from storage.
> 
> These are observations from our out-of-tree mobile workloads, not
> benchmark results from this series or current upstream Linux.
> 
> If the primary metadata-cache model moves forward, the direction we
> would like to explore is one F2FS_NODE_CACHE slot per NID with mutually
> exclusive clean representations:
> 
>      UNCOMPRESSED_CLEAN <-> COMPRESSED_CLEAN
> 
> Active, dirty, and writeback entries would stay uncompressed, and a
> slot would not retain stable copies in both forms.  Compression would be
> prepared outside the shrinker and direct-reclaim paths.  Shrinker reclaim
> would continue to discard clean entries without compression, allocation,
> or I/O.
> 
> If an optional compressed representation for clean, idle F2FS_NODE_CACHE
> entries fits your intended metadata-cache roadmap, would it make sense to
> discuss the clean-entry state and lifetime contract first, and prototype
> it on top of v2 once the base cache is ready?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
