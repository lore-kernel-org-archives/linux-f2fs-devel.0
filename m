Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980F3C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Nov 2022 07:14:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ouTfe-0004GR-St;
	Mon, 14 Nov 2022 07:14:18 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ouTfd-0004GK-HA
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Nov 2022 07:14:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u1bcxRTnILY+C1rVP/z1uJqWUp1BuExHd/QUndm4w0c=; b=aMifx9jAfKpl6Gq0zs7H8Ce2PR
 5zzbSW2ln0FekWSo6at1k8b2ElepcGIyJqUY5y9XBKxjNQkEY4fUu0MtS07vBymHY/q6zz2wk2u4A
 F4QCKfa+OfyKfN7Pcv+iUVibdetotnWIXi4zFj6U+5eaHk8kXgpkxyNvfFuskiLW9CU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u1bcxRTnILY+C1rVP/z1uJqWUp1BuExHd/QUndm4w0c=; b=eUxf45Q7jB8YSXL60C7M0Rfg2p
 FPImbUgtWXlEfJrb4REWe53eSBc0/57nCOa4xV0fi+KW03oQp3z6cUdS2sfzfeIZBIYmZFw4OzroT
 n3eE8VnJvMRrJPTpxP3cnWqeMoPMa9sfVqPoTaZAJU8ugYlrf8G9Rod5/YhyhsZsXjqY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ouTfc-0005iG-BS for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Nov 2022 07:14:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EFCC760DEF;
 Mon, 14 Nov 2022 07:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B8BC433D6;
 Mon, 14 Nov 2022 07:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1668410050;
 bh=IYoQEGPZ+Yjd98Eo3nCP4a2hu5VXfVjx8RpXSw8+9M0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=T4KuhvYSQNEabHstI8gwGdnVWl7RLZM7Imp0KZSXtfQvmMU3zvPhxVpyrWFeo+uH3
 6sY1EQBToWPQiIxvdtsVaDhHujcZD1fz07Bco2H0jJj6SOb7Po+FZah4I2744fg+9A
 vU3fJYywCONIzlQQFunJ8jqMe6y2UM9hsy3V2wKsLc33jrMBDHH28xyXivjiNqUqHy
 IY14ph+9dKBvhGVfD9he6XbhCS/yLfMiwp9D6LXh0KTHVnPD2psVI1PyvGTvKX5wfb
 MTlyQK/DpRVWegXQO8uX4L4+QT1xRPqE7EV4pJjvEBgZh6cupUeqnF9MwhEQ+OxuSe
 RxBS6oz+xHoCA==
Message-ID: <fc15b658-2568-ec52-9ee4-60598bae550f@kernel.org>
Date: Mon, 14 Nov 2022 15:14:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20221110140723.92752-1-shengyong@oppo.com>
 <20221110140723.92752-3-shengyong@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221110140723.92752-3-shengyong@oppo.com>
X-Headers-End: 1ouTfc-0005iG-BS
Subject: Re: [f2fs-dev] [PATCH 3/4] fsck.f2fs: fix potential overflow of
 copying i_name
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

On 2022/11/10 22:07, Sheng Yong wrote:
> If i_namelen is corrupted, there may be an overflow when doing memcpy.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
