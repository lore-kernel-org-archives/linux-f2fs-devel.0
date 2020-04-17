Return-Path: <SRS0=v7FB=6B=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A74AC38A2C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Apr 2020 16:15:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 430652072D;
	Fri, 17 Apr 2020 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eSzysIn7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="nUUgmpTV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKJgxUHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430652072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jPTeK-0003mL-Tk; Fri, 17 Apr 2020 16:15:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jPTeJ-0003m6-5c
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Apr 2020 16:15:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2qQAiOb2aaHrFf6S7LJOoBEzXYCCXknIhOcX2pGcpl8=; b=eSzysIn7WQE51lVMRjBlS70O5p
 eyOGH9KqcfqBmSPJwWSNqhkrATsfav39sdYtFUIOmIbk0eufip39tl0eTH9Vf5ihtO/E9+HxChB77
 uz/9siCKC2oxrmUalRdIoEGK+62gOroW5Rm7faxPRL800EPbgPV5ilevIfnDdPpTmm1E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2qQAiOb2aaHrFf6S7LJOoBEzXYCCXknIhOcX2pGcpl8=; b=nUUgmpTVBgkpYC7+BVw/l+3ZQ8
 MCzTmvTV+NNUYYKZPNPrAIPfUQh9NiZHk+dK5aVkq0DZK/rv1ZDOcbrUEEnZsX3O1J4jSZTiaFUT5
 kTBUmlCztyKAPEyt5T65crPC64RCPPQJ1da2GU7zOubhemeVD90cx0iPq/RcUthf+ssA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jPTeE-005TR7-OL
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Apr 2020 16:15:27 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1DF672072D;
 Fri, 17 Apr 2020 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587140117;
 bh=ECCfbaSoEBEJ6WvTW36xUahNJiM0dMQr/S7euQZ88dw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AKJgxUHT9WLUQmTCNTg45NPovpnw3Zz+WXdmnua4zbrQuym9O5pYzYViZrtEaOwIJ
 lgaLTU2oB/a8gRFrCD2mLR4aor/SqW1qEQg+EN3aMGtDILQhgawWD7PWB/DW6O1cjO
 t4DLlGphDdhHzG+O9w0awnT2jYVYQo9OEwThD2Ws=
Date: Fri, 17 Apr 2020 09:15:16 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200417161516.GA17901@google.com>
References: <20200331035419.GB79749@google.com>
 <20200331090608.GZ20234@codeaurora.org>
 <20200331184307.GA198665@google.com>
 <20200401050801.GA20234@codeaurora.org>
 <20200403171727.GB68460@google.com>
 <20200403172750.GD68460@google.com>
 <20200413174237.GC39092@google.com>
 <20200414134403.GA69282@google.com>
 <20200416214045.GB196168@google.com>
 <e1b763bf-7f72-01eb-a368-9b70e0f46f55@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1b763bf-7f72-01eb-a368-9b70e0f46f55@huawei.com>
X-Headers-End: 1jPTeE-005TR7-OL
Subject: Re: [f2fs-dev] [PATCH] f2fs: prevent meta updates while checkpoint
 is in progress
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Sahitya,

Could you please test this patch fully? I didn't test at all.

Thanks,

On 04/17, Chao Yu wrote:
> On 2020/4/17 5:40, Jaegeuk Kim wrote:
> > On 04/14, Jaegeuk Kim wrote:
> >> On 04/13, Jaegeuk Kim wrote:
> >>> On 04/03, Jaegeuk Kim wrote:
> >>>> On 04/03, Jaegeuk Kim wrote:
> >>>>> On 04/01, Sahitya Tummala wrote:
> >>>>>> Hi Jaegeuk,
> >>>>>>
> >>>>>> Got it.
> >>>>>> The diff below looks good to me.
> >>>>>> Would you like me to test it and put a patch for this?
> >>>>>
> >>>>> Sahitya, Chao,
> >>>>>
> >>>>> Could you please take a look at this patch and test intensively?
> >>>>>
> >>>>> Thanks,
> > 
> > v5:
> >  - add signal handler
> > 
> > Sahitya raised an issue:
> > - prevent meta updates while checkpoint is in progress
> > 
> > allocate_segment_for_resize() can cause metapage updates if
> > it requires to change the current node/data segments for resizing.
> > Stop these meta updates when there is a checkpoint already
> > in progress to prevent inconsistent CP data.
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
