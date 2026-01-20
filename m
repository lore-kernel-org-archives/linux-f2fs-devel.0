Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FE4D2ECE9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Jan 2026 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rY80zxyJLFRjeah4QFnb6i65sO5mG2DT6jW3tXF1Q+w=; b=UDJwWx2K5yDIHy2jTSViqEO++D
	VBpQUey+CAvHSdVis8pWRasNbJPwoer/mT9gcYto09gDB2/erk1F3LTq7g3guMM5TOyX3lcn+nOeM
	RqAc+PPPrmzvJZHLSVMdZoyRQjupOwxKwXQrV883sIPBA4t6GpbWwsHQ4Xq8AlB4X2Tg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viApN-0005qd-CR;
	Tue, 20 Jan 2026 12:27:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1viApL-0005qX-JN
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:27:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PHhbzAVKBMeLtHLz0lWPUCKHEYlfPcL0pvx1BT12C/o=; b=ItG801QzlKpEN4tBuVKHy7SGwn
 ZUYuSkqkwnFgUBjZRtIdpIkjJSoetMlTEqmdhpwN14zjYksEVhdc7zd5NBHg58roXK0uRyHaWg7qu
 CihDY1P8UkbJPrGQVCIMZgs4PHnrTfKcVkkYEWWjR7D3rfhXs95rjr3e/2eAXRZdZiI8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PHhbzAVKBMeLtHLz0lWPUCKHEYlfPcL0pvx1BT12C/o=; b=HZA2qHZkc1mBI9H/P12i66nR8x
 NPgzDOv6fNavPj9K+I2hbnlLsHYA+QVxUNW5boe+YYXhxdZTEiSmv/t9c2RAiUL8rCi8vu+Q6K1s2
 wKt/qOtQ24dod2aQgw1CNXEYnN/sfjDSOrEeOk16jnfi6vCnsXeSBMJJjAmvjBarzDWU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1viApK-000251-W0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Jan 2026 12:27:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C7B560008;
 Tue, 20 Jan 2026 12:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1910FC19422;
 Tue, 20 Jan 2026 12:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768912033;
 bh=TkJZ9ZwthxIQPyoUX4BcUkkZ0OTr5mQosblJcnVINJQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=b1SelI4UPMqZvRtvgfw7Aml/0D6roCQWGoZjrXZgjbThQgq2dk7KoYqsL3+wPQ/X5
 Gu8Kh6jVNkvEjZWX7HKL42B1kUch1Fw09rlVNrxz+8+r2s8g6W9njjw0kYQIHfjlRC
 ZZJX63TrwDKcsM39hB/BmWW844R2yqwYi84ZKZ071M1GtRMgvnMyOLwpvzso/3cIiq
 37KgIC/T07lsduzM3S0dOm7rtYh8Jxu/kTEqWX6EHse5Vc1w3NTERxtB24+ZF6tM8A
 KJfPZSMCLZnkTZpnurntPE8PnjQLEV9O42l/rPW55MlA6TbAGgyAAmTuk2cDI3QlM3
 TIUVuFSBd2Wwg==
Message-ID: <329b019e-75ab-4d9b-a315-fa34efc77dea@kernel.org>
Date: Tue, 20 Jan 2026 20:27:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yongpeng Yang <monty_pavel@sina.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260113152138.15979-2-monty_pavel@sina.com>
 <20260113152138.15979-3-monty_pavel@sina.com>
Content-Language: en-US
In-Reply-To: <20260113152138.15979-3-monty_pavel@sina.com>
X-Headers-End: 1viApK-000251-W0
Subject: Re: [f2fs-dev] [PATCH v2 1/3] f2fs: add write latency stats for NAT
 and SIT blocks in f2fs_write_checkpoint
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/13/2026 11:21 PM, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> This patch adds separate write latency accounting for NAT and SIT blocks
> in f2fs_write_checkpoint().
> 
> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
