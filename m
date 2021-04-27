Return-Path: <SRS0=jqEA=JY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CC7C433ED
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Apr 2021 12:42:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ACD460FF1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Apr 2021 12:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACD460FF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lbN2s-0008Pu-Ie; Tue, 27 Apr 2021 12:42:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lbN2q-0008Pj-4j
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Apr 2021 12:42:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5Inh2rGfmNriecaswZOPuGsXBCNOvUNldD6gzbzQZ6Y=; b=mSgon16k7Wb0pJ8cjQIm0GCLjU
 RDcndjjUJSO1k6BhKHusturF6veg+ZkQf8dElKjR5AU+4K3AqaNfaRyRmFZIc9MR9FPSw8dYMYTwD
 jWUxYTklpVlrGnqLyZIY1myzMYX6A19nIO+POMWrDezlxZnza1c/CsY2R1sGYFfxFv8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5Inh2rGfmNriecaswZOPuGsXBCNOvUNldD6gzbzQZ6Y=; b=TUf4KMnq09jsiXlC4v/FhWzOyY
 SyQpSmbereWx9ZKns/B8XLM9uuMf3g51YNLTp+6MowP1u06flGAp+cpZ7c2yXAIMf9an0I6QmvNvJ
 EEqsK0UoiXeM3X7AhDJ9b51RKHXrN0anxKa81lI5K1GjP/17HiEkJjwuMBSnMOwwZ4lY=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lbN2o-00Gzra-5z
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Apr 2021 12:42:29 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FV1Xr3Yf5zPtB5;
 Tue, 27 Apr 2021 20:39:08 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 27 Apr
 2021 20:42:13 +0800
To: Fengnan Chang <changfengnan@vivo.com>, <chao@kernel.org>,
 <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20210426021153.646-1-changfengnan@vivo.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <fb748dde-3754-a60d-9b13-cf70dfa15df8@huawei.com>
Date: Tue, 27 Apr 2021 20:42:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210426021153.646-1-changfengnan@vivo.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
X-Headers-End: 1lbN2o-00Gzra-5z
Subject: Re: [f2fs-dev] [PATCH] f2fs: compress: avoid unnecessary check in
 f2fs_prepare_compress_overwrite
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

On 2021/4/26 10:11, Fengnan Chang wrote:
> when write compressed file with O_TRUNC, there will be a lot of
> unnecessary check valid blocks in f2fs_prepare_compress_overwrite,
> especially when written in page size, remove it.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/data.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index cf935474ffba..9c3b0849f35e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3270,6 +3270,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
>   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>   	struct page *page = NULL;
>   	pgoff_t index = ((unsigned long long) pos) >> PAGE_SHIFT;
> +	pgoff_t end = (i_size_read(inode) + PAGE_SIZE - 1) >> PAGE_SHIFT;

Should define this under compression macro, otherwise it may cause compile
warning.

>   	bool need_balance = false, drop_atomic = false;
>   	block_t blkaddr = NULL_ADDR;
>   	int err = 0;
> @@ -3306,6 +3307,9 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
> 
>   		*fsdata = NULL;
> 
> +		if (index >= end)
> +			goto repeat;
> +
>   		ret = f2fs_prepare_compress_overwrite(inode, pagep,
>   							index, fsdata);
>   		if (ret < 0) {
> --
> 2.29.0
> 
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
