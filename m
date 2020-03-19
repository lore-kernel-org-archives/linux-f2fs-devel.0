Return-Path: <SRS0=57LO=5E=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64565C4332B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:37:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E5620768
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2020 02:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="B/XAo3IF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="DlWthTYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E5620768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jEl3o-0001mI-Qy; Thu, 19 Mar 2020 02:37:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jEl3n-0001m5-Of
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 02:37:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rA9A7+oDBZw1gVo7OjOl/6Q6sHkbxSPtFtiwft3+qxI=; b=B/XAo3IFtmeFTU8ZvTpGXBAu2p
 +9MW1tk/BYBBNFHNRo2zdfUIoMjoClScAMQTPI4cdKMy/cLclzkBbklBSBaPtNAKefPyLhcmFz58o
 lnSWSaGM/pPBbcsoXMNq5ZOR40e3qeIuQ54YyVQfmeS42ZB5TaDhIxTHBFnld3M+6kJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rA9A7+oDBZw1gVo7OjOl/6Q6sHkbxSPtFtiwft3+qxI=; b=DlWthTYPdq2fHhOrpZuNf3X0O3
 VzIW5zUpSfhXeDncGJropu1LMzEe9gEwwYKiowwTnYFyFN776CNKyebZDFbqnxLS4Q2UBfiB1Ybze
 8A1PNFc8EDvdgM/6U26Khw0JPN9RmC4oApZ3LGoypveB0i1MNn0jFx36qbCgGfdm8Lj8=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jEl3h-00Dlew-QF
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Mar 2020 02:37:27 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 485D598D51686BB0ABD9;
 Thu, 19 Mar 2020 10:37:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 19 Mar
 2020 10:37:07 +0800
To: Ju Hyung Park <qkrwngud825@gmail.com>
References: <20200225101710.40123-1-yuchao0@huawei.com>
 <CAD14+f3pi331-V0gzjtxcMRVaEn3tPacrC20wtRq9+6JY9_HVA@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <08d03473-9871-ba10-4626-58c4479ef9d1@huawei.com>
Date: Thu, 19 Mar 2020 10:37:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAD14+f3pi331-V0gzjtxcMRVaEn3tPacrC20wtRq9+6JY9_HVA@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jEl3h-00Dlew-QF
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: use kmem_cache pool during inline
 xattr lookups
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Ju Hyung,

On 2020/3/18 20:14, Ju Hyung Park wrote:
> Hi Chao.
> 
> I got the time around to test this patch.
> The v2 patch seems to work just fine, and the code looks good.

Thanks a lot for the review and test.

> 
> On Tue, Feb 25, 2020 at 7:17 PM Chao Yu <yuchao0@huawei.com> wrote:
>> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
>> index a3360a97e624..e46a10eb0e42 100644
>> --- a/fs/f2fs/xattr.c
>> +++ b/fs/f2fs/xattr.c
>> @@ -23,6 +23,25 @@
>>  #include "xattr.h"
>>  #include "segment.h"
>>
>> +static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
>> +{
>> +       *is_inline = (size == sbi->inline_xattr_slab_size);
> 
> Would it be meaningless to change this to the following code?
> if (likely(size == sbi->inline_xattr_slab_size))
>     *is_inline = true;
> else
>     *is_inline = false;

Yup, I guess it's very rare that user will change inline xattr size via remount,
so I'm okay with this change.

Jaegeuk,

Could you please help to update the patch in your git tree directly?

Thanks,

> 
> The above statement seems to be only false during the initial mount
> and the rest(millions) seems to be always true.
> 
> Thanks.
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
