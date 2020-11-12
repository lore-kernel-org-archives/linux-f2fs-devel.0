Return-Path: <SRS0=TvYq=ES=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37A4C55ABD
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2020 09:46:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1709B21D40;
	Thu, 12 Nov 2020 09:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="iWPuXBp8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="A5MlxkPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1709B21D40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kd9B8-0001FH-2N; Thu, 12 Nov 2020 09:46:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kd9B6-0001FA-OQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Nov 2020 09:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9UJftrv1fAzinfWoHyAaMdOWZ5AA+hw0UIUHJzBoyp8=; b=iWPuXBp8OichL0pqGxcIoyftPN
 rDfUBGhO1vPmwPPDBPc88ha+CXQntfJN3g4iz3xtxncgJBqjfHLGnSF8Xn+r34AUU8sQz7QiizCZv
 xO/Q8AmqTGa1HUrFX0ijHLM9EkFWHHHx8E7cxOWFDbEV+pTvUKnhQjq5yV7JHjDX7Uyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9UJftrv1fAzinfWoHyAaMdOWZ5AA+hw0UIUHJzBoyp8=; b=A5MlxkPTybPW/U3gcxBC39Y/Pd
 QLTyq5oKYZX31UnV/dUwJ85s4g3JavENnio2rQ3g5BnuQvT+9Jhmwo3BCzycyyuwIwqAbuFqrX7e6
 5j0wYohbkTODHeWl4gOMRZeQU+J5yJgLy+xjtjvS4sue56XPLIZn9mNBAzlOqql2A9rg=;
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kd9Az-000Lt1-Bf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Nov 2020 09:46:04 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWx5z41zSzkg2y;
 Thu, 12 Nov 2020 17:25:27 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 12 Nov
 2020 17:25:34 +0800
To: Hyeongseok Kim <hyeongseok@gmail.com>, <jaegeuk@kernel.org>
References: <20201112091454.15311-1-hyeongseok@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <6a442a9c-d8ab-3e5f-fda8-fabbbca2ed32@huawei.com>
Date: Thu, 12 Nov 2020 17:25:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201112091454.15311-1-hyeongseok@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kd9Az-000Lt1-Bf
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix double free of unicode map
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
Cc: linux-fsdevel@vger.kernel.org, hyeongseok.kim@lge.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/11/12 17:14, Hyeongseok Kim wrote:
> In case of retrying fill_super with skip_recovery,
> s_encoding for casefold would not be loaded again even though it's
> already been freed because it's not NULL.
> Set NULL after free to prevent double freeing when unmount.
> 
> Fixes: eca4873ee1b6 ("f2fs: Use generic casefolding support")
> Signed-off-by: Hyeongseok Kim <hyeongseok@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
