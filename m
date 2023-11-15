Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F63DC07548
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Nov 2023 07:11:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r3A3A-0004TQ-HJ;
	Wed, 15 Nov 2023 07:10:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1r3A39-0004TK-KB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Nov 2023 07:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mv1YDXYKdMQKh4hwj/lqDhq0ErSSmdhnDrDK7Xk6iQc=; b=HdUD89WMa9qORM6FKTuFG/KR3w
 BpMiCCQeSJFW9OiPhIhbiekxs7nb3jqcy8I0XQ8X4AvZkDlBZa792FLJ/jNFjAXrr7leS8uyVA7j9
 jGNlc2Sl3eR4RNHSO5G760+W4+RfcaqvGzRxXa0WMia+rXc3O6ARVU08JgV5pDUFgtOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mv1YDXYKdMQKh4hwj/lqDhq0ErSSmdhnDrDK7Xk6iQc=; b=KeF2DhSNBtR/hqRiz22+xxc7vG
 k+U8SzS71Qi06j5RB/luWPeVJ1uJPqtPuIxRYWybdtp7lIW7D9tlhF6TyGbf+yqdVwQMKSbjHjJPY
 d4x5eKxACyAcp8l7DWVeH+xW+1+xewB+913ecP43N+0k0wMrBrsQtVPdlhtZc8edafa4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r3A37-0001Gl-U6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Nov 2023 07:10:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id CAE87B818AD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Nov 2023 07:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44198C433C8;
 Wed, 15 Nov 2023 07:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700032249;
 bh=TMjsKA19pdESkB8wNvbgHH7uT5VESKKfmvxevnjfKTI=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=iimzLD7qaMsEZ7cCzRjAo2wc1mKKOw0QkKO9it+iWAFZ94uayL8vXJwxrWbL+mYzy
 qkagnb/yG0ySR36ItIsnhzrkpqhP7PIOm5HLpCH7nIMK4FbAxJI0PB4WutUXCuUCYO
 gmr6UC5kY3sh/8OYak85/78O0dCUEr4Ihtr5D+kfaC9GBW0ulW4w5N1k/3u9B8zdve
 nE/bwiFmp4m9sFpePRYPQ9s7lDZxin+SRVTxUulNleAyA26FM0opW8dLs2wrwGmH00
 U+XfXLQbQ7f9z0Kzupj0zBTldZKiZD7cdVX8fS+0ky5o86r9awZlsoCGUXKH6nweO5
 yOi2q/TMYsjNg==
Message-ID: <15ad0fa5-9841-bd43-5123-f2ccf5ed3199@kernel.org>
Date: Wed, 15 Nov 2023 15:10:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20231016215849.639313-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231016215849.639313-1-jaegeuk@kernel.org>
X-Headers-End: 1r3A37-0001Gl-U6
Subject: Re: [f2fs-dev] [PATCH 1/2] Revert "f2fs-tools: do not support
 user-space cache"
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

On 2023/10/17 5:58, Jaegeuk Kim wrote:
> This reverts commit 2835107ae3908576b41ff5f6a4e63ba7ec9a6246.
> 
> There's a report that the impact was true.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Sorry for delay reply, feel free to add:

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
