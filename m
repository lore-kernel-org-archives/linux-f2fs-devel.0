Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E5D6DDF9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Nov 2024 06:52:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tCvce-0006jc-5j;
	Mon, 18 Nov 2024 06:52:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tCvcd-0006jW-0K
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Nov 2024 06:52:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0SDb6J4xsIyqTy//zP4ThpwdRnVMHFdigXfX1c7OwnM=; b=HLjq3KmeDb0BjpyriZZMzO1A3r
 lTdjJRPHFHklDvmdH2nGYSndDnT0vtuOb0cVoPgn0976+ZzyU7QZYQuOcjdI5t+SphVj8O8RFZrQp
 YdVcRSm8/6TKzXpkvqjiQ+8XdWVttrp+KSg94B95la+vIFs1wYiF0LaLdRTzlG6DQMD8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0SDb6J4xsIyqTy//zP4ThpwdRnVMHFdigXfX1c7OwnM=; b=LMC3vsYx4RDbTHPrfX/G4LnBvS
 U4RuPv8Q94TDEsHaVH74o0K8Hx6kKgU/ZzUVSA14VAKAputV6PLb07HlRyP7MVNsgUs1hZTTEjHSH
 uP7MqvwE6AhpvLwfHTLDMGCHz4jplNfi5znN2+7RLUQpO/SqSiZdw8fmTsMGB/6m0FgM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tCvcc-0005t8-Dq for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Nov 2024 06:52:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 037635C4B48;
 Mon, 18 Nov 2024 06:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C59C4CECF;
 Mon, 18 Nov 2024 06:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1731912744;
 bh=b0TRyEAlrSD429EVw9p268WP5nJU++Nk4CwNQ0Bf8hg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=t/ObsHcoSp4uIyE2yM2dconLAljqCB9Xy2KqhQO+TCF4q+2gRG3/XPew9wdLBkmoJ
 KL+vQKeggZYJkI7uleMxSwhICSHJQAISD/VuErRUWchQxLcPRjQzqHPZ4z9TlH/0WL
 T4UeauEeb3R6jhz3WhiyxYGbpI5z67A4bdXB00q3cSGr1ZQObKsSpwOrQLNbpiq1/X
 4wJm40JORcrzXzkAHSwGxKGcZH7MFdYE9ZDnlKOp80fJtgsPIptkMkR12/tivYbfjp
 vRxnibFVtec0HoFzCeF6ihW0lzvmtYdMV0hLYGRPSwJP6M3PQ+p0ybAYTMzXZnsA2m
 oX8tzeXLvG8BQ==
Message-ID: <3760a0ac-1dc3-4069-8fe7-a6e4a9222683@kernel.org>
Date: Mon, 18 Nov 2024 14:52:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20241111085058.4136077-1-shengyong@oppo.com>
 <20241111085058.4136077-2-shengyong@oppo.com>
Content-Language: en-US
In-Reply-To: <20241111085058.4136077-2-shengyong@oppo.com>
X-Headers-End: 1tCvcc-0005t8-Dq
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: clear SBI_POR_DOING before initing
 inmem curseg
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/11/11 16:50, Sheng Yong wrote:
> SBI_POR_DOING can be cleared after recovery is completed, so that
> changes made before recovery can be persistent, and subsequent
> errors can be recorded into cp/sb.
> 
> Signed-off-by: Song Feng <songfeng@oppo.com>
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
