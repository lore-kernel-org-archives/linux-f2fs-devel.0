Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64799C25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 May 2024 01:22:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s8rix-00040k-Cs;
	Mon, 20 May 2024 01:21:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s8riw-00040e-8l
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 01:21:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QYyUVDxrkaMGOdRuU1hEZdYTGfQzdZT66Qu5gjn9ubM=; b=UenF62afoY69f2SOU5FAiWxR/p
 3rEVNjFQmogWsNjL+Nhx6gpT6lcJZw8Ebs7/yDJEhB8SfByQZfRPKJE45vYeRRgDBm5N8B49yNLUA
 oiXhLLLjJdvBGz8omTIWfE+d+imRczuEsMGokpAaiZ4Q0XPkgEmt1IAQroBYDwu3nONc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QYyUVDxrkaMGOdRuU1hEZdYTGfQzdZT66Qu5gjn9ubM=; b=HKNM09paJ13jEww26skGbG1Yny
 ttCGHwXhFOGmdZCiGRkjCM0vd9S8+2EIqCYcoqUWjem5Bwb67R/HsdeRIcjG4PEkqZfWsVjNP1h2r
 Mj18Xjeyi8m3md2IDEKObEaX9SRYFbhGZKS5umG/bTqc5B3gHhA5+FJIjCM/Uh9lWRuA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s8riv-0006vv-1d for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 01:21:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 789C9CE0A3C;
 Mon, 20 May 2024 01:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7043CC32781;
 Mon, 20 May 2024 01:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716168108;
 bh=1T2Z5x0zGe9uatHo8ji3TKpgEnpy3/9ThyAAjOQIqRY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=s3EhMF77m4lsm1zrpEnIdk+10Pd2krVjCcRMmwjk6G/sYxM8KYR9J4rsy1UzB1pxL
 EiwkgFMxsBzdX2c0FLKDGT0XyQDe6xxZtGEUZurPo5HPMged1Ka24M+6F/pC9TU2b6
 OzgEwbFbCEHB4Q9ZbM3o/s51iZrpGwFLkLkl+yh+1uGqtR3cTLlXhq419HoTcS9ov9
 V5AGUNzYf9JZUuEvM6EC6Oe52YLuJCE/wd9cjeekeuQXIveHAYPbvmQI2eZFUOVqwO
 9+ahZQ7lroAyVULGoJ11520NfajW7EDGQPNenagClmOanr8ulqfJWLZgsV2EpZjF4X
 aHOjdGhdqQrKQ==
Message-ID: <64a56504-a778-43d3-90a6-82f85be15b28@kernel.org>
Date: Mon, 20 May 2024 09:21:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1s8riv-0006vv-1d
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check return value of
 f2fs_allocate_new_section
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
Cc: Hao_hao.Wang@unisoc.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/5/17 19:26, Zhiguo Niu wrote:
> commit 245930617c9b ("f2fs: fix to handle error paths of {new,change}_curseg()")
> missed this allocated path, fix it.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
