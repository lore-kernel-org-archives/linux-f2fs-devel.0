Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79BBC48260
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Feb 2024 07:15:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rbxrg-0005CL-G5;
	Mon, 19 Feb 2024 07:15:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rbxre-0005C6-4y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Feb 2024 07:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4SZZb9e9fycDbqPw/6kvATzFOOh1pEdMdFtaFErQ1s4=; b=dMbKOqW1qxgHu5ZKQq51UK9b0w
 EJUcrIlM04nslLA9Jhz9iPV0pLHM9ftSUs+HaX2oGRwV3Uby7NXANyLsflp9wg3yW2KVWc9HeRaa4
 v/4yT4I+mNyyOmqYwModCWsCJlO7xMt5vExajzMYcG2madXo+l8ChzFUJgcvLLJNtcRg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4SZZb9e9fycDbqPw/6kvATzFOOh1pEdMdFtaFErQ1s4=; b=UrLf4iuTc0uWHt15Y56F9NL5tN
 9hwvmEfP5yLCjRukQodVrwf140pZMRP6I/gXIrRrVkQezLzPdU26SmSAeJUoxFHmzxghevgT2zHLu
 cx4BFc+9vz4Lu0+HNRZNkEswHS0Z/lWuTspxWK6Vb6Lj/THOJxBUbQsRcLHd5ya6/oxo=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rbxrY-00072k-Nt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Feb 2024 07:14:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 63C86CE0EE8;
 Mon, 19 Feb 2024 07:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FF6C433F1;
 Mon, 19 Feb 2024 07:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708326886;
 bh=M3JjNo/uMWn6Nt2P8NOEOOPiTVBzyf4oipKYVYsFXnU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tt0hTkjPoLnsVkzH+V49hmlsgqXaVg6qqwJ94VXDq/CZVrjII+Ki3UpoVKoq0FRWI
 klu4NbIdBZS5wXq3IbT4tWxyPOSiyZlwP9MEJCIQDRGLpsjsnjp+dE9+Dcdl8myj40
 NB85xPJH9lMzldzTE8r5zcWSwPSQg6SnofkX4rmgx6UDpXAulv+kCmMjMPBmb9sCBw
 k35HovDEtTS2jIRMjfu6JQa2DbmJTQA2k/DSuX37Jn6Ymgd2Jod9K0bZa1pR4sGfud
 ZCDlAwbE9+CvZNLzWo1koza53KwnmdgiIXPpuPM9HHv/hj6xB9dNwZLcbPs/8QUZHI
 nvHjlfPp801Jw==
Message-ID: <e7d269c8-c3f2-4d86-8ac2-653912880119@kernel.org>
Date: Mon, 19 Feb 2024 15:14:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <1707271264-5551-5-git-send-email-zhiguo.niu@unisoc.com>
 <ZcQdeC4e7rnr9pCr@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZcQdeC4e7rnr9pCr@google.com>
X-Headers-End: 1rbxrY-00072k-Nt
Subject: Re: [f2fs-dev] [PATCH v2 4/4] f2fs: stop checkpoint when get a
 out-of-bounds segment
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
Cc: hongyu.jin@unisoc.com, ke.wang@unisoc.com, niuzhiguo84@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/2/8 8:16, Jaegeuk Kim wrote:
> On 02/07, Zhiguo Niu wrote:
>> There is low probability that an out-of-bounds segment will be got
>> on a small-capacity device. In order to prevent subsequent write requests
>> allocating block address from this invalid segment, which may cause
>> unexpected issue, stop checkpoint should be performed.
>>
>> Also introduce a new stop cp reason:  STOP_CP_REASON_OUTOF_RAGNE.
> 
> OUT_OF_RANGE?

Maybe STOP_CP_REASON_NO_SEGMENT will be more explicit?

Thanks,

> 
>>
>> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
>> ---
>>   fs/f2fs/segment.c       | 12 ++++++++++--
>>   include/linux/f2fs_fs.h |  1 +
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 6772ad4..6fe2baf 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -2666,7 +2666,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   		if (dir == ALLOC_RIGHT) {
>>   			secno = find_first_zero_bit(free_i->free_secmap,
>>   							MAIN_SECS(sbi));
>> -			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
>> +			if (secno >= MAIN_SECS(sbi)) {
>> +				f2fs_stop_checkpoint(sbi, false,
>> +						STOP_CP_REASON_OUTOF_RAGNE);
>> +				f2fs_bug_on(sbi, 1);
>> +			}
>>   		} else {
>>   			go_left = 1;
>>   			left_start = hint - 1;
>> @@ -2682,7 +2686,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>>   		}
>>   		left_start = find_first_zero_bit(free_i->free_secmap,
>>   							MAIN_SECS(sbi));
>> -		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
>> +		if (left_start >= MAIN_SECS(sbi)) {
>> +			f2fs_stop_checkpoint(sbi, false,
>> +					STOP_CP_REASON_OUTOF_RAGNE);
>> +			f2fs_bug_on(sbi, 1);
>> +		}
>>   		break;
>>   	}
>>   	secno = left_start;
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index 053137a0..72c6782 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -81,6 +81,7 @@ enum stop_cp_reason {
>>   	STOP_CP_REASON_CORRUPTED_SUMMARY,
>>   	STOP_CP_REASON_UPDATE_INODE,
>>   	STOP_CP_REASON_FLUSH_FAIL,
>> +	STOP_CP_REASON_OUTOF_RAGNE,
>>   	STOP_CP_REASON_MAX,
>>   };
>>   
>> -- 
>> 1.9.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
