Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63685C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 May 2023 03:03:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1emE-0007bU-9J;
	Wed, 24 May 2023 03:03:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q1emA-0007bF-Bk
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 May 2023 03:03:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mS15ZehUD0m42pFagSyjq4PsNkjax4ivX37sMYYX1es=; b=A7WeBHt0yxb4CgdfvpEI4LUJrT
 DHkgO2do7qMBPCkJFNuuUZ0TaX50bftA2ZvkK3tzjdoku2ciwumuBNp4OyNlMe6xozpj1WNoAPaEh
 1YQsjNl1tN5GSks8TppOqI0SBoFLSpxQD4OLtQwsRuQY9YBKy5lPEGKk18Qflq1qLreY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mS15ZehUD0m42pFagSyjq4PsNkjax4ivX37sMYYX1es=; b=EvqmXchUaIhYjc7hWmL6bptM1k
 4THWxYjiW2In8Mjm26sugUdjZQ8VsgMFRO9OuRBEToj3BnQviO+fa88hLZL82UWkC4ggrV7FD646r
 NSJIWVH+JPKZb3nUGW4ckgdtKaer1Lt4t6gcQu49avWRzV5EXzRiIo3EnMMLC6Wc4wXQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1em9-0011Tb-06 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 24 May 2023 03:02:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 994CD6337A;
 Wed, 24 May 2023 03:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46607C433D2;
 Wed, 24 May 2023 03:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684897371;
 bh=hN9iRZGBHN64DuU9x5rv9NlcI86IMG6HgtLo01i6cWU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hVC3a6rqTSxrE9dPOYAzhDzymw3H8CEiOndLRM87pTwgFuhGqgV7ABotkp/Ei1HIg
 HguBh7ylFw295q6Qa/HaV65isNrfAIO16905XXDVUv9cwF/7xLvgmtPgk3SP7ghPDM
 u0by92rmKeVSfnRQpFugdi5RBCCtAoqH4EumxKm+mTNy49ll1RFaLp88UCuoQIk06j
 7NlnZsLUGlK2IQDaqcnjf0KRPBv4z2h2MnsPC40cf8C166BcZ7NL6oBXd2ebvEn81P
 gJWGiv+lOrTaMNdQS1mdFGg91qRrU9jDrR3W5N92/86ZVyd4HOq/j+MUdB3ybKbLy6
 eM2U4G3qTadJA==
Message-ID: <4cbd654a-cbed-2acc-8fe5-898e534eb6fe@kernel.org>
Date: Wed, 24 May 2023 11:02:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: zangyangyang1 <zangyangyang1@xiaomi.com>
References: <d4a7bc42-6b58-27e3-e9d8-950f698bc43f@kernel.org>
 <20230523122720.1628122-1-zangyangyang1@xiaomi.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230523122720.1628122-1-zangyangyang1@xiaomi.com>
X-Headers-End: 1q1em9-0011Tb-06
Subject: Re: [f2fs-dev] [PATCH v2] f2fs_io: Fix integer multiplication
 overflow error in fiemap
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/23 20:27, zangyangyang1 wrote:
> When using fiemap to obtain the block address of files
> larger than 2GB ((2147483647+1) bytes), an integer
> multiplication overflow error will occur.
> This issue is caused by the following code:
>      start = atoi(argv[1]) * F2FS_BLKSIZE;
>      length = atoi(argv[2]) * F2FS_BLKSIZE;
> 
> Signed-off-by: zangyangyang1 <zangyangyang1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
