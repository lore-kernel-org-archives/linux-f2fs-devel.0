Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDD8C38A2D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Oct 2022 07:01:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1onDwP-0005H4-Sn;
	Tue, 25 Oct 2022 07:01:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1onDwO-0005Gy-38
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Oct 2022 07:01:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bAnvyYppawr2DUDq1kMTJCPUAzwj/FRlVyPDuG2y4Ug=; b=Id8qZ3H5t7exEguSfYO2OB0atS
 lU723ddAJ324vZW2M3My//9Cy/bWW2iyRo4e4LninNwgGdqcQQ7fQYnA4ko4xIfkEq7mnjYnmTNDW
 fXzIQV96mzCgOe4VTvLiCPpGcRwgkbnvZzkXgxPlggA2ZKAiBdPcPxX1MQhjeboNfb4s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bAnvyYppawr2DUDq1kMTJCPUAzwj/FRlVyPDuG2y4Ug=; b=YnMCuG3jkMr9O1LHqkVTh17wxF
 b7hYt/DG1sL1DlcF8SybAFgaIuiAR/UoBwiPuBzyYZpkHvUBxfw0kGXoN4ix5UoKT70ccpKHgi0GD
 TGDRsMr4EsuVHVDEzAqsBKc9gsxAxyG8w4ycdvA1YxhP9hXQ3vW+DjmAVgbtxH/puISQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1onDwK-00GaVa-MV for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Oct 2022 07:01:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3D44A61774;
 Tue, 25 Oct 2022 07:01:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A9AC433B5;
 Tue, 25 Oct 2022 07:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666681278;
 bh=4PYxQh+Qd9S4hsYLOGM4p4PEH3DXxAlrzkcdULK3UMw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nMBzcXK5kpUmQ++BIkuyPzhy7M0Y6Fm1bzkMfrg5/vyXtGaO3R4nFAAotqXbjb/B4
 nHySbdd/PlFrOMcWL9CGFKxYNWxVLLKr1Pwvg1eGzmn+aOfkMZGFJcj4Pkf03NxD4x
 DBIKnbSy/8z0o0Ld1NogDKfDveYK078HCALP9ptKYeXWzLbxW1Tz4Y4zLrAy46tAKi
 l0H3+jUqqf/nwA8ITqc4GYgdjYBuqAxlpqA8EvAU7NrDBEY/EnF3q4YZGqIH1BWqfV
 SDYI2xfF3W63SRcT3grIK9J6LF6ylokCAtdNp70p8H02C2PjuFex7qFQ+9iQKycGcS
 UL3RX03iBjuHA==
Message-ID: <bfae3198-7557-f984-200c-2c677881f462@kernel.org>
Date: Tue, 25 Oct 2022 15:01:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221024135943.76120-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221024135943.76120-1-frank.li@vivo.com>
X-Headers-End: 1onDwK-00GaVa-MV
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove redundant return in
 f2fs_create_flush_cmd_control()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/24 21:59, Yangtao Li wrote:
> Replace
> 	if (A) {
> 		......
> 		return err;
> 	}
> 	return err;
> with
> 	if (A) {
> 		......
> 	}
> 	return err;
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/segment.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index acf3d3fa4363..f6f16d691226 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -647,7 +647,6 @@ int f2fs_create_flush_cmd_control(struct f2fs_sb_info *sbi)
>   		err = PTR_ERR(fcc->f2fs_issue_flush);
>   		kfree(fcc);
>   		SM_I(sbi)->fcc_info = NULL;
> -		return err;
>   	}
>   
>   	return err;

It may looks more clean if it return 0 here?

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
