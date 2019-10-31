Return-Path: <SRS0=XOwI=YY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E783CA9EC3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Oct 2019 06:55:27 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29A9C2083E;
	Thu, 31 Oct 2019 06:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GmTQGCkI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="MdvaY3nG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A9C2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iQ4Mg-0004zD-BA; Thu, 31 Oct 2019 06:55:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iQ4Mf-0004z5-0B
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Oct 2019 06:55:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d85h5ohyAnWc1bxo0CSEX0+GkiWhrQIhl4Egr6AIiMw=; b=GmTQGCkIXx0mqqp7CiXo0Oejb/
 XuxwBgT6dxJbQWY4HSX7fkfVDGpPfFnuB4Vac6h4r7hfNQDbY3cLSWd9X+nIxNGFSOv9UGYJLHQxw
 hGSZ8wfG/W8d3ztEhr+ToI2TUa5950u9vIajee+DAIoU+YNhzCT+f8sXOL678kWs7pRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d85h5ohyAnWc1bxo0CSEX0+GkiWhrQIhl4Egr6AIiMw=; b=MdvaY3nG5l/QSIdpEd6jNtFJRU
 que/sAU/sl7OhlWIzc3cqd0Pl1CFBGz7TOdb/sAznK9SsvYJJaqz8DKiOXVGBNJtC/6rVKsyiYZQA
 X5Ox8DutIjgGHVb6CBYqr2cMn98U4ncdQL5xjIs1i/SNFLQtce0p2+3mlF60+BhCmrzg=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iQ4Ma-00C1sW-R6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Oct 2019 06:55:24 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E01DC2C04A56620C2F94;
 Thu, 31 Oct 2019 14:55:12 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 31 Oct
 2019 14:55:07 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20191030035518.65477-1-gaoxiang25@huawei.com>
 <20aa40bd-280d-d223-9f73-d9ed7dbe4f29@huawei.com>
 <20191030091542.GA24976@architecture4>
 <19a417e6-8f0e-564e-bc36-59bfc883ec16@huawei.com>
 <20191030104345.GB170703@architecture4> <20191030151444.GC16197@mit.edu>
 <20191030155020.GA3953@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20191030162243.GA18729@mit.edu>
 <20191030163313.GB34056@jaegeuk-macbookpro.roam.corp.google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <0ef44e01-13a6-2519-bce2-075ca14a0cb9@huawei.com>
Date: Thu, 31 Oct 2019 14:55:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191030163313.GB34056@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iQ4Ma-00C1sW-R6
Subject: Re: [f2fs-dev] [PATCH] f2fs: bio_alloc should never fail
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
Cc: Gao Xiang <hsiangkao@aol.com>, linux-doc@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/10/31 0:33, Jaegeuk Kim wrote:
> On 10/30, Theodore Y. Ts'o wrote:
>> On Wed, Oct 30, 2019 at 11:50:37PM +0800, Gao Xiang wrote:
>>>
>>> So I'm curious about the original issue in commit 740432f83560
>>> ("f2fs: handle failed bio allocation"). Since f2fs manages multiple write
>>> bios with its internal fio but it seems the commit is not helpful to
>>> resolve potential mempool deadlock (I'm confused since no calltrace,
>>> maybe I'm wrong)...
>>
>> Two possibilities come to mind.  (a) It may be that on older kernels
>> (when f2fs is backported to older Board Support Package kernels from
>> the SOC vendors) didn't have the bio_alloc() guarantee, so it was
>> necessary on older kernels, but not on upstream, or (b) it wasn't
>> *actually* possible for bio_alloc() to fail and someone added the
>> error handling in 740432f83560 out of paranoia.
> 
> Yup, I was checking old device kernels but just stopped digging it out.
> Instead, I hesitate to apply this patch since I can't get why we need to
> get rid of this code for clean-up purpose. This may be able to bring
> some hassles when backporting to android/device kernels.

Jaegeuk,

IIUC, as getting hint from commit 740432f83560, are we trying to fix potential
deadlock like this?

In low memory scenario:

- f2fs_write_checkpoint()
 - block_operations()
  - f2fs_sync_node_pages()
   step 1) flush cold nodes, allocate new bio from mempool
   - bio_alloc()
    - mempool_alloc()
   step 2) flush hot nodes, allocate a bio from mempool
   - bio_alloc()
    - mempool_alloc()
   step 3) flush warm nodes, be stuck in below call path
   - bio_alloc()
    - mempool_alloc()
     - loop to wait mempool element release, as we only
       reserved memory for two bio allocation, however above
       allocated two bios never getting submitted.

#define BIO_POOL_SIZE 2

If so, we need avoid using bioset, or introducing private bioset, at least
enlarging mempool size to three (adapt to total log headers' number)...

Thanks,

> 
>>
>> (Hence my suggestion that in the ext4 version of the patch, we add a
>> code comment justifying why there was no error checking, to make it
>> clear that this was a deliberate choice.  :-)
>>
>> 						- Ted
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
