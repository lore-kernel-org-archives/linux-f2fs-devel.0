Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E68C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Nov 2022 21:08:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1otEmH-0007mG-9x;
	Thu, 10 Nov 2022 21:08:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1otEmF-0007m9-K1
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Nov 2022 21:07:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zNkjBNCFOFklmwOTQEpJdaLh+DWsO303/vzaFvfUq/0=; b=kTVDd2//hg+MC4v1qAMc671xYv
 EIKSctxDg3rN/IsuX2P2ZTvSLYmiiUsfCL3Cbuf6DN8n39LuabtIeX2Q0axc8w7FDw9OdVjRVjia3
 nveHGpf4v0d0FaxQc0cbbIK8W+gpM017eoK+R4K8WY0c2EbU1BKN+SQ9uXjkSOxlikHI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zNkjBNCFOFklmwOTQEpJdaLh+DWsO303/vzaFvfUq/0=; b=T4X//MiNfxLPlxjXr5EEOA+f3N
 EpUIS1RmSuzTvnPm3Pqy7eZJvUrzJ7hlouTZmPj2dnFKLKUPLwTkNRyb521sS841C2JszZG+P5m4i
 p7cdVTDZ6xE6tIdq62VwnhEzscqaKSw2taHaFhm+0ZkrwT/6ksBGNxu4eIOQDnjGv6bA=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1otEmD-003WDX-Fx for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Nov 2022 21:07:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 34006B82390;
 Thu, 10 Nov 2022 21:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8C1C433D6;
 Thu, 10 Nov 2022 21:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668114469;
 bh=3N4nFb8IOZ7MdllbuDFTvEp565pQV4206TPWRcmmQuo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KLgFCZbB1FzMOEC99Bhh0vnmm1JLBdghWNY7ikCvZr7YgsiKSoXasFSDbQzFPjn5s
 0rX5UzP8SGyh2J1NHCFgU8QV7aZ2ub00AT3H6EGe88zL7Baeq9dSYlfjpI2We0JR5J
 xIPkxmONFxaTqU1achAe91oAIdlwesxQBXVc8UC+m4DGpgN7KZ69P08vHJrOX8G2H3
 MVE1JXB6884uDPAD/4YvkosB4DF/D75oM84p014yDLpJfriRtQtSIE3fIa3oK0xlWt
 5CCYoI2IWNiinmDItj5ZOaTHUcW6TA31+bZ4Pj5RnlkSI68R63mWVKW47WMpisR/P6
 7hJiTA++ep/aQ==
Date: Thu, 10 Nov 2022 13:07:48 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <Y21oJCFmHjXhncTd@google.com>
References: <Y1wQp4Z9sHEqfWV1@google.com>
 <20221110081948.31673-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221110081948.31673-1-frank.li@vivo.com>
X-Headers-End: 1otEmD-003WDX-Fx
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove gc_urgent_high_remaining node
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/10, Yangtao Li wrote:
> Hi Jaegeuk,
> 
> > Hi,
> 
> > I modified and integrated some patches as below. Could you please take a look?
> 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=d34f1e7212c1965a409d4581a32a92a1c91495fc
> 
> I've looked at the relevant changes on the branch, looks good to me.
> 
> One small question, does the name need to be changed to gc_remaining_count?
> There are already controls based on the number of gcs, maybe we can add a
> gc_remaining_ms later? Control the gc mode based on the expected time. When
> the count is reduced to 0 or the gc ends and the expected value is reached,
> switch back to the normal mode.

Please check the latest patch which replaced it with gc_remaining_trials.

I think the time-based control can be managed by user side instead of kernel.


> 
> Thx,
> Yangtao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
