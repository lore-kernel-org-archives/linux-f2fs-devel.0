Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C88C61CE3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zimPKYapVkgpi+C/eNEtpl4k3fImcF/643HzB5zm5oY=; b=d/djyAo2ZrryhCvbF5X9J8gQvO
	4P9AH25gFzBNcdCDOYKG31zWchUwjNeKpWaIrwjzQqUZEl9HLf4NoNgcAJy2kLhS74Oq/jCkClxlF
	7dTC/S+fd2N7HKUC8DCKTqtVcdE0lQr8fuu/RRnRQzfsCdbm9JBUqI7yK1tH8o7kkvc4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wykmo-00035X-BS;
	Tue, 25 Aug 2026 06:37:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wykmn-00035Q-7B
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T1juKe2OIJmSp+bgGiNvE3domWkVDZj0t45aNAKcz2U=; b=CK1YfYaBtrW7AUcYOem/SghGuP
 cnHNiqkcxfiUpzRGFtbkQk70zMCPmckqin45A3APcJ45QZk9DnJ5oL2Fr/hF5d1JDCXES4cUS2ROi
 2AWpU07mTdgFJmlRpLDQPBSVGDljoSQ11VwBNt3Z7oTxc86xyH4+7sbPKiRggh95JNNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=T1juKe2OIJmSp+bgGiNvE3domWkVDZj0t45aNAKcz2U=; b=Cqho3tHSDXdsBgQ9+W5Bv52LBM
 K/KHvgJasMK8hzIMLxNfuT3Ma5uPKMzxMQHADWQvIaQWVjlLs0LJBlk1wgEP/bMiqDgf+/xAjrvU9
 HROMh2HofMlx2XdKoxDsI3qPfakA+ifa8wRn5+PuI2FcPvaaSuvivrFy2SGYVgAxMppY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wykmi-00058G-Qr for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:37:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E3E86011F;
 Tue, 25 Aug 2026 06:37:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6D31F000E9;
 Tue, 25 Aug 2026 06:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787639838;
 bh=T1juKe2OIJmSp+bgGiNvE3domWkVDZj0t45aNAKcz2U=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=fBiqn5FfPqLphRakGtAKr7LN8RI/lNcQURq0w18bGn3EcgcZdLPAneR8cwH7E9dJy
 /YVdAbjakTkKAR/zlPklWqERV3pMgh7L9IBrQ9wvmU+eLTwD4eWJ1kc1+UEykmlzot
 4l1Zeo42T9vKxH4KZmBo6JAKhAs5o+OSmYmYVwCWWOgOVaajUGxdc/OcyPyV6ZKh0m
 3uBcQ626vtKboly4Xql4r2r2HV/ffsnY0PDXceNPk96zkOAXDIh87NbO3ukgWsKt+y
 pksdzbCfSCxyPYKPIwjoUUf486yndSxJWXxLgJNveOVNP8/TwRs+I8hLF8+1+iLT37
 1vRRVIFyJEGZA==
Message-ID: <d031a241-a2ee-4494-939d-09084aa77418@kernel.org>
Date: Tue, 25 Aug 2026 14:37:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-4-chao@kernel.org>
 <20260825054226.399346-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260825054226.399346-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wykmi-00058G-Qr
Subject: Re: [f2fs-dev] [PATCH v2 03/12] f2fs: cache: introduce shrinker
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/25/26 13:42, Wenjie Qi wrote:
> Hi Chao,
> 
>> spin_lock(&cache->list_lock);
>> list_for_each_entry_safe(entry, next, &cache->lru_list, list) {
>> 	if (isolated >= nr_to_scan)
>> 		break;
>>
>> 	if (f2fs_cache_test_dirty(entry) ||
>> 	    f2fs_cache_test_writeback(entry) ||
>> 	    f2fs_cache_test_locked(entry))
>> 		continue;
>>
>> 	if (f2fs_cache_refcount(entry) != 1)
>> 		continue;
>>
>> 	list_move_tail(&entry->list, &dispose_list);
>> 	isolated++;
>> }
> 
> `isolated` advances only for an eligible entry.  Entries skipped by the state
> and refcount checks do not consume the `nr_to_scan` budget.
> 
> Is `nr_to_scan` intended to bound the number of entries examined here, or only
> the number of reclaimable entries isolated?

Yes, better to consume nr_to_scan no matter what state of entry is.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
