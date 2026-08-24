Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86994C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RfzNKmDeToMPzhetA1oeYvkwWBY9Ek82F+85lbXJbBg=; b=WMfLANdjiTxIAT3lX/JmPRvIZ0
	c/6pSlI6Zh6wUwA6OyvGbi2JA3Pxibyp7jTy3GciTt5xREYif3qFX8t0N8CmAfcT6pCjZZ3E9r1Z9
	DxQlxLQEYN4kQdUWjsbu6dEn9CzBuxF9EJsZTJY6rSrTwGPt0JnXqIKMKJBwUmzKzdhg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyOj0-0006B8-EA;
	Mon, 24 Aug 2026 07:04:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyOiz-0006Ax-HK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:04:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qIKXhOJHl+ZS7XIvKRN62H7OghclKYl/pMGVw4RpNBs=; b=ETYCSvLS7VApH+ZrSnLV0c7GG0
 39Z64hGjdnOCkV6eusQgyDNt1BsUpapkNaeLbJ610F4ZRqDHfOQ5P9vlxWz+Y0EGxoYCcLMakWLrh
 X9ncYSJhYnQJzUT85fF3DfpigVQDoj0oYYMVVMKRORY65cKShHuDTnpbyf0K0OIFqATU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qIKXhOJHl+ZS7XIvKRN62H7OghclKYl/pMGVw4RpNBs=; b=H4aGCPD/VAQkgnd+l1VVfkTnQR
 lMTMQZdzZR2QtrS8eTouqm2K6gR9wAHvk5ZZnFngNEio4CbKBQxn8GL6ZHphzu3SqqUpkCPylP1qp
 2ql/hOJ6HPs0Sh5NB7jkZiY2ak7PeUqAzc3JKVagON/ZUi39ihxWJdG99arHUZ59bCZY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyOiy-00047l-Uc for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:04:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B2B940436;
 Mon, 24 Aug 2026 07:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B7F1F000E9;
 Mon, 24 Aug 2026 07:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787555039;
 bh=qIKXhOJHl+ZS7XIvKRN62H7OghclKYl/pMGVw4RpNBs=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Q35RSSecPSS/DE8M56ZhbNJ/ifT4RCiuHd1HmulSVProlWDsXfOEqIlLqWHLqOyDc
 Uj7XlQckJKwnZDquJLjvE5hgszvwLgWbup+IAM5KbbmSXervNYMmPc+/9V5q1JCwTp
 2kl7eDnA9Hq0MJPq3DF4+/v0fFTQ+J1Zft82vsI7EZRcYhoGbo4FTGJsxgMmt9Ajwu
 GaHLyJL27ozrjg30RPXAwIjDqe8/qqs5mb0G2sFgvT3RvAeFr8SqySvlu207JR+Ktr
 GsXDRtd7QaLldWBP+bqRs6UmP6LNKITUJqIXzV/4Ly0LpDtY5bODoUbqBSUHLORiOf
 /jub+tlae6Lyw==
Message-ID: <1866dad3-48a7-4129-9191-dc9b763e7e21@kernel.org>
Date: Mon, 24 Aug 2026 15:03:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-2-chao@kernel.org>
 <20260823125257.3227421-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260823125257.3227421-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wyOiy-00047l-Uc
Subject: Re: [f2fs-dev] [PATCH v1 01/12] f2fs: cache: implement metadata
 cache
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

On 8/23/26 20:52, Wenjie Qi wrote:
> Hi Chao,
> 
>> static void f2fs_zone_write_end_io(struct bio *bio)
>> {
>> 	bio->bi_private = io->bi_private;
>> 	complete(&io->zone_wait);
>> 	if (io->fio.is_cache)
>> 		f2fs_cache_write_end_io(bio);
>> 	else
>> 		f2fs_write_end_io(bio);
>> }
> 
> `io->fio` is updated when the next BIO is prepared.  Once
> `complete(&io->zone_wait)` wakes the waiting writer, that preparation can
> run before this callback reads `io->fio.is_cache`.
> 
> Is there another serialization condition that keeps `io->fio.is_cache`
> unchanged between `complete()` and this read?

Wenjie,

Thanks for the review, will fix.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
