Return-Path: <SRS0=IDC8=7H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AC2C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2020 02:17:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFEC2075F;
	Mon, 25 May 2020 02:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eZd83usZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="XQSchpvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFEC2075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jd2fs-0003hD-2b; Mon, 25 May 2020 02:17:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jd2fr-0003h4-Ef
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 May 2020 02:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5u+CNccuFfcRKkkJY3YDWACIc/wIIH5rwHE1ugHkJxc=; b=eZd83usZuTa+KOvAz1QSQHN6YU
 VV6SXSrGmHGbeP+UBPsYsBotAWosxxiSPwf6sqTl4+ETkSR4CiQsqOzqOFej2GhF1n5iPK01AGp8z
 5GvjStKzDWw8IQCmohRF9VDdI7XZMm30t+Auua+YnVHa0WLV3hegaqW/G8YU2PwPh3uo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5u+CNccuFfcRKkkJY3YDWACIc/wIIH5rwHE1ugHkJxc=; b=XQSchpvdiykFez+0TSfqQyuH8M
 ZzTXYEoDr8FubXSKlMi9B1VzTcp12LrO6RRwnJM9mqi62Fn+t51RODQUrxXyNbEF3wYV3plIzBp2B
 Sq1kYZto3HnwXoy2wPiNQFg98ZGC36acVFkOzcDX5JtK2+l9rCUSEGLiMR2YkoWXuNKI=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jd2fp-00CYKT-Ii
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 May 2020 02:17:07 +0000
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E161DA2192EA7979E763;
 Mon, 25 May 2020 10:16:58 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 25 May
 2020 10:16:55 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200522144752.216197-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <d105adcf-fa04-4165-f19d-84e1cafe3ce5@huawei.com>
Date: Mon, 25 May 2020 10:16:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200522144752.216197-1-jaegeuk@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jd2fp-00CYKT-Ii
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid inifinite loop to wait for
 flushing node pages at cp_error
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

On 2020/5/22 22:47, Jaegeuk Kim wrote:
> Shutdown test is somtime hung, since dirty node pages weren't flushed out.
> Let's drop dirty pages at umount after shutdown.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/node.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index e632de10aedab..8c63964a82fd0 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1520,8 +1520,15 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  
>  	trace_f2fs_writepage(page, NODE);
>  
> -	if (unlikely(f2fs_cp_error(sbi)))
> +	if (unlikely(f2fs_cp_error(sbi))) {
> +		if (is_sbi_flag_set(sbi, SBI_IS_CLOSE)) {
> +			dec_page_count(sbi, F2FS_DIRTY_NODES);
> +			up_read(&sbi->node_write);

We don't need to release node_write lock.

> +			unlock_page(page);
> +			return 0;
> +		}
>  		goto redirty_out;
> +	}
>  
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		goto redirty_out;
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
