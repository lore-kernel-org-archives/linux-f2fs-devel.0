Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA55C61CE3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STXKtCRm8LRDLYeazgTaVEUsVfbwqqNzfMDqu1PmvME=; b=j7OuwmYYkKz/JAgbX9URARpT1b
	j0Rtte5nNvoPKgVMLuBQ7YvsPClm/trNBxNhPCghHwXsuNbg+2djb6dPG/sJhWceq/vvGi+6EB40d
	4D1RbPkC3fV4W6GawMZxZ5DwrMkAYoP7V1s9dPVWSdWwxEaBc12wtKYUQLfMD6+WXyB4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wykq3-0006kY-Hr;
	Tue, 25 Aug 2026 06:40:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wykpa-0006id-G1
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/Q+NpiiFl2aNWbg70O8DFOTdkeOFE8QEIeXcleG8hUg=; b=ZT/jfLp0AHo7ZeLYTWxFGRU2VA
 Gijcv3OVh/EU3P1iHnFs+TAnfFPyKu1vN41tkiZSkHGgkrk+LmoIMz0s9W0zPfiUo6rckg+VrdQCs
 cbX/SGf7sPJDyjDkialJaCcHU4zIcSAlzlDmc768SEDR0ya6QS3u/a8QMsFYr5REwols=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/Q+NpiiFl2aNWbg70O8DFOTdkeOFE8QEIeXcleG8hUg=; b=f1Tg8/E2CaFO9aSoSLfEc23K3a
 yXvjVH0p3ypecej95GyZpu8nKFdUWCEkxahqMinAjIbQge4o6z+FamhvGMx36C8oTbJLQjhd0LoKc
 LaX31dRYgyiTJoWtAa7ZNhQES2lpofeKYk3LpeFwNVSbC0qFpQXZsjYmhK+1w0aOp7Lk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wykpa-0006sQ-R8 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 06:40:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C9116011F;
 Tue, 25 Aug 2026 06:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3F51F000E9;
 Tue, 25 Aug 2026 06:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787640016;
 bh=/Q+NpiiFl2aNWbg70O8DFOTdkeOFE8QEIeXcleG8hUg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=V4vFO5vY/JExdmr6VRZcAnu8Mp89x2jtpUxcjLweJyKa8W6PjFrWLxaPdF6tR6o07
 lyKw6q1EQj2gMvNsb6f4H+RAB3iXdqriva4/UoVYDm1p8RHHjcgCpJU694EoUkGHcU
 bIeVV1pRvDSaBwVlnhILgNUeO982jKlzRT7/c8P5W5xcgUEp/cb40rJRKVTmhEbv6M
 YxTtsztwrHw/LTQ+d2dEmAa8/KApdy3bgqkP73yXc9TjEyjNQpWs6sCX6pFX926CAI
 vP0mPoyL/7Nh0mWv/upQjsvPHZsHKD+4IoEZkssz1xwLpGsxWP2H7zW66K+xko4WGr
 uSceC7hIV7uCg==
Message-ID: <f9369204-aad5-499c-bad5-fb268ee0c2c5@kernel.org>
Date: Tue, 25 Aug 2026 14:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260824134731.3704352-1-chao@kernel.org>
 <20260824134731.3704352-8-chao@kernel.org>
 <20260825054331.400340-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260825054331.400340-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wykpa-0006sQ-R8
Subject: Re: [f2fs-dev] [PATCH v2 07/12] f2fs: cache: use node cache
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
>> if (!f2fs_clear_cache_dirty(entry))
>> 	goto continue_unlock;
>>
>> if (!__write_node_cache(entry, ...))
>> 	...
> 
> and in `__write_node_cache()`:
> 
>> if (unlikely(ni.blk_addr == NULL_ADDR)) {
>> 	f2fs_cache_clear_uptodate(entry);
>> 	dec_page_count(sbi, F2FS_DIRTY_NODES);
>> 	...
>> 	return true;
>> }
> 
> `f2fs_clear_cache_dirty()` clears the entry state bit but leaves the DIRTY
> radix tag for the writeback transition.  The `NULL_ADDR` return does not reach
> that transition, while it clears UPTODATE and decrements the dirty-node count.
> 
> What clears the DIRTY radix tag when this already-truncated path returns?

Hmm, Actually, I don't change the logic here, just change the API, I can take
a look original logic a bit later.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
