Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B81C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 29 Mar 2022 14:24:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nZCdP-0000GR-Rt; Tue, 29 Mar 2022 14:23:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nZCdO-0000GI-No
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 Mar 2022 14:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8sGeDNoAHWMVOA3g0lekC9j2ViOnGlimpg5R9tKcrVE=; b=JbBarSPNnMpRaXTK5MKjuX0h+W
 uLUMlzaS7YsZ1fqgTT5Nv4CQNbA9jZaPJTTZTbr2aVlc69XzjkBYQJ5/oo4ymasbHnCzYGMs0+Xa4
 3gMryXPNKvmmXNBjeY3KzPwgYF9RV1pRRhH1Z+isY4r2u9DGvqLuVPcLOLLm61wiHD3I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8sGeDNoAHWMVOA3g0lekC9j2ViOnGlimpg5R9tKcrVE=; b=b5sqe8k7m+IhpoGrf+8hPxIPdQ
 CHJhIFigr40S5zMO5CCuIX7CTNiZs6s/vKsLeFcKOPsGpsmNfvvzlfdNnfsCFGvyYf2rUuD8xxIMW
 x144G+WaxS/wBFZQrv5UPwCjkemfPNMrJef2I5cs1weHttYgWYyhNqMqQm3XMirlVgFM=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nZClG-0003Vc-0D
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 29 Mar 2022 14:23:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B5EF1B8181C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 29 Mar 2022 14:23:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D380C340ED;
 Tue, 29 Mar 2022 14:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648563817;
 bh=sRzUpzrKTVT4tz5RtCx6TS2/CwuHsCPOf9pnrP091pA=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=azcFwgoJgYfcB6jgfZ6tfxNO+NzwVTMh2y2es/YfKA6u6n9KDtvcmLYM/3Pj+U8gc
 ybDnLTG9qf1xm8kTsodLjCNRFHy/di039JzeI5eA8wzQmPmbelqglDUl4GPWbxj4l4
 S6eN8IHNnYB+SPR4qSbO54HeHJAeKENIaz5RJtBQoYG4r6uLyL5o5BXytXQBWjNCUK
 A3DyOU1bHmcE7S0yxJFwcR/ZX9gus1XVsVf54A10Tjxod5zkstRfBIEPKaHARlqKUQ
 oirwaCWsFZ8VzSAlnN+BTpa7vEtbi8P1DKcxEb1Jp6jzZaOj+hohTs+wOlpAScOtd5
 WJ8fGzAEWwAnA==
Message-ID: <101f4cb6-37bf-0ac3-3838-7aab7e648352@kernel.org>
Date: Tue, 29 Mar 2022 22:23:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220321223315.3228326-1-jaegeuk@kernel.org>
 <YjkUvRKhyX8AUoTm@google.com> <YkJ5anzBIyQkiHfU@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YkJ5anzBIyQkiHfU@google.com>
X-Headers-End: 1nZClG-0003Vc-0D
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: introduce data read/write showing
 path info
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/3/29 11:13, Jaegeuk Kim wrote:
> This was used in Android for a long time. Let's upstream it.

Could you please explain more about its usage?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

The code part looks clean.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
