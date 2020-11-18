Return-Path: <SRS0=QZZI=EY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DDFC56202
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2020 11:30:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F9D2080A;
	Wed, 18 Nov 2020 11:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="PcD0akIz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="A8YsJbQ6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jl+qWqT4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F9D2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kfLfr-0001OX-9b; Wed, 18 Nov 2020 11:30:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <bounce+103f7e.be9e4a-linux-f2fs-devel=lists.sourceforge.net@mg.codeaurora.org>)
 id 1kfLf3-0001Mg-Up
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Nov 2020 11:30:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:References:In-Reply-To:Subject:Cc:To:
 From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CI2ykVyl84LnJ/6kEAwgbGu8f1y85k1CNoUnnyDz58k=; b=PcD0akIzHwcsn9ZVj8l0C+OD+Z
 fyrlPNDf8WgaLUQZS318v92TiZw8t0y+QnnfH8+HNIBv1+VgAAHM5j6mLnx/HhrpSE9cx4jxfD7TS
 thXkNC34+hhzzZ+1/7Tq6/rNUWl/OEy2YK7S1rFLe6d7KyTZItwxHo3FTqKd4FAfXb08=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CI2ykVyl84LnJ/6kEAwgbGu8f1y85k1CNoUnnyDz58k=; b=A8YsJbQ6dN5P3SCQ7igq6ZxEC1
 Ihuf+Xw+tHvZjM431HyHpoJd5wF3AZc0ZsGq6GpeIYAnt8HiwABnS0laUNpKSAcI1/COavIHBa7ko
 jUTAE3NeVGGB6hV6CgqPxZHodfbDUEsi8i1+xLKyYLvoy7RqCdgOKjp6wqTnGnq1zz4s=;
Received: from z5.mailgun.us ([104.130.96.5])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kfLeg-00DK9K-4j
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Nov 2020 11:30:05 +0000
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1605698982; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=CI2ykVyl84LnJ/6kEAwgbGu8f1y85k1CNoUnnyDz58k=;
 b=jl+qWqT4/h6cM0l+JNlCjMCzLwDsP14wmnToP6Ml6e/iLRrWUqQfaDUVvg3FmS3QvH3KUwwD
 IpNQ4FUhEWrM44FxAtYJ07Ka4+yHMzAJH/ZwhQ/82temUKRElxQljZPrCW4XwFzuFevJEGL/
 oo1RAuAUT0GlOutsVP6ZK+mqKKQ=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI2M2Y4ZiIsICJsaW51eC1mMmZzLWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldCIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fb5058f24ba9b3b02dfe226 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 18 Nov 2020 11:29:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id B7AA0C43460; Wed, 18 Nov 2020 11:29:18 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested) (Authenticated sender: stummala)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 2B28AC433C6;
 Wed, 18 Nov 2020 11:29:18 +0000 (UTC)
MIME-Version: 1.0
Date: Wed, 18 Nov 2020 16:59:18 +0530
From: stummala@codeaurora.org
To: Chao Yu <yuchao0@huawei.com>
In-Reply-To: <46222a22-f42c-ef04-3707-8e0bc3fe76da@huawei.com>
References: <0891f749dc8537fc56a35634388827be@codeaurora.org>
 <46222a22-f42c-ef04-3707-8e0bc3fe76da@huawei.com>
Message-ID: <8e094021b958f9fe01df1183a2677882@codeaurora.org>
X-Sender: stummala@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-Headers-End: 1kfLeg-00DK9K-4j
Subject: Re: [f2fs-dev] f2fs: cp_mutex starvation issue
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

On 2020-11-18 15:37, Chao Yu wrote:
> Hi Sahitya,
> 
> On 2020/11/18 17:47, stummala@codeaurora.org wrote:
>> Hi Chao,
>> 
>> Can we consider to move the sbi->cp_mutex as well to use rw_sem 
>> similar
>> to this patch of yours -
>> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/fs/f2fs?id=fb24fea75ca5ceef59f753494b2efd453606e08a
>> 
>> We are observing issues where fsync() of a high priority task getting
>> starved when there is heavy IO from several low priority tasks.
>> I would like to know if this was considered before and if any issues 
>> in
>> doing so? Please share your inputs.
> 
> I missed to check cp_mutex lock, because I haven't been reported with
> starving issue on this lock, anyway, I agree to do the same change on
> cp_mutex lock, and I don't think there is any problem after change.
> 
> Could you please make one patch to fix this?

Thanks for the comments.
Sure, I will put up a patch for this.

Thanks,

> Thanks,
> 
>> 
>> Thanks,
>> Sahitya.
>> .
>> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
