Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D4EC5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CkdovhUNjVcYsalUuRgTIfLnLO+XLY5vnMKT5Ix0DHo=; b=gkidsmo2iZFKEEWDDHlTxnAHmA
	RnhlxEQrjUarMSiR+Iw5QL7QTAm7CbVfMzc47tCAXpnLXt+4qDVg29JxtS8lj0BSJzOb2J21bE0Xa
	vHw5RDxZzUcRTrZx4tShYSeGkBWVUEYyHUNYieO9un+AfVHwCcYoxA1g8Wwf/7S5fWOk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wykrT-00035i-Lc;
	Tue, 25 Aug 2026 06:42:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wykrS-00035c-FX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:42:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k2frwSbW5ls9FKRLoiPqylB/8nDRy7vYulFwoTe4v4E=; b=f+PB8Pj7Su+8VCH2j5+/UThRa3
 BIojBOD0B26ln8i6MxQ6oDwWsVdMZs/6iFT6en+TU+VtmRezahyEQAT9wcib6nHQZzBWs5ecjXnkf
 FShjrPap5xBYkTgGfoAsL37/Nz2QNBnYpcrxk1vMew0MeuiRv6eLc0t+CbN5VsWo8CmI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k2frwSbW5ls9FKRLoiPqylB/8nDRy7vYulFwoTe4v4E=; b=iVaz8UgPMrgZOZqXhhKpKSbVCM
 qV90wA7pRGm2yRPYLstI1GndQ/eoTUhvos8BC0KnGj3+m3ebR1N46AucKFnQVpnJIfLMjmDfJgunp
 dHQU8myeWVdqawP7BYmMV0Dmr3HWL9XafxdWqg+xDM3ClIx4h77C6cM+wP0uKbGC9hYY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wykrR-0005LP-V0 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:42:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 541526011F;
 Tue, 25 Aug 2026 06:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0266E1F000E9;
 Tue, 25 Aug 2026 06:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787640132;
 bh=k2frwSbW5ls9FKRLoiPqylB/8nDRy7vYulFwoTe4v4E=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=L9vRbYpo8ePlcmUe1YP6Sud3q4pOfJIUnctdnDkOI20xOitUKzHU3gYS4u0HPRweX
 lYUFsxxcxjnwGQB7Ifqw12hSALH1BI+7PT3nKISmLehTLfIyKqqkk1O6jpskkcZD+9
 m2V6TcIa6G2UDuWweii+UzlQb+eptc3NpaeAoMC48EJGtwMQ0yeUb+RSQ9jkmschZ9
 flmbqQN6bnJF1+HCp6tIVXd9AAEOhAFiLXwQ4/RYz3cCYW9orpZySeK0IzyyBN3B2y
 U6QIvpQ+pNhkZFUvT0L/T4tW+OSTR+lg7xnHHdtbdeGbzf75fnMJmxeW1IJieIBep1
 JCI0LPNF9KuIQ==
Message-ID: <1f08233f-1bbc-433a-9da9-b36157e09f3a@kernel.org>
Date: Tue, 25 Aug 2026 14:42:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-10-chao@kernel.org>
 <20260825054356.401106-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260825054356.401106-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wykrR-0005LP-V0
Subject: Re: [f2fs-dev] [PATCH v2 09/12] f2fs: cache: use compress cache
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

On 8/25/26 13:43, Wenjie Qi wrote:
> Hi Chao,
> 
>> entry = f2fs_grab_cache(COMPRESS_CACHE(sbi), blkaddr,
>> 				F2FS_CACHE_LOCK_CREATE);
>> if (IS_ERR(entry))
>> 	return;
>>
>> entry->ino = ino;
> 
> and inode invalidation reads:
> 
>> if (IS_COMPRESS_CACHE(cache) && entry->ino != ino)
>> 	continue;
> 
> A newly created entry is inserted into the radix tree before
> `f2fs_grab_cache()` acquires its entry lock and returns.  Its initial `ino` is
> zero, and inode invalidation reads `entry->ino` without taking that lock.

Right, better to not change original logic.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
