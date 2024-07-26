Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4665BC3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jul 2024 01:11:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sX9UJ-0003Hv-UK;
	Fri, 26 Jul 2024 01:11:15 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sX9UJ-0003Hp-0v
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 01:11:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xmg9B3awheV8ElXkP+/dcnIaLTIslkuGph0V5BWfMbw=; b=FwPEc2Aeeh8tKMyKMBb8jUmTPD
 yBrQ9FDaf9TXtC2MCqLnQ2EKQndZ0ST1hzQduDHY7gBSVx70/Rv6egJ+ZqYn8+9DXVHr1n1wq5J+/
 vt0bi3ZncY73Nta46HmbdzFWC7/8OTy9VZLYBOj53a5avgsUMzbYk1/tPjoys97K0xHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xmg9B3awheV8ElXkP+/dcnIaLTIslkuGph0V5BWfMbw=; b=my9jn8VlTyQgDpq0Acq8IrcMNd
 XHB90P6laAayCEa/cGvGbkblQSKE7j81oeAAziY21isEev8wLFNVIGwl8nki1MXR3ELyyocfzGF4h
 2kxBPPJ6n9uXZnWTWHjY33Q2FPPfmRRvd4+ll4F5mse4JTu3Hwr5hiExzF/WDM7H37QU=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sX9UI-0002nj-9R for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 01:11:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 89EEECE0F09;
 Fri, 26 Jul 2024 01:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E174CC116B1;
 Fri, 26 Jul 2024 01:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721956266;
 bh=0YEUx0XVEcu3Z1jQs87oEtfx6K+3z4v/fIjim/OxEgY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ugFN7ATXJNgH+a89zqsrrvIYpX4MuHUJswZks9jjfdnP1FGAK1c9GntilU3ZkM6dK
 NvBAvI7rvS778AdUOtrThCQ6Vcx7Ebx3MO7mlc01Ue6cVYOPYJWYO9KuxhqU5PFaHv
 m8QnV6Tkwtu6o0bg7NV1bq+L73BOyfxlCRkrKpALMalqdJ+4GAS6y5GBNq8+oSloKV
 UQoLjRgFefTLm2dv8+3V46h5YJCMk+gKt6Ewpturx8h48OZIVNq+Z2R23M558cbxtf
 CoMFJ5hw9DCIMfZNXwBt6NuoHKFa+S4kGishPmtqcuEwOn/wITz2aLdiNk9HOWFoU2
 oZ2IhZT7WRbWQ==
Message-ID: <d3d7448a-e542-4e50-ab41-bcca03db661f@kernel.org>
Date: Fri, 26 Jul 2024 09:11:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julian Sun <sunjunchao2870@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240722023913.54788-1-sunjunchao2870@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240722023913.54788-1-sunjunchao2870@gmail.com>
X-Headers-End: 1sX9UI-0002nj-9R
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix macro definition
 on_f2fs_build_free_nids
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
Cc: jaegeuk@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/22 10:39, Julian Sun wrote:
> The macro on_f2fs_build_free_nids accepts a parameter nmi,
> but it was not used, rather the variable nm_i was directly used,
> which may be a local variable inside a function that calls the macros.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
