Return-Path: <SRS0=8t4+=MP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36162C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jul 2021 02:41:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F02A960EBF;
	Fri, 23 Jul 2021 02:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F02A960EBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6l85-0002b8-44; Fri, 23 Jul 2021 02:41:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m6l83-0002au-MC
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Jul 2021 02:41:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Ex1NzR215+Du0scklayqcBmeLn9/yGaIMtezGv2h2k=; b=C4LApPQ2B6x67vh/+s1/meVJGx
 pM/y7NfXUOPR94p3NLoQs5hE8yiQaM2i4J2ZMIMFHKr5EINaeoznq/g9gdwNfrvApidFUOPuztVV4
 PM9i2jATv+qL2KzhaBERDlUaDRFWHCUNbum4xHLOIlPPM5ZBtmK4yFPQ1+gQLiAH6HQk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9Ex1NzR215+Du0scklayqcBmeLn9/yGaIMtezGv2h2k=; b=fZwLYaX7sPfze2H8BI2WNn+LO6
 6tknvfBvchBCY2N45/GKg9WiUddZKhJq5cfjwLtc5GBSmIfhy6SKfXc3xt7pxicOked/HbSgozaiS
 itbMrsdYqmUCo8AbreEOFEtbGMTobU8OmyZPmVzcn+U/sB3JqyNzLgiaycwxryCcmoOI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6l7x-00010U-LK
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Jul 2021 02:41:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96A9960EBF;
 Fri, 23 Jul 2021 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627008084;
 bh=JSAe/f6FLauxnrmz5Uq68q6e5ZvuMKEjBqoyrMmhzpQ=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=aIX5knDUMaNsdXTyV8roJWrHI4dBY+/KrlZGPP8Dw3gytFDkhvvzT7tO4oETmLD+b
 /9n2C4kCWz7q6DHvbEm7SV42vDdGI/UnMUb9QmZ+fTNhWWJiuSoBKtivcQnAItn0C0
 GfZaxiRm+HLQ7s6v/FjaoF0jf3e/AaZgIcxBbPdDJGq/O9lEowGHuHHmQVFfT6eYHm
 7hbVBfyjZbF2it6vyptN+o7g9h4S+5bnwoEttBldLdn3fQkTyUnbNDjrZr1oDPtxI8
 EoN3dniWaYjIDrS/C1aPbD5rY4NVW1Mb70ISbu1bZ1e+D6TNz3b2ZwaBWPZDdcjU63
 g5ZcF/OSScsKw==
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210722014149.525166-1-jaegeuk@kernel.org>
 <YPmufPvn9FJXfcip@google.com> <YPorDEwJcW3bi4DF@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <014f9855-3268-1d7e-98b6-0b8eb252bf39@kernel.org>
Date: Fri, 23 Jul 2021 10:41:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPorDEwJcW3bi4DF@google.com>
Content-Language: en-US
X-Headers-End: 1m6l7x-00010U-LK
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't sleep while grabing
 nat_tree_lock
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/23 10:35, Jaegeuk Kim wrote:
> This tries to fix priority inversion in the below condition resulting in
> long checkpoint delay.
> 
> f2fs_get_node_info()
>   - nat_tree_lock
>    -> sleep to grab journal_rwsem by contention
> 
>                                       checkpoint
>                                       - waiting for nat_tree_lock
> 
> In order to let checkpoint go, let's release nat_tree_lock, if there's a
> journal_rwsem contention.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   Change log from v2:
>    - don't bother checkpoint
> 
>   fs/f2fs/node.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 0be9e2d7120e..b26642daa3d2 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -552,7 +552,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>   	int i;
>   
>   	ni->nid = nid;
> -
> +retry:
>   	/* Check nat cache */
>   	down_read(&nm_i->nat_tree_lock);
>   	e = __lookup_nat_cache(nm_i, nid);
> @@ -564,10 +564,19 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
>   		return 0;
>   	}
>   
> -	memset(&ne, 0, sizeof(struct f2fs_nat_entry));
> +	/*
> +	 * Check current segment summary by trying to grab journal_rwsem first.
> +	 * This sem is on the critical path on the checkpoint requiring the above
> +	 * nat_tree_lock. Therefore, we should retry, if we failed to grab here
> +	 * while not bothering checkpoint.
> +	 */
> +	if (rwsem_is_locked(&sbi->cp_global_sem)) {

You mean: if (!rwsem_is_locked()) ?

IMO, once CP is processing, all readers who needs read nat will be blocked...

Thanks,

> +		down_read(&curseg->journal_rwsem);
> +	} else if (!down_read_trylock(&curseg->journal_rwsem)) {
> +		up_read(&nm_i->nat_tree_lock);
> +		goto retry;
> +	}
>   
> -	/* Check current segment summary */
> -	down_read(&curseg->journal_rwsem);
>   	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
>   	if (i >= 0) {
>   		ne = nat_in_journal(journal, i);
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
