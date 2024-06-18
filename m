Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930CEC2BC81
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jun 2024 03:01:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sJP6I-0002Z9-S5;
	Tue, 18 Jun 2024 03:01:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sJP6H-0002Z3-Hn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 03:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AJcvJ5TgxumjSYkmqlefofov7NktcmwOppc40t+3WZ8=; b=ijwhwT7p6KB+qyWGtshf8ngp3V
 ccJbdYIHJAGyH92iklJXE3/lQWQL18shLnRrW/uRFnxO9vF0Q297C1DvjOe8fBhJdAOXuCyFD0dYZ
 +D3OIg9TwRk//7cdTpDFe/rAZjq+k94YOT63KLQuO1mK7jfIIbA12WFzXwZpOnJ70Ugw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AJcvJ5TgxumjSYkmqlefofov7NktcmwOppc40t+3WZ8=; b=VzpcGkeM4OqdObI17oNjDZqRKV
 vgO0mMbycDnWBiJRIE9EujB2QBW2TkFXXviig8lqfla471ttPJXLaLJER3KFOI9IIEg2RTeVbLhM1
 zJMyoOFhT9Tq3ph5cnA1zsbinLJFgLMK0Fb5363l9HWBdUR75fFAPHKTUBslk/8o+Szo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sJP6H-0002tn-4m for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 03:01:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 04641616BE;
 Tue, 18 Jun 2024 03:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC20C2BD10;
 Tue, 18 Jun 2024 03:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718679685;
 bh=8gCmNU0muMneHYZlDyHKvMMZImJydYf1dNI7zzRo4f0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=V6EUnf8TmRgmgh0lORN1oonlHx+tvSe3/1HKlw39pYfiK7z+4X1afljvLDJwV9qKv
 P+Fuz6tIiI/yZE+Ru3pZmCdSRvkWJP85fbznMLbwSqMD/J7v8uYoIqmhvcgrh83Ki9
 QWVt+A2fIIAHGrYIqTM2bn1RSGvyFC8bWyM+2HY+wxK4WAZAP++rwtCKe3X7L4lAyP
 c3ab8yHXgDE8urGWHiCw+up69S5ODojhVnE5xpch3YJ6wEeYH4mSjguaXzNOax5dIl
 Gi/FnDxfLblS+473MOGZ4lNileSjL/747rTufuL+4dUua9mx5jKBAyJkALECBq/g9O
 9+ked5G52mYRA==
Message-ID: <1f1657f2-aec9-4ee9-9b9b-4bb6cb45d01c@kernel.org>
Date: Tue, 18 Jun 2024 11:01:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daniel Rosenberg <drosen@google.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240618004136.1336922-1-drosen@google.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240618004136.1336922-1-drosen@google.com>
X-Headers-End: 1sJP6H-0002tn-4m
Subject: Re: [f2fs-dev] [PATCH] dump.f2fs: Fix dumping inlined files
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/6/18 8:41, Daniel Rosenberg wrote:
> The code for dumping files was ignoring i_extra_isize, leading to
> invalid data for some inlined files after dumping. This swaps inode
> dumping to use the common inline_data_addr function.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
