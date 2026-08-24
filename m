Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D300C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PbhgbV5g8E5rbBkCGs7f/GwGFs3BJ31P/RKeX+wKT9M=; b=QyxefRijBYmFJzWCIHh16g6bM+
	W5knX8/u2ksUeaLB+ppt9NPmGolntNipiHebJUeW4a17GV78zv5apqmcxx2DjF0z+uncRh9JUumHJ
	hJQeEzVGLIWiemM2fvti0vvKUa2H3bpDpfaf5R/6aJkY5RUMhHtnHTI+rLOVBKKv3oNc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyOk3-00009l-3s;
	Mon, 24 Aug 2026 07:05:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyOk1-00009d-0Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:05:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=13D2wQkBlESk0b3d5zsepVQdWpjB09Jw9tANNIK+4Lk=; b=Kk0o7dLUADOzs+rNcOMiBIv2Wi
 t43c1zqhksM1uq4dSylwQwaAFco45rVN4F9boraMBgRb/MbA+3nE+l72DHNE/WmuQfdzrd8zMCZQs
 OoH1cHdHqsG7ZKjbKPGQz/dZj1pLEVdjOwVYMJRDJZ2xpUcfISC/atNenz0DwnLsqiTE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=13D2wQkBlESk0b3d5zsepVQdWpjB09Jw9tANNIK+4Lk=; b=CrHoqH0WxRZSSCHvlCnQ6x2PHp
 oDXel2WxOP3yIe3Vx/QpVN2Kdd4yFJVu8K8T+wQVxFsrB7sLaWk2tIH5OVOsZTm/tQGrYJzhXSt2A
 yjmIGLQU1eLdxuZ3qPqHCS092Yfks1kNLmAB6SypsBbyx/jHV/4We+/FZVaC4fehcnSA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyOjx-0000jo-5W for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:05:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AE02641FB5;
 Mon, 24 Aug 2026 07:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448BD1F000E9;
 Mon, 24 Aug 2026 07:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787555099;
 bh=13D2wQkBlESk0b3d5zsepVQdWpjB09Jw9tANNIK+4Lk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=IKNrMaUMxCuKTbBViW+M+inSSWZIiXe4i7yfxfyTMrOoup3m+78PHBP0LZTJOgunx
 PIyLfVnlNcRhNrNmX/Pizf8gGHVeIVDRK5vRgeNSMcUO5MPJjJFHpjGEds19EnmlXv
 7ucoMCwQ5kwVsrXctuMJ7OpEyDEEQDtGyz1zgFnVatCBYFy6WWOSxk9W3h0fPO9UOY
 3gnAUAfUnMc2kEynrvnNmbrYNPSdN1lWNQ/Obfw+G5kDM4H9nDfp8ys5MISj24KiLf
 KW6EsOeFUj8iPenFnFdrFSmMjqBH244IRz+WuxZ17s2uWGLjZDWZ9muOJ+soQfScYF
 9RNj/HPgwPgww==
Message-ID: <8cf1a7a6-d2dd-4241-baf6-0ec3bd9b860a@kernel.org>
Date: Mon, 24 Aug 2026 15:04:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-5-chao@kernel.org>
 <20260823125448.3228967-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260823125448.3228967-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wyOjx-0000jo-5W
Subject: Re: [f2fs-dev] [PATCH v1 04/12] f2fs: cache: introduce writeback
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
 Wenjie Qi <qiwenjie@xiaomi.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/23/26 20:54, Wenjie Qi wrote:
> Hi Chao,
> 
>> cache_thread->cache_wb_task = kthread_run(f2fs_cache_writeback_kthread,
>> 						sbi, "%s", name);
>> if (IS_ERR(cache_thread->cache_wb_task))
>> 	return PTR_ERR(cache_thread->cache_wb_task);
> 
> After `kthread_run()` returns an error pointer, `cache_wb_task` retains that
> value.  The later startup and stop paths distinguish only NULL from non-NULL,
> and the stop path passes a non-NULL value to `kthread_stop()`.
> 
> Is `cache_wb_task` expected to remain an error pointer after
> `f2fs_start_cache_wb_thread()` returns an error?

Will fix.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
