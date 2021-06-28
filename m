Return-Path: <SRS0=QpjO=LW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60947C2B9F4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Jun 2021 15:43:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BF46197F;
	Mon, 28 Jun 2021 15:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BF46197F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lxtQM-0006GB-5q; Mon, 28 Jun 2021 15:43:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lxtQE-0006F7-CX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 15:43:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zzn+UPT1O0igeZulo4DiKrHiHsfan3MX+AKChiDi39M=; b=L94YpkqGbT7XtB8rrfkI9qj+aw
 ifKbdrkmLeJN97ZK8il5eJnuZGEZfYI3wdq5OticqT78v2LHU8fntdnnhKwFY4q4PR3qqox7pAdT6
 iuvGer6Zjlw2hV/Lq1o899lowzuzLB1cIF7SFjn1Bu9WjV2MlZkXtBl6k+WUdJZX1wc8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zzn+UPT1O0igeZulo4DiKrHiHsfan3MX+AKChiDi39M=; b=NB+radQuE7ntmY1R6PWjIjE9k8
 bGKTf183cCXX/LFeG7bPk37DdqwiBVdq0HCIpgm1le/lqPHeQyqfTQadzPsSwHGLJpKK1tt5s4pdH
 OSK5pgS8ec9E2DMmLBtlFgKIB7K/S/mSZWkA0/1+seDWynbmwCKAdERv3B7Hzaaxckq0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lxtQA-0023FF-Ur
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jun 2021 15:43:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F19FA60233;
 Mon, 28 Jun 2021 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624895008;
 bh=Q+y2V0I7+R8Os23phWa4M7sQFvLHdurvGVi37dulsbs=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=FiJK3qYDTJjb8CLuttLCpPWLPBxf/GwueYcY24YSPhQnFw0qCnO+DS5XRGhji+pMA
 UOXRgTH17a/7L+S6Bt/YWMzjPvIIibpTYJAADMW/keHp8P3fUwWkqwd3ughlPSc4o7
 vR+U05nTytSb17INLY4lq39wzNKwHqSozwl/rMHxzwN2HOknrcPi3Z7tROtj8sVxwM
 +gmrUka8yHz/wyavGSmkbcwUVB5+5AJHYnZU9i7MtMEa0AgFwQjlXXCmsLU/KaLLjp
 lQXM4sP2Z1KsO5ypFDO+c7fh1begOw86d95ab0/U1RAIp0p+2LRGQ4AwAvOSsO0kZF
 SmtdIKhLgy19w==
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210622202217.3864743-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <e4a93d52-ec10-9b8f-390a-d238a4a3d9e3@kernel.org>
Date: Mon, 28 Jun 2021 23:43:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210622202217.3864743-1-jaegeuk@kernel.org>
Content-Language: en-US
X-Headers-End: 1lxtQA-0023FF-Ur
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove false alarm on iget failure
 during GC
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/23 4:22, Jaegeuk Kim wrote:
> This patch removes setting SBI_NEED_FSCK when GC gets an error on f2fs_iget,
> since f2fs_iget can give ENOMEM and others by race condition.
> If we set this critical fsck flag, we'll get EIO during fsync via the below
> code path.
> 
> In f2fs_inplace_write_data(),
> 
> 	if (is_sbi_flag_set(sbi, SBI_NEED_FSCK) || f2fs_cp_error(sbi)) {
> 		err = -EIO;
> 		goto drop_bio;
> 	}
> 
> Fixes: 9557727876674 ("f2fs: drop inplace IO if fs status is abnormal")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
