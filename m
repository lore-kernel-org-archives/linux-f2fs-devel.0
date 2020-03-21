Return-Path: <SRS0=RYwi=5G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548A7C4332B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:17:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 285A320722;
	Sat, 21 Mar 2020 12:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jWqfnRTj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="nK+cga22";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOXPr9Vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 285A320722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jFd3u-0000BS-Ob; Sat, 21 Mar 2020 12:17:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1jFd3u-0000BK-69
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Mar 2020 12:17:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pcCt7t1+BuhTA3mRENclkU3KOY5KNapbZVG+fFxvPXA=; b=jWqfnRTjBpydzGQEqvBFWa0646
 AorSVBlX0IRgZZFeH41ukPyfMLR/r6uVzpU2ECCcYJ6y6AydvOalcvQgiR5Waaft5Q/yI1fuWqyUd
 aCbeGzD5Ke4ZCKP0BhTt25wrO3W5dwFAoUadTUxpsAPAskULQfwgeNH+aSl3R8jBl99M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pcCt7t1+BuhTA3mRENclkU3KOY5KNapbZVG+fFxvPXA=; b=nK+cga22e39eyJ5raASHq2+M3K
 q6oxmGXnORHi8PW4emuk3s7JB/YcKAGcv6KS90xpRTzvrkwX7/t6EoGAd2tuYVMZEfIOxrSjbrl2a
 IQcRuF5h6kyD+02KMUoz+L16uJu+OhY2K4Gbx5oRpCGCL8d1+xBKfIhG2BT2Utqr1418=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jFd3s-002OoY-ER
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Mar 2020 12:17:10 +0000
Received: from [192.168.0.107] (unknown [49.65.245.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8486120757;
 Sat, 21 Mar 2020 12:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584793022;
 bh=F+kqJs1UV3lFH0p9XsOZOQTFoUy/Hn0KUq/CmPvR7wU=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=SOXPr9VoGGVo6hDy+Nniv1abMx8LgRIyU9uX8lSHxeoh6JMWENZQW0MUIAgsnxCiF
 LNQj5FAWTV2DUcfpM9xkN5gfxc5+J3CPNrrBuDtqe99P9jS4O6RHWd1cjDCpI6UUBz
 drUdKH+SMIujnKKDpDsiVILV+rKn//fORVWQsPhc=
To: Eric Biggers <ebiggers@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <20200319115800.108926-1-yuchao0@huawei.com>
 <20200319115800.108926-3-yuchao0@huawei.com>
 <20200320191149.GL851@sol.localdomain>
From: Chao Yu <chao@kernel.org>
Message-ID: <915e56c1-3e87-ef0a-8bdf-26a3774b0a18@kernel.org>
Date: Sat, 21 Mar 2020 20:16:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200320191149.GL851@sol.localdomain>
X-Headers-End: 1jFd3s-002OoY-ER
Subject: Re: [f2fs-dev] [PATCH 3/4] f2fs: fix NULL pointer dereference in
 f2fs_verity_work()
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020-3-21 3:11, Eric Biggers wrote:
> On Thu, Mar 19, 2020 at 07:57:59PM +0800, Chao Yu wrote:
>> If both compression and fsverity feature is on, generic/572 will
>> report below NULL pointer dereference bug.
>>
>>  BUG: kernel NULL pointer dereference, address: 0000000000000018
>>  RIP: 0010:f2fs_verity_work+0x60/0x90 [f2fs]
>>  #PF: supervisor read access in kernel mode
>>  Workqueue: fsverity_read_queue f2fs_verity_work [f2fs]
>>  RIP: 0010:f2fs_verity_work+0x60/0x90 [f2fs]
>>  Call Trace:
>>   process_one_work+0x16c/0x3f0
>>   worker_thread+0x4c/0x440
>>   ? rescuer_thread+0x350/0x350
>>   kthread+0xf8/0x130
>>   ? kthread_unpark+0x70/0x70
>>   ret_from_fork+0x35/0x40
>>
>> There are two issue in f2fs_verity_work():
>> - it needs to traverse and verify all pages in bio.
>> - if pages in bio belong to non-compressed cluster, accessing
>> decompress IO context stored in page private will cause NULL
>> pointer dereference.
>>
>> Fix them.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/data.c | 35 ++++++++++++++++++++++++++++++-----
>>  1 file changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>> index 5c5db09324b7..66e49fc1056e 100644
>> --- a/fs/f2fs/data.c
>> +++ b/fs/f2fs/data.c
>> @@ -187,12 +187,37 @@ static void f2fs_verify_pages(struct page **rpages, unsigned int cluster_size)
>>
>>  static void f2fs_verify_bio(struct bio *bio)
>>  {
>> -	struct page *page = bio_first_page_all(bio);
>> -	struct decompress_io_ctx *dic =
>> -			(struct decompress_io_ctx *)page_private(page);
>> +	struct bio_vec *bv;
>> +	struct bvec_iter_all iter_all;
>> +	struct decompress_io_ctx *dic, *pdic = NULL;
>> +
>> +	bio_for_each_segment_all(bv, bio, iter_all) {
>> +		struct page *page = bv->bv_page;
>> +
>> +		dic = (struct decompress_io_ctx *)page_private(page);
>> +
>> +		if (dic) {
>> +			if (dic != pdic) {
>> +				f2fs_verify_pages(dic->rpages,
>> +							dic->cluster_size);
>> +				f2fs_free_dic(dic);
>> +				pdic = dic;
>> +			}
>> +			continue;
>> +		}
>> +		pdic = dic;
>>
>> -	f2fs_verify_pages(dic->rpages, dic->cluster_size);
>> -	f2fs_free_dic(dic);
>> +		if (bio->bi_status || PageError(page)) {
>> +			ClearPageUptodate(page);
>> +			ClearPageError(page);
>> +		} else {
>> +			if (fsverity_verify_page(page))
>> +				SetPageUptodate(page);
>> +			else
>> +				SetPageError(page);
>> +		}
>> +		unlock_page(page);
>> +	}
>
> I'm a bit confused why you added SetPageError() before unlocking the page.
> The other error paths actually clear the Error flag, not set it.  I thought
> there's a reason for that?

These codes were copy&paste from f2fs_decompress_end_io(), I guess I missed to 
check that logic, so anyway, we need another patch to fix that first.

Thanks for pointing out this.

Thanks,

>
> - Eric
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
