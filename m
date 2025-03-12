Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70923C282EC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 02:53:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsCE7-0007OI-GL;
	Wed, 12 Mar 2025 02:53:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tsCE5-0007OC-PO
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 02:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eCZ4O/rS37qJSTd4itT+S8dTU8z1duuXOpUksYqlGG8=; b=VGZBTEskd/KKJox0f/Rm8nDcin
 VKtw86Rbd12EPCQusD3BEAraEu1SF9WLUoqkvHy0BftHgF5E8/I1HnASqLEJfJ2GPiTLvPvzUq8/W
 orjnA3gSgQxLwZPi7iI+1tIX+LnSTDHUl1uniAvOcrYIDg8TbvzQzrWI9CXZyhesKbeg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eCZ4O/rS37qJSTd4itT+S8dTU8z1duuXOpUksYqlGG8=; b=LGzmma8HFvUo8J6kLztFCDLwZX
 mA9LuBAYUr8hV6zY/QAqOyNzQi9MBxOpX982dDfIrQAKPfyM6agiK2afA98Gp066I20MI50PlMP5t
 8xzJHNnYOlCjPBfCrcA5Unkz/gPhVaLnMwUuU7sabSa5wGs4YwkZRQrQSfgKOwhY70ro=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsCE4-0000Rx-18 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 02:53:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 52CB8A46CCF;
 Wed, 12 Mar 2025 02:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6490C4CEE9;
 Wed, 12 Mar 2025 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741748013;
 bh=c0nPNHMEj2EaB+IMjd+p9+tgLxA5qJUbIMyOKfrGB2I=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=cqoGY/xy1CZSuwHMNm7+wcJRMr9dw75RK2vLwdY0xXWJSU+bhYoBY0Dzsu+9/+bqB
 HlUX8ofx31wB+3Tib/NN9pEfjUS6tfe50oy11L4KFpAkfEYcfsBu3aaVP22H8kE01y
 NErHMhVKZDFMV3kHCtDPfS3XqQHVNESNdkPeRorE4zCjIRAGSC3H3nC1a7i0YLHP4X
 504lcEBts1wOk/fO+NvvE72KjT1MKjtkTlup8CoKwmrj5rAkQ/aRFYKteLL4mljzFH
 ZEkt8M4qRbwjVsCeTcTJYcx/x6cU7DH8/rcsp4bFhcLWxMInsSNY4N/6xFJu5nLdvD
 oV6GtYJb7cOLg==
Message-ID: <7de8de7c-4dc3-40c6-8435-122f72944850@kernel.org>
Date: Wed, 12 Mar 2025 10:53:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250311182931.1043290-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20250311182931.1043290-1-daeho43@gmail.com>
X-Headers-End: 1tsCE4-0000Rx-18
Subject: Re: [f2fs-dev] [PATCH] f2fs: add carve_out sysfs node
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/12/25 02:29, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For several zoned storage devices, vendors will provide extra space
> which was used for device level GC than specs and F2FS can use this
> space for filesystem level GC. To do that, we can reserve the space
> using reserved_blocks. However, it is not enough, since this extra
> space should not be shown to users. So, with this new sysfs node,
> we can hide the space by substracting reserved_blocks from total
> bytes.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
