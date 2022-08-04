Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFA6C19F2A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Aug 2022 13:19:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oJalC-0004TW-4q; Thu, 04 Aug 2022 13:19:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oJalB-0004TL-BH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 13:19:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lBvlSizrp8KIIyGaMdv1Vv63+WF/CiEWY+orbFS4pic=; b=GSDf4kpNVIJrqZ1ajbQXE6lSIH
 7Ur3LoNMgK4uHPnSdvp0F/bL39AsPsILnZEn8b6XHMBSvAlp/ELvHKWKlHMpl3FitREcwhRL+VTl3
 X3ewV1pSUh1Mf7/Hj1yGXydsCpFxDtyZldpLp2BmA2wXSPTdRKlpRPRTPC3gossLG5Nw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lBvlSizrp8KIIyGaMdv1Vv63+WF/CiEWY+orbFS4pic=; b=W9tYYQ0qyv+vFT7LPe2CGmBgfq
 DBzgbyoruAMFYxJ/fNeevaLiKLUNk7WLFHds7JMUNmZAGGdtxb5q5V193uotgoJprsylwb/y/JAQf
 r0+N071MDN9Ct0sbFZB5GSIhGY2Id0k27TzUpCqSodItUSDkqS78qmqkphsNje9VOAEQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oJal9-003DLQ-BH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 13:19:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2AFCB617BF;
 Thu,  4 Aug 2022 13:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678FEC433D7;
 Thu,  4 Aug 2022 13:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659619164;
 bh=M0SSFMxlayeE6mZzPAIICF05y2jkpLApZw26vek9YE4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZMvfGHS22xVkhKiTJb+5h6DTHWe1QefEScOOEvNovwJCmBF1/XIAgD8qg14agOg1E
 hwgak0W2BzFiDo7AHru6LWmsxcVoyjdwFAh7C7hhTBkUZNaZPfNq2YZR2t4wlSUvPT
 g5nJorOtnozHTdU4WumucyudengNnRbVbyrQbF0Xcz3on1ko1e4UgWh6M6WUUg2XSC
 ogD8xbYAgtF5dQ+IbeU1NcTwg51A8n9vWsNZN9jwEVbj2aj8FsqwwLbZQMChQB8QSx
 V8zBgEsd0oWkPY6RLOlrFToaLyMTQxMRQmLHTRLD6jDM0Qr6vXXATscaVUfujsSMHy
 UYf7qK0Kvvdcw==
Message-ID: <0d33f658-a678-530d-0377-1ee6af091309@kernel.org>
Date: Thu, 4 Aug 2022 21:19:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20220802192437.1895492-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220802192437.1895492-1-daeho43@gmail.com>
X-Headers-End: 1oJal9-003DLQ-BH
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: handle decompress only post
 processing in softirq
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/8/3 3:24, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Now decompression is being handled in workqueue and it makes read I/O
> latency non-deterministic, because of the non-deterministic scheduling
> nature of workqueues. So, I made it handled in softirq context only if
> possible, not in low memory devices, since this modification will
> maintain decompresion related memory a little longer.
> ---
> v1: fixed build errors reported by kernel test robot <lkp@intel.com>
> v2: enhanced readability and removed a redundant code
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
