Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C897C5DF81
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NL/RpORkFRqsZIIYzM32CVAi9+a4/ZxZezWKeuHRfr4=; b=GG/ut14U29h/6C6BO430rUVLCZ
	5ICyDw+LxwW1lUqBjBkUfL7EYsIB/hYWKRRHG/kdl+tL+ReC/DxvKInbyh2ic5l9ZbmhvDO74iKHh
	R7i4kqDxxNgDRzm0pAoxzdeaX95cPqjwEJDbGddsx7gl8lZksunmV3Y0DoGVxKIOKe6o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyOsV-000751-Ln;
	Mon, 24 Aug 2026 07:13:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyOsU-00074j-AT
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:13:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RNGMH3yPdmGlBz3tDmrQhbQWLMyk/Wd7O6SlC0s4+Uw=; b=IrPmHE+v/M37Tz9D/BCBYMaMzm
 P+T0fviyoONKZauwCxHI4nB/s/5F0XLI7N+VRWm42wuNHcLoLj/TCEMhiyu5CNuGGmtZa+40xNq5a
 +dUoY/uiJwZSgujCNDCtCaUwwGNDBoDqwiTL04MfGDHR07vFoS7LM8jSy2tjCinSNREw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RNGMH3yPdmGlBz3tDmrQhbQWLMyk/Wd7O6SlC0s4+Uw=; b=he/4gnF7dMHVDDAZ6Rk0d4/z2R
 XO3hv+Ysw6UkWKGqFfC+UDRs3/WwkMiGYEcCtKxWgD8vUJCc0OCHKgWEChZj8cLIZpOkKOEK8OR3s
 AybisI52dauz1zGEU77L8hZF9eBw3/0mF++aZCx0zG/4rFIrLjfUi9UII2jbkeVpe9dg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyOsU-000190-2U for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:13:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B4B2741289;
 Mon, 24 Aug 2026 07:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490031F000E9;
 Mon, 24 Aug 2026 07:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787555628;
 bh=RNGMH3yPdmGlBz3tDmrQhbQWLMyk/Wd7O6SlC0s4+Uw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=h/r0gfi0y5/9JLPC5u/9tvM1q0OUpwhsBnCmt10leUG62fMP1EYrBe6HFvoy8Wg0l
 7twJFvzy5awVdUdyOdsVacbrYNZvEmDynqXbKxhhx0j/38o9UJ0xOERfbCUvQkTxFm
 EmjGVTK5z06zl4X88NKz4rMHm4huLF6nbbwa3PC6ooxrj5MJS1z8JOPpZxbXH48FKi
 bs3eYGoOer/z74G9wOTdOtJwqt1sFKdziMfvYzhVg9jPrIyOM466S0/BAim+DmV19n
 xuZ6iKw0bXybKbFlm1dTeWVMUy+BWbX6RJxbJ45IKrjn3Kc6mx2ABiKP6TuQEF8v5O
 XIDrWxAb1A+sA==
Message-ID: <4d408110-0579-4916-9e28-e3e831486980@kernel.org>
Date: Mon, 24 Aug 2026 15:13:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-8-chao@kernel.org>
 <20260823125908.3231362-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260823125908.3231362-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wyOsU-000190-2U
Subject: Re: [f2fs-dev] [PATCH v1 07/12] f2fs: cache: use node cache
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

On 8/23/26 20:59, Wenjie Qi wrote:
> Hi Chao,
> 
>> out_err:
>> 	f2fs_clear_cache_dirty(entry);
> 
> Both the inode-checksum and footer-validation failure paths reach this label.
> `f2fs_clear_cache_dirty()` clears the DIRTY state bit, but it does not clear
> UPTODATE or synchronize the DIRTY radix tag and dirty-node counter.
> 
> What invariant keeps these states consistent after node validation fails?

Will fix.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
