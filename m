Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7E8C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Jan 2022 15:05:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n4lNm-0003Ol-Lm; Tue, 04 Jan 2022 15:05:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1n4lNm-0003Oa-0E
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jan 2022 15:05:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cl9H0JaT6Ppi1evFxk70wUgYxn27995NsfRKoxnJikc=; b=GKfVmjAi19Sm4/Vm1XX5tyU5GO
 ahEf1gEYWbV3mCqGn8OVt0v9esHXGs2b/CoT1Ew0yEmDiG9kGFcBqjbrsM4Yat/3HQcdlbERSvC8q
 mR9FONyd3tspObOIe1lZq1P2c++NfesApDdYbN/DEfCCVEwahlKcsR3rBoXXLHTm3Xxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Cl9H0JaT6Ppi1evFxk70wUgYxn27995NsfRKoxnJikc=; b=U1ZzPEZH9zRukb13tdE1jX3xaY
 Uo1qwaKyt5aXogOf6z6ZaCrNMWiY1bCrbHrtCIqsKsqoMZ8jDRKhOeqeqL4wcFxwt2RGMEN7EB/+y
 gjKpUPZ3R7k30OdOh+9KxJJP51mbchQGmL7ccrMymIGmbQHzU3JJPyo/fNuqWh03pRFo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n4lNi-001ykr-I5
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 04 Jan 2022 15:05:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 296A0614BE;
 Tue,  4 Jan 2022 15:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC5DC36AED;
 Tue,  4 Jan 2022 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641308740;
 bh=B/c0IWqF9m3wlkDteeFI4hCTckOKl6J0UF5o25DV8qI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=KOojAKSTK2NvmHnSI4QfmzhdRy/Y7DjVvvuXHkQbJNuxkzq+R/9s4rFk7A8MO0aVc
 xFWm5rY3UbiBpOPwsnxY3rwS3cnXVPh53UOhsXPL+CkX2wxLufOv9vnrMjuQP/DdHD
 baZtrociqwMgjPE3fumuGNrHh5wjBMz4mBgVcMn9LyF/htsMDfMmrn7xvGX44vNaOn
 eAX9e+yPDhXQ7adY96m0Nw923KyP+JCjT4fIGUVmmo7jcm1KDeR66BP4DEuDJq3LJT
 0j2t7hxSjXTtwmOJKQRLU5pd4U8sNsFaePG+k+NfEZtq9VKM41ohEiYQ/gxHKAdVM7
 GNhuejR2GArdg==
Message-ID: <53d75d26-2289-a66a-a7fa-62593bad81c8@kernel.org>
Date: Tue, 4 Jan 2022 23:05:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
References: <20220104130513.3077-1-chao@kernel.org>
 <YdRJEBhSg8vlD6cP@kroah.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <YdRJEBhSg8vlD6cP@kroah.com>
X-Headers-End: 1n4lNi-001ykr-I5
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix potential deadlock
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
Cc: jaegeuk@kernel.org, Yi Zhuang <zhuangyi1@huawei.com>,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/1/4 21:18, Greg KH wrote:
> On Tue, Jan 04, 2022 at 09:05:13PM +0800, Chao Yu wrote:
>> commit a5c0042200b28fff3bde6fa128ddeaef97990f8d upstream.
>>
>> As Yi Zhuang reported in bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=214299
>>
>> There is potential deadlock during quota data flush as below:
>>
>> Thread A:			Thread B:
>> f2fs_dquot_acquire
>> down_read(&sbi->quota_sem)
>> 				f2fs_write_checkpoint
>> 				block_operations
>> 				f2fs_look_all
>> 				down_write(&sbi->cp_rwsem)
>> f2fs_quota_write
>> f2fs_write_begin
>> __do_map_lock
>> f2fs_lock_op
>> down_read(&sbi->cp_rwsem)
>> 				__need_flush_qutoa
>> 				down_write(&sbi->quota_sem)
>>
>> This patch changes block_operations() to use trylock, if it fails,
>> it means there is potential quota data updater, in this condition,
>> let's flush quota data first and then trylock again to check dirty
>> status of quota data.
>>
>> The side effect is: in heavy race condition (e.g. multi quota data
>> upaters vs quota data flusher), it may decrease the probability of
>> synchronizing quota data successfully in checkpoint() due to limited
>> retry time of quota flush.
>>
>> Fixes: db6ec53b7e03 ("f2fs: add a rw_sem to cover quota flag changes")
>> Cc: stable@vger.kernel.org # v5.3+
>> Reported-by: Yi Zhuang <zhuangyi1@huawei.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> ---
>>   fs/f2fs/checkpoint.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 83e9bc0f91ff..7b0282724231 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1162,7 +1162,8 @@ static bool __need_flush_quota(struct f2fs_sb_info *sbi)
>>   	if (!is_journalled_quota(sbi))
>>   		return false;
>>   
>> -	down_write(&sbi->quota_sem);
>> +	if (!down_write_trylock(&sbi->quota_sem))
>> +		return true;
>>   	if (is_sbi_flag_set(sbi, SBI_QUOTA_SKIP_FLUSH)) {
>>   		ret = false;
>>   	} else if (is_sbi_flag_set(sbi, SBI_QUOTA_NEED_REPAIR)) {
>> -- 
>> 2.32.0
>>
> 
> What stable tree(s) is this for?

Oh, please help to try applying to 5.4, 5.10, and 5.15 stable trees, thanks!

Let me know if I should send patches for different trees separately.

Thanks,

> 
> thanks,
> 
> greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
