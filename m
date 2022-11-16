Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FF2C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Nov 2022 01:26:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ov7Cb-0004BR-3n;
	Wed, 16 Nov 2022 01:26:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ov7Ca-0004BJ-64
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Nov 2022 01:26:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=udaWWltwGAbTyprdbSARfU68DmI/7HJrj7ArIlKRgos=; b=iw3s/caQC/rlde3FOkpBiBr66X
 +4XwFp4rxHVkKbPrL28igmKQLLhHUYIGflXPagPfeslIZK2UVG2fMu4ksV4UxJ8RWSD+oytlI8ZjM
 7blXMDQc+LLmtK8W7EKaILbRVZNlLWfgje0X6+fCCSkdXUlJqicIUDgqBvBsogdrTOtU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=udaWWltwGAbTyprdbSARfU68DmI/7HJrj7ArIlKRgos=; b=hfbJoTXayaIvqvnWM6EmMJdCH4
 uhuwcp3jn7CNhL8B9P3u0XTnFPGrVnUgRp1gb8tEyJI5mXSE9yKucCO7fPSXIopOodj75noUylGN7
 pkz5FQ0i58xaK1YFjbYwmjeQwI/YEN0W7ZeA5UPIJClvv1JcLgh8KDmnLUhmSZCC43T4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ov7CW-0004nq-Ps for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Nov 2022 01:26:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 69FD86183D;
 Wed, 16 Nov 2022 01:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B277C433D7;
 Wed, 16 Nov 2022 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668562006;
 bh=8gnSm96akCzktmabmash2hbT3a601dNz5cAtgTHwthU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FuKynyaFpGbbG4DOHpx2l/UyYjujbgBFGIxzOcv5cU6Xp9HEyzPpU+pEGClW1PLBJ
 p5ea9WwOXtEXCUlxtykaPgd966aqFglE0Imu+zi3zfAagU4FQKAketgpB8bNNHMnt4
 GNfJBKQRXESJ8rO8sGmbwW5eQ7qdxpmX1sAhlLXgQNmCCUlsYE82OsmbkfecLfJTzy
 kjitsB5u1+ixzkmhaFodGuqfPJP1aE1PYNCnxxvf55oGahv5hC4Pw2i5pQA4/KUZbM
 HaqGUMpllloz69zSvVHPXsu767Gvw3TC4T9MQp1KiW+61N0BFX1HmeGd/gQZoQNxV3
 3JvJUM80orTxA==
Message-ID: <cec4aa23-37b0-18af-5217-e524ad45bbb4@kernel.org>
Date: Wed, 16 Nov 2022 09:26:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Yuwei Guan <ssawgyw@gmail.com>, jaegeuk@kernel.org
References: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
 <20221115063537.59023-2-Yuwei.Guan@zeekrlife.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221115063537.59023-2-Yuwei.Guan@zeekrlife.com>
X-Headers-End: 1ov7CW-0004nq-Ps
Subject: Re: [f2fs-dev] [PATCH v2 1/3] f2fs: fix to alloc_mode changed after
 remount on a small volume device
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/15 14:35, Yuwei Guan wrote:
> The commit 84b89e5d943d8 ("f2fs: add auto tuning for small devices") add
> tuning for small volume device, now support to tune alloce_mode to 'reuse'
> if it's small size. But the alloc_mode will change to 'default' when do
> remount on this small size dievce. This patch fo fix alloc_mode changed
> when do remount for a small volume device.
> 
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
