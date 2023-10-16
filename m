Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AA9CDB465
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Oct 2023 07:53:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qsIQI-0006s6-Dx;
	Mon, 16 Oct 2023 07:53:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qsIQH-0006rx-18
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Oct 2023 07:53:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2/vjH21/r7uvliRd5RyKgAnRoxFg5klSgetEckcs4GI=; b=OvL89Ws2Uoh6J3IWVXayWpCt5j
 qyqqMux4jyw4rqF/MAYP6NNttf62xMWRHYAS2hP6N+kCzkH5efnLIIrsZzG2wA/5N0vVpGyqOg+cg
 9hiYn81nIivR39ThuaVWqSln38h+zMqf0pnoklyr/LlEds55yZLVTrLFTeRZxMTJBok8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2/vjH21/r7uvliRd5RyKgAnRoxFg5klSgetEckcs4GI=; b=PlaT+c6aYxh5+2c1psCAkeB6mV
 BcJnkNYg9GdR/H0H3nQT0FHmVYqr5WmO4Ao55iFPaZIhzmBNP8EPKNfx3AMMJvXI2915NmIRkr63Q
 9L8xpmXspz8r0o5h6szrrF9yMGZgOsqERnblNsW/3ucJgfL+OM6eFjO7D7A00hb963Jg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qsIQE-00023h-Lz for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Oct 2023 07:53:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 93D41B80C80;
 Mon, 16 Oct 2023 07:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20845C433C8;
 Mon, 16 Oct 2023 07:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697442828;
 bh=KF7D0pIBDOxA7uck8YbnsFpvaMwPZcCiwhgXetehI8s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cW7oJxlw7jT0mjJ9A5c3LvEm5pJWddC0dtA6gD6wvMcf950TMmh2x0IqpVn5thbhh
 4ndvEmunybX+P9s6AbKWHkxvtvHWQy6RwUGJjl0zRYcUGJznbnGHXK/RuUy0yQ2BsG
 hAuMn4RAWCaLp/NQPjuicSZlUTP+QSvQko16GoLDLQF1HR8Bxje9hgnKerAUBU7Bd0
 x6NicFwJn9BLBJfofkqhNqOIRwdmwmOSz3p7nJL6VAlTfi7t17FvESqR4UfBBdjCVU
 eKZJCyCewWfxBIWjprt56hjKhTL9rLjOeK6sNFxNSAZYblI5NUH/q0olehi5uvdDUk
 x9x+1HUEA5TcQ==
Message-ID: <34cdc4d2-166d-b41d-bc20-55fc749f9ea4@kernel.org>
Date: Mon, 16 Oct 2023 15:53:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20231010193628.2629168-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231010193628.2629168-1-daeho43@gmail.com>
X-Headers-End: 1qsIQE-00023h-Lz
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up zones when not successfully
 unmounted
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

On 2023/10/11 3:36, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We can't trust write pointers when the previous mount was not
> successfully unmounted.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
