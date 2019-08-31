Return-Path: <SRS0=Cguz=W3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41356C3A59B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Aug 2019 02:30:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0694823429
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Aug 2019 02:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="BczGXakq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="aUI3kZtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0694823429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i3t9u-0005nl-Hw; Sat, 31 Aug 2019 02:30:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1i3t9s-0005nT-PT
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Aug 2019 02:30:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Af4G/5lNQ5uJjjH/hm6nsHGSZjWQ2toNkpR1Zn9xoZQ=; b=BczGXakqZtRe4td2oHnAobWUqn
 dlTzLD9SJTzgsJmmCsDbV7ckAC6sJcqziGRNs6H0NNih7T0ZyB1quZYCVRF6ogkINqxHqYyERq3t1
 pY2HEf8YMf8xt3YWhTwS9vWp+YapCikxqx38JXV5iNqun+KNCJNydLZNOD38xUOT0Rzc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Af4G/5lNQ5uJjjH/hm6nsHGSZjWQ2toNkpR1Zn9xoZQ=; b=aUI3kZtJvHE9Bd67TzOkGzmOuv
 Oo5d6dvPPPx178H1tRk/9w7oI0ANo088cQiPaAu0kq9mT0bd62R2SI7Vldz1QXpkjtG1JoB1uKBzp
 +aHZZZr7v/zgszqRhokJRGH+gKhyU5vXge/xpfkT6RTZpLTBKn/oRSH2dSYhRFiCNXWc=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i3t9q-004XY1-ON
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Aug 2019 02:30:32 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id BD85CA8E0043A4CEDBD0;
 Sat, 31 Aug 2019 10:30:21 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 31 Aug
 2019 10:30:14 +0800
To: zhengbin <zhengbin13@huawei.com>, <jaegeuk@kernel.org>, <chao@kernel.org>, 
 <linux-f2fs-devel@lists.sourceforge.net>
References: <1567216011-43066-1-git-send-email-zhengbin13@huawei.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <01183b8e-3cbd-d7a9-38b8-320fca43f583@huawei.com>
Date: Sat, 31 Aug 2019 10:30:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1567216011-43066-1-git-send-email-zhengbin13@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1i3t9q-004XY1-ON
Subject: Re: [f2fs-dev] [PATCH] f2fs: Make f2fs_fname_setup_ci_filename
 static
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

Hi Zheng,

Thanks for the patch, the original patch is still in dev branch, I suggest we
can merge it into original patch, do you mind that?

Thanks,

On 2019/8/31 9:46, zhengbin wrote:
> Fix sparse warning:
> 
> fs/f2fs/dir.c:142:6: warning: symbol 'f2fs_fname_setup_ci_filename' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  fs/f2fs/dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 9de688a..147fa5a 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -139,9 +139,9 @@ int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
>  	return ret;
>  }
> 
> -void f2fs_fname_setup_ci_filename(struct inode *dir,
> -					const struct qstr *iname,
> -					struct fscrypt_str *cf_name)
> +static void f2fs_fname_setup_ci_filename(struct inode *dir,
> +					       const struct qstr *iname,
> +					       struct fscrypt_str *cf_name)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(dir);
> 
> --
> 2.7.4
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
