Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46F7C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qVjwqd2GDzFll2lQuDqsVYBniPZQAg2RH5URHTtopeQ=; b=c+BST+qhuZXnMmDCiV5h+/GyGm
	K9ZpuqmMztyvQhljhyF1c8zwP/2t6E+Tx9aV8aRWnvRjIJQrGbIv9r0NwdCziN5R8wKmyJ8y650KG
	3GvTUPu1VZXUEcU3VNQNC2jmax9aTtSBmz2PYlFSkDeA4Qy07JdwG0quBjJLBGsLojMU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyOsF-0000Mr-LF;
	Mon, 24 Aug 2026 07:13:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyOsE-0000Mk-Rs
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:13:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XvsXeq4eUYOgZOsgjFbHfYmUL2up8it0tx4AeAyPmRQ=; b=TWu2L5M2hbLlpvRRBaKA/2lk49
 234JT0btGHeE8aXAl6pTvOJT4Gz3s3+5iGiFMz27CK2LeQoj+CNiIBw3IqRE6TfcsArLSu8Bu+FzF
 trC3WAhA574Pn1zCU4ZI8tH1u9Rt5YQrM1pvyXlWcBLJUGESaYEz32szXsjnq7zVcL4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XvsXeq4eUYOgZOsgjFbHfYmUL2up8it0tx4AeAyPmRQ=; b=HfCY+mIwsg83mXSdK7prgx0L6n
 O794iBYPl7GLfOAl9Wh5ltsX4nt+qYQrBtL3EurO1InDsrykBJkROmiZPkKItI93WT+d4rYHIkpJu
 A1Wt654IYABHql5KZ82et//024Vo8TxqvVxkSEgjnPqBq0vbS96+5EeicgT/LSwfHqLw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyOsB-0004Qo-Tl for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:13:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 247CF600AD;
 Mon, 24 Aug 2026 07:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0411F000E9;
 Mon, 24 Aug 2026 07:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787555609;
 bh=XvsXeq4eUYOgZOsgjFbHfYmUL2up8it0tx4AeAyPmRQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=GP996H5NI6ogxnm/GfZADApU/aqtgYbU68+oLd1bylY4O5WnzWAVXXnacwo7S1I9U
 9J00opDVImT6MFQhG2A/nvZ3cVv412UGlOnln2OVevzXmI5xABLTExNaFkj6flQAy9
 YNRyZkF8LJIbu2OHjKOnLF6Xe0a5H9uz/n9oYjGHRHps64oJa8Xr5OHo5Vu1nfmQ00
 bTBtHDJgyEvjBZMCfOY6j9nMoctaWiU8Q9aEt9rNSD5opEykFxbperKO3AvoBjBIUO
 qQv0a2qG91nCwxxzleovkstckGZ6OJEztbVvaKOVzNwC9H4RlerjWvRX/XZGCZX17s
 SMfDrlolqRd3g==
Message-ID: <234a5bd3-76d1-4fea-bdc4-f1dff01e591b@kernel.org>
Date: Mon, 24 Aug 2026 15:13:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-8-chao@kernel.org>
 <20260823125735.3230503-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260823125735.3230503-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wyOsB-0004Qo-Tl
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

On 8/23/26 20:57, Wenjie Qi wrote:
> Hi Chao,
> 
>> entry = fn->entry;
>> f2fs_cache_get(entry);
>> spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>>
>> f2fs_cache_wait_writeback(entry);
> 
> The entry reference keeps the entry allocated, but the waiter does not hold
> the entry lock.  After WRITEBACK is cleared, invalidation can detach the
> entry and set `entry->cache` to NULL.  `f2fs_cache_wait_writeback()` checks
> and uses `entry->cache` through separate accesses.
> 
> Does the reference taken here also guarantee that the parent cache remains
> attached across the wait helper's check and use?

Do you mean race like this?

- f2fs_wait_on_node_caches_writeback
  - f2fs_cache_get
  - f2fs_cache_wait_writeback
   - checked entry->cache, it's valid
						- f2fs_truncate_cache
						 - f2fs_do_truncate_cache
						  - entry->cache = NULL					
   - f2fs_cache_wait_writeback_cond accesses
     invalid entry->cache

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
