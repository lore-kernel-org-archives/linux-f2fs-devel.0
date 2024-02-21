Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC47C48BC3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Feb 2024 01:24:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcbLA-0002EG-6q;
	Wed, 21 Feb 2024 01:24:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rcbL9-0002E4-9i
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 01:24:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0th/rqmNy3zwZX6rNkG1W7Jx8BhSBaCAO8T57mIRpv8=; b=Cu8O5TbujefVwLJO/vyg4C7oH4
 0gse999FKqpA9HUARDgxTDVJqrQHaIGbuS7FnXkk0/TfjIABnrFtv5YYNk2Xf6TEW8/70oER3BhPZ
 q8FINh98VueXli88mVH13B+jq1xy+TdJ80rHcUBAx4y2QACrak4xHhZ9ND3xAPj/AUIQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0th/rqmNy3zwZX6rNkG1W7Jx8BhSBaCAO8T57mIRpv8=; b=f5EEP0Avxb/+asFOI0+w9jmxzT
 z6suK5yfQ1Q429viVAKpTgxofD5wDTxsW/lR5ADCOgaNQlDqPrEZwWETW1Ds6S+T+rfU0VgpfvE0L
 JFTVD1EonjXO3M/p5dUY8/klAW2Ygl0w3iSCRaikEggXA+gzw98fMgy0Lx+JRCm9tJ6c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcbL7-0005Ho-Rb for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Feb 2024 01:24:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C2D916137C;
 Wed, 21 Feb 2024 01:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7828C43390;
 Wed, 21 Feb 2024 01:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708478632;
 bh=m7mHMK3piXa/8B+ESZbEDwKnCqiFvJqYaeSKgu+ZxDQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=a78KAm4nlMBk6av10RWJsxyELbb5jM1gx1n6AzbCe1v6GgyAQoAUO9IDEoMmfZYws
 +fbghIfB+dKCaTRbfMMyr8WXY1S2S8jBscU7rq5K8EaWdriF9qr8M7QdAmsoSF24YN
 lbAYKv0b6C2USJPHPXrDJFojOBrPWD2wv1k2LObpmfi3Je/w6wMTb4bY64KwMmtReW
 GWFwTj+Db4TOiV8yhiXXRe6qroVEz1tcTNkwIZ9rerIT3Y/l9/uGLM4MfR6ob/LjqC
 FxtMH6L1sNFN1E43uAT6mWrQ5NMAK3KIloVwFimlukDHEB3z1k6jJqPC6cNqCuYg8Y
 ygYRZrkKnRJ8Q==
Message-ID: <47619647-de5c-450a-9bb5-58f21f3386af@kernel.org>
Date: Wed, 21 Feb 2024 09:23:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1708417168-29109-1-git-send-email-zhiguo.niu@unisoc.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1708417168-29109-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1rcbL7-0005Ho-Rb
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: add a new stop cp reason
 STOP_CP_REASON_NO_SEGMENT
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
Cc: hongyu.jin@unisoc.com, ke.wang@unisoc.com, niuzhiguo84@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/2/20 16:19, Zhiguo Niu wrote:
> Add a new stop cp reason STOP_CP_REASON_NO_SEGMENT for keeping
> consistent with kernel codes.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
