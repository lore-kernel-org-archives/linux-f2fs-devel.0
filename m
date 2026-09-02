Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D00C61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P1xmaX7fXirZEHLRgggRM9gvx5Oh6Rwhgjxcz740bZU=; b=bfz/YYLXlnwFrKkMdtPOjxtIAU
	3MFl0kotRx+tZTmbR6AZMweIl0BSDwllhkT1mq4RvT2IdT/hd46KWKe9oCgphuV/G9r3caXia3Ovx
	nVb7b9fflbwrHqjU7IoneKG5u1+gulDTKT88/33rWGSeLK50eoP57sq/HFlnfNVmqRJY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1jz0-0002Te-4X;
	Wed, 02 Sep 2026 12:22:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1jyy-0002TR-IW
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=89TMwyN9hNCf8InjZ/BoJd7/XuvClRBjnluIOo0LKe0=; b=ENr5MshsXHiPgTv6S7ij0EGuTf
 D3NdR+E+qlhWdF6wMhO8tJmVpbLnviqz76ury10hfHDJDh6KaONiQSYT7TrhJOsLAafE+RMLmaaLy
 noVszYkbhyHS4zeBnla2eCUJ3WsyzGQPJF3Xx79xtmqyyMDcVglTPzzYC/mhEvIjDw94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=89TMwyN9hNCf8InjZ/BoJd7/XuvClRBjnluIOo0LKe0=; b=ZzukCKDCHnw7PiZCpu42fmmvEb
 rQTeNSaeOI0vh4bmLuj/Stgd9W0FZ7yKF4Ibt3j3hUxzzI6b1a1sBHsJz6Jej+dV8fHcGlpBvd8Xd
 2MGv2IkuUWTaMnCbzH/pK6eyxO+gzRn2LgCZXAj5gnW199raKL3iKlX24qlAUy/BZXSU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1jyx-0003Sp-Ub for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 12:22:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8CA1A414BC;
 Wed,  2 Sep 2026 12:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687421F00A3E;
 Wed,  2 Sep 2026 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788351738;
 bh=89TMwyN9hNCf8InjZ/BoJd7/XuvClRBjnluIOo0LKe0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=LxRvGO/MggPRXmQmjjeoCO+sMdBslb0FTEP1B0/rRrp4etc/feY4cPSZonVNFcYXc
 hrS1Mc6wG3Tk5z7H/LQmZwE8l5pnufIrGBkj8SAggB6sYy9Nsvoa6fUr1oGDWySHMn
 L2kiYwx+XnONiqIXzQzN9l7KPJjUC53lYjlTlxFNLT0Xc4+kt3lWcIBlqjDXXLbJnx
 Q7BUvE216Kx1jXJvkd3katwP+Cq7X+bTxPRNt2IIGOE9kY96DDmhoPWJcK0LM9XYLX
 lzKVXBBYwqahc5Z3Z0jtS/HY/CbwVetvwOYxM/JyBx07wxCAsFFY9n3T9HSGX/HzuI
 cVmcYwM9muuJg==
Message-ID: <46ee7fba-6a20-473c-b87d-856fa4ce1865@kernel.org>
Date: Wed, 2 Sep 2026 20:22:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260831092227.739737-1-chao@kernel.org>
 <20260831092227.739737-5-chao@kernel.org>
 <20260902115636.691796-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260902115636.691796-1-qiwenjie@xiaomi.com>
X-Headers-End: 1x1jyx-0003Sp-Ub
Subject: Re: [f2fs-dev] [PATCH v5 04/12] f2fs: cache: introduce writeback
 thread
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Wenjie,

Thanks for the review, I've fixed all issues in 04/12 and 09/12 patch in
https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/?h=feature/cache,

please take a look.

On 9/2/26 19:56, Wenjie Qi wrote:
> Hi Chao,
> 
>> static int f2fs_cache_writeback_kthread(void *data)
>> {
>> 	unsigned int interval = cache_thread->cache_wb_interval;
>> }
> 
> and startup initializes the field after `kthread_run()`:
> 
>> task = kthread_run(f2fs_cache_writeback_kthread, sbi, "%s", name);
>> if (IS_ERR(task))
>> 	return PTR_ERR(task);
>>
>> cache_thread->cache_wb_task = task;
>> cache_thread->cache_wb_interval = DEF_DIRTY_CACHE_TIMEOUT;
> 
> `kthread_run()` wakes the new thread before returning, while
> `cache_wb_interval` is initially zero.  The worker copies the field only
> once, and the sysfs store later updates the field rather than the local
> `interval`.
> 
> Can the worker observe zero at startup, and can a later
> `cache_wb_interval` write change the interval used by that worker?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
