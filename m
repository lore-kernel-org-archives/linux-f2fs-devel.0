Return-Path: <SRS0=CSNb=KG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9E8C433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 May 2021 01:43:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8445613B6;
	Tue, 11 May 2021 01:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8445613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lgHRC-0008Qt-UM; Tue, 11 May 2021 01:43:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <yuchao0@huawei.com>) id 1lgHRB-0008Ql-BD
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 May 2021 01:43:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nNYPWEXRDdxNoqT4WIF4EU3PNFpdqLiZ6LDyTxnFCv4=; b=hIuclfgfvmEnBPOT/z9hw7sr4s
 U0KfOcZfspl85wB8sqDUAcgDORPWXABqzUKNsDqLNIYrfNxrt4K7Zr0ETLdK5DZwQ/lA8VIxjhrIi
 ewxjdMjjCxFMDGSF+LHCqD01ejxhSpigb4J5PUXv8KhJ1SeRxWK6jKc824ejDCuCisgA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nNYPWEXRDdxNoqT4WIF4EU3PNFpdqLiZ6LDyTxnFCv4=; b=BhcZPPry03IOCWnrNk9mt3/SLM
 ozbHYxiDK+/d374keO+yajrhuNlOI1bprcrhLhaWMC1dMGFbBT8ugcb5RUpsjVC5GEorvWq7gCVqA
 UODJd/YQWBEYVm5fuCj11Epy4m36PdFpPjqvl6QSsPoHofz3cAYve9bVH5jVN9L+TcXA=;
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lgHR9-003GQn-Ef
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 11 May 2021 01:43:53 +0000
Received: from dggemx753-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FfLHK23zFzYY1p;
 Tue, 11 May 2021 09:41:17 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 11 May 2021 09:43:43 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20210506191347.1242802-1-jaegeuk@kernel.org>
 <YJlGU+STYD5geyIc@google.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <d052e04f-9b3c-8766-9b47-b4ea1daf6990@huawei.com>
Date: Tue, 11 May 2021 09:43:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <YJlGU+STYD5geyIc@google.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
X-Headers-End: 1lgHR9-003GQn-Ef
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support iflag change given the mask
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

On 2021/5/10 22:42, Jaegeuk Kim wrote:
> In f2fs_fileattr_set(),
> 
> 	if (!fa->flags_valid)
> 		mask &= FS_COMMON_FL;
> 
> In this case, we can set supported flags by mask only instead of BUG_ON.
> 
> /* Flags shared betwen flags/xflags */
> 	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> 	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
> 	 FS_PROJINHERIT_FL)
> 
> Fixes: 4c5b47997521 ("vfs: add fileattr ops")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Except fixes line issue pointed out by Eric, other part looks good
to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
