Return-Path: <SRS0=jCLE=EQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F03C388F7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Nov 2020 06:05:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636FE206C0;
	Tue, 10 Nov 2020 06:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Q+XNyjyQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="F2IFDr70"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636FE206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kcMm5-00075G-3G; Tue, 10 Nov 2020 06:05:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kcMm4-000759-1r
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Nov 2020 06:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eIagXMTPe/jAwt8l1Gnu91FC1PPUjoOI3WSRUQ397lM=; b=Q+XNyjyQEo30MIUWxD5ZUshTKz
 FcVMltkUZ/KS3ZSGjKb0OizmMwngU6LtQA7GtB+TiHZ5TGoNKCgBQ6Ig/c71Z8olp3omkf2YyAVOt
 hRfwohDYsJQwggputTa4P3xP3tSgdWoQ+n1QmPezAnhRW95KGzWmTfx9RdZneeqMmg/w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eIagXMTPe/jAwt8l1Gnu91FC1PPUjoOI3WSRUQ397lM=; b=F2IFDr70sCbPTnmCGR/xQAqr3p
 J9o5ehYhZGdNLb8MxCnUktqpKQOEfDGHPl6dG0OHnYjHnRg/wsx7AaIWhYvC2W/acIyz18f2eu6jc
 t2AZORXpT++wcwvalnA62ZQRzmpzaDol7Dajtc4uPzjamZJ3cTamdvw6SObXl7Le/4YA=;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kcMlp-006O6O-SB
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Nov 2020 06:04:59 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CVckq1blLz74mH;
 Tue, 10 Nov 2020 14:04:19 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 10 Nov
 2020 14:04:22 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20201109170012.2129411-1-jaegeuk@kernel.org>
 <f195a4f0-34af-1594-f443-be8ba3058707@huawei.com>
 <20201110041958.GA1598246@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <f8de28c2-da2f-f988-7fc9-6f38f19f3f41@huawei.com>
Date: Tue, 10 Nov 2020 14:04:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201110041958.GA1598246@google.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kcMlp-006O6O-SB
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid race condition for shinker count
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 Light Hsieh <Light.Hsieh@mediatek.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/11/10 12:19, Jaegeuk Kim wrote:
> On 11/10, Chao Yu wrote:
>> On 2020/11/10 1:00, Jaegeuk Kim wrote:
>>> Light reported sometimes shinker gets nat_cnt < dirty_nat_cnt resulting in
>>
>> I didn't get the problem clearly, did you mean __count_nat_entries() will
>> give the wrong shrink count due to race condition? should there be a lock
>> while reading these two variables?
>>
>>> wrong do_shinker work. Basically the two counts should not happen like that.
>>>
>>> So, I suspect this race condtion where:
>>> - f2fs_try_to_free_nats            __flush_nat_entry_set
>>>    nat_cnt=2, dirty_nat_cnt=2
>>>                                      __clear_nat_cache_dirty
>>>                                       spin_lock(nat_list_lock)
>>>                                       list_move()
>>>                                       spin_unlock(nat_list_lock)
>>>    spin_lock(nat_list_lock)
>>>    list_del()
>>>    spin_unlock(nat_list_lock)
>>>    nat_cnt=1, dirty_nat_cnt=2
>>>                                      nat_cnt=1, dirty_nat_cnt=1
>>
>> nm_i->nat_cnt and nm_i->dirty_nat_cnt were protected by
>> nm_i->nat_tree_lock, I didn't see why expanding nat_list_lock range
>> will help... since there are still places nat_list_lock() didn't
>> cover these two reference counts.
> 
> Yeah, I missed nat_tree_lock, and indeed it should cover this. So, the problem
> is Light reported subtle case of nat_cnt < dirty_nat_cnt in shrink_count.
> We may need to use nat_tree_lock in shrink_count?

change like this?

__count_nat_entries()

	down_read(&nm_i->nat_tree_lock);
	count = NM_I(sbi)->nat_cnt - NM_I(sbi)->dirty_nat_cnt;
	up_read(&nm_i->nat_tree_lock);

Thanks,

> 
>>
>> Thanks,
>>
>>>
>>> Reported-by: Light Hsieh <Light.Hsieh@mediatek.com>
>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>> ---
>>>    fs/f2fs/node.c | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>>> index 42394de6c7eb..e8ec65e40f06 100644
>>> --- a/fs/f2fs/node.c
>>> +++ b/fs/f2fs/node.c
>>> @@ -269,11 +269,10 @@ static void __clear_nat_cache_dirty(struct f2fs_nm_info *nm_i,
>>>    {
>>>    	spin_lock(&nm_i->nat_list_lock);
>>>    	list_move_tail(&ne->list, &nm_i->nat_entries);
>>> -	spin_unlock(&nm_i->nat_list_lock);
>>> -
>>>    	set_nat_flag(ne, IS_DIRTY, false);
>>>    	set->entry_cnt--;
>>>    	nm_i->dirty_nat_cnt--;
>>> +	spin_unlock(&nm_i->nat_list_lock);
>>>    }
>>>    static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
>>>
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
