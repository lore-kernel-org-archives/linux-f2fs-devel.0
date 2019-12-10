Return-Path: <SRS0=ioJ8=2A=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10EEC43603
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Dec 2019 02:09:47 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2E5620726;
	Tue, 10 Dec 2019 02:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="SQlrMXn5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="OHSYWeXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2E5620726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ieUyB-00044t-8Z; Tue, 10 Dec 2019 02:09:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ieUy9-00044k-Du
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Dec 2019 02:09:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YXCrLIXHAup8oEMdeu4dma+FfsTSMS+/PPq3MB+SFtw=; b=SQlrMXn56pFXjxGzBWePErtz3K
 DUKN9IQfHLTxB7Jsn6/1HLUctOCjc91i3tr9j2f62MII2vJy+fOB0sQKUFbt/oixEjBtRoHh3ZntP
 BzM7q569Uxzkm0CAxX4hKORgZGoBYauW84YkzmlHEKjdZ7kYJ78dFEKQbf7L9sWNSKVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YXCrLIXHAup8oEMdeu4dma+FfsTSMS+/PPq3MB+SFtw=; b=OHSYWeXKhHsBZAVbS8FHckllGZ
 qt1iR+AywsKvwhPgc87FUmdDfLsRmrjBEFXFWbtmeVRunG2jY2f1935QNcApInsKwT0YPdKXe9vhq
 8hKfwu8MUFhMuIbWPI5iUdOIkMAhStyIaVncc5pzsXNqbgx82AuiB61L1MUzNWMMHEac=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1ieUy8-00G6HY-2T
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Dec 2019 02:09:45 +0000
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 3727580365B3C590DBB2;
 Tue, 10 Dec 2019 10:09:27 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 10 Dec
 2019 10:09:23 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <0f842142-4931-dcb8-9843-47510851e93b@huawei.com>
Date: Tue, 10 Dec 2019 10:09:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191209222345.1078-1-jaegeuk@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1ieUy8-00G6HY-2T
Subject: Re: [f2fs-dev] [PATCH 1/6] f2fs: call f2fs_balance_fs outside of
 locked page
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/12/10 6:23, Jaegeuk Kim wrote:
> Otherwise, we can hit deadlock by waiting for the locked page in
> move_data_block in GC.
> 
>  Thread A                     Thread B
>  - do_page_mkwrite
>   - f2fs_vm_page_mkwrite
>    - lock_page
>                               - f2fs_balance_fs
>                                   - mutex_lock(gc_mutex)
>                                - f2fs_gc
>                                 - do_garbage_collect
>                                  - ra_data_block
>                                   - grab_cache_page
>    - f2fs_balance_fs
>     - mutex_lock(gc_mutex)
> 
> Fixes: 39a8695824510 ("f2fs: refactor ->page_mkwrite() flow")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
