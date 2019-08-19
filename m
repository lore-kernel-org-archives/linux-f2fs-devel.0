Return-Path: <SRS0=dby8=WP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AB2C3A589
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Aug 2019 01:58:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 862662184D;
	Mon, 19 Aug 2019 01:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Z67lXkLr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="EkY35f9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862662184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hzWwe-0007wX-5h; Mon, 19 Aug 2019 01:58:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hzWwY-0007wK-Mq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Aug 2019 01:58:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:References:CC:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RnKvmQm75hVNbRqvH5EklqYTQw6zrTut5qn4tfvEYu4=; b=Z67lXkLrVUrPx2CzO4dbNLIkQL
 q5euatwC+WcjFam0NgU7ipGPDKGf+uwBGWlUcMlRgb36TLzgyVvL82QldAz1LNsKLPvSlSjpAa14c
 23fITgL55x14T+nxBh6R2zv0W4aViEv8Pz6nGaGli3S0eVTy3Jees8c3qWDwW9iu8/WQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:References:CC:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RnKvmQm75hVNbRqvH5EklqYTQw6zrTut5qn4tfvEYu4=; b=EkY35f9kVi3nzbpOEj4sRL6q/3
 YcQcWz5GHQwBHGBWvuq/uRr94rYvuAXS83SraGzesGTWWoN2tV/0m3NA45e2hPAnJpj345C2zX8Nz
 iPePvptSpFGFuAAFEl/JVeP+mWtJ5zGPDdlQed/1PGCKdjCmR91D7DeB3Kz7zdViM+M0=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hzWwW-00BFBA-JW
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 19 Aug 2019 01:58:46 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0C9D62332331882FFBA6;
 Mon, 19 Aug 2019 09:58:37 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 19 Aug
 2019 09:58:31 +0800
From: Chao Yu <yuchao0@huawei.com>
To: Eric Biggers <ebiggers@kernel.org>
References: <20190816055539.30420-1-ebiggers@kernel.org>
 <20190816055539.30420-3-ebiggers@kernel.org>
 <d6022f8b-2d75-4e9d-882e-038551684c37@huawei.com>
 <20190818154138.GA1118@sol.localdomain>
 <3f3fa304-2ce0-7773-7335-30f8e3c5b5d5@huawei.com>
Message-ID: <808dc7d9-01c3-7883-431a-8f3532adec09@huawei.com>
Date: Mon, 19 Aug 2019 09:58:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3f3fa304-2ce0-7773-7335-30f8e3c5b5d5@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1hzWwW-00BFBA-JW
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: fix copying too many bytes in
 FS_IOC_SETFSLABEL
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/8/19 9:33, Chao Yu wrote:
> On 2019/8/18 23:41, Eric Biggers wrote:
>> On Fri, Aug 16, 2019 at 02:59:37PM +0800, Chao Yu wrote:
>>> On 2019/8/16 13:55, Eric Biggers wrote:
>>>> From: Eric Biggers <ebiggers@google.com>
>>>>
>>>> Userspace provides a null-terminated string, so don't assume that the
>>>> full FSLABEL_MAX bytes can always be copied.>
>>>> Fixes: 61a3da4d5ef8 ("f2fs: support FS_IOC_{GET,SET}FSLABEL")
>>>
>>> It may only copy redundant zero bytes, and will not hit security issue, it
>>> doesn't look like a bug fix?
>>>
>>>> Signed-off-by: Eric Biggers <ebiggers@google.com>
>>>
>>> Anyway, it makes sense to me.
>>>
>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>
>>
>> It's not clear that userspace is guaranteed to provide a full FSLABEL_MAX bytes
>> in the buffer.  E.g. it could provide "foo\0" followed by an unmapped page.
> 
> You're right, thanks for your explanation.

One more question, there is no validation check on length of user passed buffer,

So in most ioctl interfaces, user can pass a buffer which has less size than we
defined intentionally/unintentionally.

E.g.

user space:

struct f2fs_defragment_user {
	unsigned long long start;
//	unsigned long long len;
};

main()
{
	struct f2fs_defragment_user *df;

	df = malloc();
	
	ioctl(fd, F2FS_IOC_DEFRAGMENT, df);
}

kernel:

f2fs_ioc_defragment()
{
...
	if (copy_from_user(&range, (struct f2fs_defragment __user *)arg,
							sizeof(range)))
		return -EFAULT;
}

Is that a common issue?

Thanks,

> 
> Thanks,
> 
>>
>> - Eric
>> .
>>
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
