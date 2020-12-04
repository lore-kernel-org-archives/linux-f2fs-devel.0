Return-Path: <SRS0=i1FA=FI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099CEC4361A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Dec 2020 03:11:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E00F22513;
	Fri,  4 Dec 2020 03:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E00F22513
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kl1VL-0008Lh-B6; Fri, 04 Dec 2020 03:11:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kl1VJ-0008LU-KG
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Dec 2020 03:11:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IvcSN4DPV3csbHkpoZlR/2GP90MH+nU0s4LpdykTJoU=; b=AJjNLMfPJWTKQFNO/hru93YULN
 MVv844TABImjhc6CZUxLMwrU755g9liS5L9NeBZr9qaaMfBXZNqyOgJohHJ9Eqy4W/NmeSQqmB5un
 10RqM+HzY2axdCVawoEP+4NPFv5NE9ZptvqJhVyu6fZ9FxAAO4cSPq+g9Daq5y1a5Los=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IvcSN4DPV3csbHkpoZlR/2GP90MH+nU0s4LpdykTJoU=; b=UfAtNiqPatRneUkd7GDlCElji1
 8qrXN/Y00u1fuXEiHAWUZkVI8zf0KgQM5bf9QGWm7WXui4Cq53rc7GA/lmcT+OfbV/N19DhEXth4a
 ojtTuU4eIUE+Jy7bpZDRd8OUlfphgHesns3b0e8iBqFUpAczH+AczQNNA7JJ16foZ1XM=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kl1VB-00EMTu-Dw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Dec 2020 03:11:29 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnHlG3KL7zkkj7;
 Fri,  4 Dec 2020 11:10:34 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 4 Dec 2020
 11:11:04 +0800
To: Gao Xiang <hsiangkao@redhat.com>
References: <20201203061715.60447-1-yuchao0@huawei.com>
 <X8k9UoUKcyThlJNU@gmail.com> <20201204003119.GA1957051@xiangao.remote.csb>
 <7b975d1a-a06c-4e14-067e-064afc200934@huawei.com>
 <20201204020659.GB1963435@xiangao.remote.csb>
 <3041968d-87d0-d2dc-822b-0bb4a94a365b@huawei.com>
 <20201204024746.GC1963435@xiangao.remote.csb>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <15afffcc-636d-b678-0c01-b2fad98d9311@huawei.com>
Date: Fri, 4 Dec 2020 11:11:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201204024746.GC1963435@xiangao.remote.csb>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kl1VB-00EMTu-Dw
Subject: Re: [f2fs-dev] [PATCH v6] f2fs: compress: support compress level
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
Cc: Eric Biggers <ebiggers@kernel.org>, jaegeuk@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/12/4 10:47, Gao Xiang wrote:
> On Fri, Dec 04, 2020 at 10:38:08AM +0800, Chao Yu wrote:
>> On 2020/12/4 10:06, Gao Xiang wrote:
>>> On Fri, Dec 04, 2020 at 09:56:27AM +0800, Chao Yu wrote:
> 
> ...
> 
>>
>>>
>>> Keep lz4hc dirty data under writeback could block writeback, make kswapd
>>> busy, and direct memory reclaim path, I guess that's why rare online
>>> compression chooses it. My own premature suggestion is that it'd better
>>> to show the CR or performance benefits in advance, and prevent unprivileged
>>> users from using high-level lz4hc algorithm (to avoid potential system attack.)
>>> either from mount options or ioctl.
>>
>> Yes, I guess you are worry about destop/server scenario, as for android scenario,
>> all compression related flow can be customized, and I don't think we will use
>> online lz4hc compress; for other scenario, except the numbers, I need to add the
>> risk of using lz4hc algorithm in document.
> 
> Yes, I was saying the general scenario. My overall premature thought is that
> before releasing some brand new algorithm, it may be better to evaluate first
> it'd benefit to some scenarios first (either on CR or performance side, or
> why adding this?), or it would might cause lzo-rle likewise situation in the

Yeah, got your point.

> future (and add more dependency to algorithms, you might see BWT-based bzip2
> removal patch

Oops, is that really allowed? I don't this is a good idea...and I don't see there
are deletions from fs/ due to similar reason...

Thanks,

> https://lore.kernel.org/r/20201117223253.65920-1-alex_y_xu@yahoo.ca
> (since I personally don't think BWT is a good algorithm as well)... Just FYI
> ... If i'm wrong, kindly ignore me :)
> 
> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
> 
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
