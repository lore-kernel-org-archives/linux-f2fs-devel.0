Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84CAC43334
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jun 2022 14:02:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o40wM-0005Zq-0N; Wed, 22 Jun 2022 14:02:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o40wL-0005Zk-6r
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 14:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BVRyrf7vp6umDEneEQEGuoAw74fr08/qiqVCSAEKJJE=; b=ZL4RRzzW065kieHWdSBraY0ael
 HyklkAxF9X76/5BcMItm+Es23CNVv/ymR6oEjBWd+8ayT6EkWDM1XdrCJnG67sZOWMIy0mHK7Weh9
 iZxu4FKQFtPBVQyU9D6zLf3AyEXG35dZsJAfZyUrE7tfdmOKePu8vYzMf/0wSKmO4s8k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BVRyrf7vp6umDEneEQEGuoAw74fr08/qiqVCSAEKJJE=; b=fquauPzqStqmH2GKjw5tWnlTh0
 NDlL/fZinP09uNYfFYpTjWzB8PEDuU3DkC2HWNzWotPvPDs1nWFUR7FGiFa254whYmxsVAhADTfcL
 HFvzy+eSwsfncqDv9OuzIh7fc1en8LUgSZvogzttd2vTlXEzsp0N/IN5Gx3pAJJRP+gM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o40wI-00AMY7-4M
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 14:02:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id BFF5D61B71
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 22 Jun 2022 14:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC39C34114;
 Wed, 22 Jun 2022 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655906552;
 bh=KEOm3rqgaJaCmSIo+v3zlFCOBXMloNPUc4mYcPiUjvs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YsKY7PMMvAMkQcB6CXNeZ7Dxe7ZU63lsuH14tVjVBSMHEoe4IkDbDAaxcAmuguGMN
 XMdnBBWgBAGYVfSduxSeMx+zkEjLBZcRNvkpTgQRVRV/oJ9pe3OXTqeCJ+n4wb4VBl
 ovSsGH076r3gb8iriy1hGUl4aeYFYOMRR/5MuI28gbkXEDvCYMlP3DSPGz+UF4X7VM
 R0hmn+xGyV1GIeRaljyF/yFrlexeO3/YhffbJVkuqnfvEohQEvCZtgfrQp8dE36GwW
 Bsy69qhxnpyhaHkDU13KLPMdWVRgTE87ArWEP6xgh3VOaYjVlPN2eQViDix1NTYab2
 c3wd6fgimRg7w==
Message-ID: <27138a10-a6b2-edad-1985-687a95b9039b@kernel.org>
Date: Wed, 22 Jun 2022 22:02:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220617223106.3517374-1-jaegeuk@kernel.org>
 <20220617223106.3517374-2-jaegeuk@kernel.org>
 <c45a9c8b-c73a-76bc-6725-5d7e48e7a3f2@kernel.org>
 <Yq+kiXPyBsXgdYb2@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Yq+kiXPyBsXgdYb2@google.com>
X-Headers-End: 1o40wI-00AMY7-4M
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: run GCs synchronously given user
 requests
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/20 6:34, Jaegeuk Kim wrote:
> On 06/19, Chao Yu wrote:
>> On 2022/6/18 6:31, Jaegeuk Kim wrote:
>>> When users set GC_URGENT or GC_MID, they expected to do GCs right away.
>>> But, there's a condition to bypass it. Let's indicate we need to do now
>>> in the thread.
>>
>> .should_migrate_blocks is used to force migrating blocks in full
>> section, so what is the condition here? GC should not never select
>> a full section, right?
> 
> I think it'll move a full section given .victim_segno is not NULL_SEGNO,
> as __get_victim will give a dirty segment all the time. wdyt?

However, in gc_thread_fun() victim_segno is NULL_SEGNO all the time.

I guess .should_migrate_blocks should only be set to true for
F2FS_IOC_FLUSH_DEVICE/F2FS_IOC_RESIZE_FS case? rather than GC_URGENT or GC_MID
case? See commit 7dede88659df ("f2fs: fix to allow migrating fully valid segment").

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/gc.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>>> index d5fb426e0747..f4aa3c88118b 100644
>>> --- a/fs/f2fs/gc.c
>>> +++ b/fs/f2fs/gc.c
>>> @@ -37,7 +37,6 @@ static int gc_thread_func(void *data)
>>>    	unsigned int wait_ms;
>>>    	struct f2fs_gc_control gc_control = {
>>>    		.victim_segno = NULL_SEGNO,
>>> -		.should_migrate_blocks = false,
>>>    		.err_gc_skipped = false };
>>>    	wait_ms = gc_th->min_sleep_time;
>>> @@ -113,7 +112,10 @@ static int gc_thread_func(void *data)
>>>    				sbi->gc_mode == GC_URGENT_MID) {
>>>    			wait_ms = gc_th->urgent_sleep_time;
>>>    			f2fs_down_write(&sbi->gc_lock);
>>> +			gc_control.should_migrate_blocks = true;
>>>    			goto do_gc;
>>> +		} else {
>>> +			gc_control.should_migrate_blocks = false;
>>>    		}
>>>    		if (foreground) {
>>> @@ -139,7 +141,9 @@ static int gc_thread_func(void *data)
>>>    		if (!foreground)
>>>    			stat_inc_bggc_count(sbi->stat_info);
>>> -		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC;
>>> +		sync_mode = F2FS_OPTION(sbi).bggc_mode == BGGC_MODE_SYNC ||
>>> +				sbi->gc_mode == GC_URGENT_HIGH ||
>>> +				sbi->gc_mode == GC_URGENT_MID;
>>>    		/* foreground GC was been triggered via f2fs_balance_fs() */
>>>    		if (foreground)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
