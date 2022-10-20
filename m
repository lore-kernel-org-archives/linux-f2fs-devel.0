Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C33C43219
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Oct 2022 01:19:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1olKDc-0001bp-Td;
	Thu, 20 Oct 2022 01:19:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1olKDb-0001bj-7N
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Oct 2022 01:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vYr2FMXZij9VagGh8wMCYT5znCRCn0ZzU9YrFNSoUU8=; b=nRuXN3DC5yle3iY2ifXhjD3MZq
 vHPAYB5BeNkKdLqa3DujK6QfAUKv3++ztW//htBlaJ+p2dqv8OwFA2ZHNqQ2Gf7hx/jOE7Wesb9rA
 kc+aeOonWap4S7LhVaf8cj9I2iLzsZRkrDN3qTiCFL+z18faT+DZf9jHN+UsCadnoEkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vYr2FMXZij9VagGh8wMCYT5znCRCn0ZzU9YrFNSoUU8=; b=XDfqSdh3EfWxo9VrRTKEEH5DCM
 nS6MxHA/H+34FhyQClWpeVxfvX5OPbJLDuS07tdAroGF1Sr0yB/lRdKqM68lf1qEKrlxh8kA0gUdX
 ydBxVhDSWqv3o9qDmC4JPlFLGmBOYrxabSMump8pNiD0kUoMqUKMj4sLfGxKEDQoZIYc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1olKDa-00AMtx-LQ for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Oct 2022 01:19:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 476DC61962;
 Thu, 20 Oct 2022 01:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DE9C4314B;
 Thu, 20 Oct 2022 01:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666228765;
 bh=C7m/IUz8KNYr2uHcKnT+9drGPURTff7VmWTKPAKBvLw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DXEw57lUOcymEInxZIqsH8AoaDvbklDWzBf34CiEynfXLEi7L2abi6F1v5HsYmu8i
 0mppkqkDbdpW6so4w5yJASfVoNwwn5RsX2GTJGRcLoUoYtblUmiNUNMbpSrOz0ABLX
 zY8B5vxtbkLVI1wWYmTLOnyRg+R6nl5A+Cfw7mFWIX9uEgK+7/P0RUJP9iDGFXkLpT
 UiZs6GEOt8tT2N5/YI1cT+VZb5gzCqGLPyEOtszKfPQQDKlIUha72iC7ZD0SXof3rs
 tTwKZmeOJE6BYpYjp5CrJoqRlxjNzYz0NSlPN/81wYpsCdi6ThZcTmHfYFcj21Gdsx
 atLeEjNaTqupg==
Message-ID: <0f435090-f75c-08c8-a8e5-567be7225974@kernel.org>
Date: Thu, 20 Oct 2022 09:19:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Zhang Qilong <zhangqilong3@huawei.com>, jaegeuk@kernel.org
References: <20221018024532.44184-1-zhangqilong3@huawei.com>
 <20221018024532.44184-2-zhangqilong3@huawei.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221018024532.44184-2-zhangqilong3@huawei.com>
X-Headers-End: 1olKDa-00AMtx-LQ
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix the race condition of resize flag
 between resizefs
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/18 10:45, Zhang Qilong wrote:
> Because the set/clear SBI_IS_RESIZEFS flag not between any locks,
> In the following case:
>    thread1			thread2
>     ->ioctl(resizefs)
>      ->set RESIZEFS flag		 ->ioctl(resizefs)
>      ...                   	  ->set RESIZEFS flag
>      ->clear RESIZEFS flag
>      				  ->resizefs stream
> 				    # No RESIZEFS flag in the stream
> 
> Also before freeze_super, the resizefs not started, we should not set
> the SBI_IS_RESIZEFS flag.
> 
> So move the set/clear SBI_IS_RESIZEFS flag between the cp_mutex and
> gc_lock.
> 
> Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
> Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
