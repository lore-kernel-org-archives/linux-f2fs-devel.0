Return-Path: <SRS0=actn=GI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F74C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Jan 2021 09:34:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB902222A;
	Tue,  5 Jan 2021 09:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB902222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kwijq-00029n-Mt; Tue, 05 Jan 2021 09:34:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <colin.king@canonical.com>) id 1kwijo-00029e-IE
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jan 2021 09:34:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9BdU9iA90Mw+RMEF/zAnCi2Pnjb5bpO8GzrvAluNLqo=; b=ZhZH71uv0J2XU+RscuB95PnMSL
 Gu9FUry36zXLneNyT/KFruMxoMhMOMrYcB/bo3808Omhioc+cAamavOvH5r+NKS9IK6oSrJwWshz/
 0e3DZrf0SoTdsb5oX1KwWVdhYH2LBf4eiPa4hQJzQFVOdd7dJM0+ZUTbRaOFYIaMKWBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9BdU9iA90Mw+RMEF/zAnCi2Pnjb5bpO8GzrvAluNLqo=; b=JxVSt5K3zPvdkriV+oya3pvYHv
 ukzOLA8Pi8G34z/M4R7zHtVi5QE2YUbIB2Lij0KKYf5CFBfaDee0+/Q9j8H6SciBrpE932D7nd+nr
 gYNIhC2iOqI42y+QNuoT6lFrBtsV2ZCsQbPDzWleMBDufYQfTJDua69T9NQRSZOzxvEY=;
Received: from youngberry.canonical.com ([91.189.89.112])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-SHA:128) (Exim 4.92.2) id 1kwijg-009edm-Kw
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 Jan 2021 09:34:48 +0000
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <colin.king@canonical.com>)
 id 1kwijS-0007eX-9w; Tue, 05 Jan 2021 09:34:26 +0000
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20210105041630.1393157-1-daeho43@gmail.com>
From: Colin Ian King <colin.king@canonical.com>
Message-ID: <57be566b-89e2-04a1-9a8e-51e902fee96c@canonical.com>
Date: Tue, 5 Jan 2021 09:34:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105041630.1393157-1-daeho43@gmail.com>
Content-Language: en-US
X-Headers-End: 1kwijg-009edm-Kw
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix null page reference in
 redirty_blocks
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/01/2021 04:16, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fixed null page reference when find_lock_page() fails in
> redirty_blocks().
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Fixes: 5fdb322ff2c2 ("f2fs: add F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE")
> ---
> v2: changed error value and break the loop when error occurs
> ---
>  fs/f2fs/file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 9e5275716be8..d27173c24391 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4060,8 +4060,10 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
>  
>  	for (i = 0; i < page_len; i++, redirty_idx++) {
>  		page = find_lock_page(mapping, redirty_idx);
> -		if (!page)
> -			ret = -ENOENT;
> +		if (!page) {
> +			ret = -ENOMEM;
> +			break;
> +		}
>  		set_page_dirty(page);
>  		f2fs_put_page(page, 1);
>  		f2fs_put_page(page, 0);
> 
Thanks, looks good to me.

Reviewed-by: Colin Ian King <colin.king@canonical.com>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
