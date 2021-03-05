Return-Path: <SRS0=WIjR=ID=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63740C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Mar 2021 01:20:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D23464FF0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Mar 2021 01:20:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D23464FF0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lHz8Q-0003WD-99; Fri, 05 Mar 2021 01:20:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1lHz8P-0003Vy-0B
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Mar 2021 01:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ecPmvkVKO/8AfuhbkEByCN5D5cYlKYT5tWQMeTGT0PA=; b=bgW8Fhu7qZdzsoMt084y9QnDXp
 udSMqMSDpUlyLqwbe0Cd4BUu38vCawUCXUEkzKOoNwK4ZvIr6Dyyyzal6dg1mdQzP/RhxugoMKZmO
 izRhPS1HyN9aePVxCxKPCtLdliNT5dbNiS2ozar7dZERQmbMFIxr1fW/kDp0ZMFcXokM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ecPmvkVKO/8AfuhbkEByCN5D5cYlKYT5tWQMeTGT0PA=; b=JFxRyHDtZhEZ3LxUhJWUl5BrCT
 mRicJJ8QnYAP8W/3iHhJX8h1Iu55lZHDXrlkfqecdbyQ/P5XCmA3t3At4orRZHE+u+0+GsDTURl7r
 tZkZy1s7uMPt40pNE933olQ28D/bneaYGF/nZW9DzeDkbiMiFf+HEkznDaTTpERUdj+M=;
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lHz8M-00ESpZ-6v
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Mar 2021 01:20:04 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ds8x31fxdzMjGY;
 Fri,  5 Mar 2021 09:17:43 +0800 (CST)
Received: from [10.136.110.154] (10.136.110.154) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.498.0; Fri, 5 Mar 2021
 09:19:48 +0800
To: Colin King <colin.king@canonical.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20210304092118.2279879-1-colin.king@canonical.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <a67cbd86-0e44-490a-95fa-cf300e005d2e@huawei.com>
Date: Fri, 5 Mar 2021 09:19:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20210304092118.2279879-1-colin.king@canonical.com>
Content-Language: en-US
X-Originating-IP: [10.136.110.154]
X-CFilter-Loop: Reflected
X-Headers-End: 1lHz8M-00ESpZ-6v
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix a redundant call to
 f2fs_balance_fs if an error occurs
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
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/3/4 17:21, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The  uninitialized variable dn.node_changed does not get set when a
> call to f2fs_get_node_page fails.  This uninitialized value gets used
> in the call to f2fs_balance_fs() that may or not may not balances
> dirty node and dentry pages depending on the uninitialized state of
> the variable. Fix this by only calling f2fs_balance_fs if err is
> not set.
> 
> Thanks to Jaegeuk Kim for suggesting an appropriate fix.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 2a3407607028 ("f2fs: call f2fs_balance_fs only when node was changed")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
