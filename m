Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9101CC87FC9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Jul 2025 08:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LljQEkTLf1BywuVKASb8V2OqtpqXj/zFhSkyGxZoK7A=; b=XpO/Wf7Gy9sY/FLBMm4AO2lbEe
	TKSltoiBMhpmc1jqAhXS2jLjkUb7RUZhZ60wh2+wh+Ak4o1K1ET16CImndu4mmYG6QOPSQiQfB8wc
	66TY5CXqYIpJwpy0VhWupKPvvjC+R+Y4l02oVGTfEQzmZp7HfI4LdYa9AX9f7YnAKgv8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uh2MK-0004eD-EE;
	Wed, 30 Jul 2025 08:40:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uh2MI-0004dp-Nx
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Jul 2025 08:40:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ti3y1aMY6ek/BYwcKtihPk4HYJ7ki5/kJcIMsEBJBec=; b=bT1FS2MlUVjq8MIt5Kbf0TUPzU
 gS4hhB5y1WGWm4LzzqShsiWjIJLjqDmZP8MyS5DBUHguHsUtGKEChsDPIWpw8QN2bsFKnbicDOVdi
 Are/WoJ4aGiVCArErUWxDAafyU9iLEatZ+UeAyBSBgTMEyMBdvd+0tY6IdhwiW14iBZ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ti3y1aMY6ek/BYwcKtihPk4HYJ7ki5/kJcIMsEBJBec=; b=P1yYWxC928QnRAlDYZSBe05kid
 fzZ9ozWMl3M14XOC4qDwVvNaZAzXxEzugCTIda1L1cclZz0uZSS0AVptIdHQq7V4YSEHLVbFPqOo4
 H4GUq6QQOt2CwNhkUM9V0988R9voYgVZHzpoPf6+TvEHKsFsgTgtXnB6kodbJKDg4I9Y=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uh2MI-0006sO-7O for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Jul 2025 08:40:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CBBA95C04FA;
 Wed, 30 Jul 2025 08:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D536C4CEE7;
 Wed, 30 Jul 2025 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753864811;
 bh=XUSplBUZMrx9VWLBtC5rkzHiN5UsP5oB18QNcfT2Kg8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=pEZ8tCpIX7tSdxYjunx3v5XiR0UtrKlhX8NXy9BA+MvnEv974sqEqEWRwSyHraPV9
 24iMZp3/XyR71dWZR5ULXvm+hfuImNnxvIv4pRA6vJRQJyc6/2X02Ul3//f+U2AUHF
 uj96/U/pryHPnOG4WV0iGrzlPWVr6xEQ9Z/8BN1DBdtp1MUZrcOXrvqCtNcBCfO7s9
 xzYbL8QGFyKn/NEACOUTEHcseD8v0OJ1g1CyXCpnL2KaLvKjGEu4YZh1ch11c648O8
 3NN2Vk+ePtG8NKShk0c2a0T46s7yKk3Qeu1LeBp80DkP4u5TRejBs5MR5xRLOTmSJ6
 kGEOur5nbA6tQ==
Message-ID: <1735962b-043d-48b5-b593-d1705ddd4a97@kernel.org>
Date: Wed, 30 Jul 2025 16:40:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250729063326.435167-1-chao@kernel.org>
 <aIjjoBJqYjdNv63m@google.com>
Content-Language: en-US
In-Reply-To: <aIjjoBJqYjdNv63m@google.com>
X-Headers-End: 1uh2MI-0006sO-7O
Subject: Re: [f2fs-dev] [PATCH] f2fs: dump more information when checkpoint
 was blocked for long time
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/29/25 23:07, Jaegeuk Kim wrote:
> On 07/29, Chao Yu wrote:
>> generic/299 w/ mode=lfs will cause long time latency, let's dump more
>> information once we hit case.
>>
>> CP merge:
>>   - Queued :    0
>>   - Issued :    1
>>   - Total :    1
>>   - Cur time : 7565(ms)
>>   - Peak time : 7565(ms)
>>
>> F2FS-fs (vdc): checkpoint was blocked for 7565 ms, affecting 1 tasks
>> CPU: 8 UID: 0 PID: 1614 Comm: f2fs_ckpt-253:3 Tainted: G           O        6.16.0-rc3+ #406 PREEMPT(voluntary)
>> Tainted: [O]=OOT_MODULE
>> Call Trace:
>>  dump_stack_lvl+0x6e/0xa0
>>  __checkpoint_and_complete_reqs+0x1a6/0x1d0
>>  issue_checkpoint_thread+0x4b/0x140
>>  kthread+0x10d/0x250
>>  ret_from_fork+0x164/0x190
>>  ret_from_fork_asm+0x1a/0x30
> 
> Can we add more information for debugging this?

I guess we can add more stats in write_checkpoint() to see which
stage we cost most of the latency.

Thanks,

> 
>>
>> Cc: Jan Prusakowski <jprusakowski@google.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  fs/f2fs/checkpoint.c | 9 ++++++++-
>>  fs/f2fs/f2fs.h       | 3 +++
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index db3831f7f2f5..b0dcaa8dc40d 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1788,8 +1788,15 @@ static void __checkpoint_and_complete_reqs(struct f2fs_sb_info *sbi)
>>  
>>  	spin_lock(&cprc->stat_lock);
>>  	cprc->cur_time = (unsigned int)div64_u64(sum_diff, count);
>> -	if (cprc->peak_time < cprc->cur_time)
>> +	if (cprc->peak_time < cprc->cur_time) {
>>  		cprc->peak_time = cprc->cur_time;
>> +
>> +		if (unlikely(cprc->peak_time >= CP_LONG_LATENCY_THRESHOLD)) {
>> +			f2fs_warn_ratelimited(sbi, "checkpoint was blocked for %u ms, affecting %llu tasks",
>> +					cprc->peak_time, count);
>> +			dump_stack();
>> +		}
>> +	}
>>  	spin_unlock(&cprc->stat_lock);
>>  }
>>  
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 46d23c2c086c..3130ca6a4770 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -350,6 +350,9 @@ struct ckpt_req_control {
>>  	unsigned int peak_time;		/* peak wait time in msec until now */
>>  };
>>  
>> +/* a time threshold that checkpoint was blocked for, unit: ms */
>> +#define CP_LONG_LATENCY_THRESHOLD	5000
>> +
>>  /* for the bitmap indicate blocks to be discarded */
>>  struct discard_entry {
>>  	struct list_head list;	/* list head */
>> -- 
>> 2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
