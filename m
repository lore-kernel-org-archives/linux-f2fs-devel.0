Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A58C6FD18
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Apr 2023 16:03:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pqcBe-0006PE-76;
	Sun, 23 Apr 2023 16:03:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pqcBc-0006P8-Qc
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Apr 2023 16:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l4fnmyh/+oVSJqL469GtMAERh4irEemZvst8BpzyH4Q=; b=hg+N95RL7/n7bxuk9QZBoUdYSA
 1huN+H89XmPIE8czVyAi4As05CHt6SQ7FpbayOmgIF8hkvcqBLm/eugNcRkKBm4d1hhCyY5ddtJ3s
 AwSOmtVA+ZbGnvJkuBcQh6vPm6yTe6yvgeA/475dGM1uuDWs88D1w650l8Tsu0HXV/jQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l4fnmyh/+oVSJqL469GtMAERh4irEemZvst8BpzyH4Q=; b=ZoAmDuGjx6t8VvXeOcq2Zd7sj6
 G+Gl15G6mZPeeOWL4YLKNBYajdytJI9B6OId2LJpuqGMlY0sDF2g5yoIcJnx8lX9ehMu5v0sxjaQH
 dHmLp2mFC5f1AYHXTmhYznwyHbKC1fO3kErmQg48tnzjLhvwZAfMgJKbNXyncBJc9neg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pqcBY-00GnUS-Gh for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Apr 2023 16:03:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2B93760EFA;
 Sun, 23 Apr 2023 16:03:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E3FC433EF;
 Sun, 23 Apr 2023 16:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682265806;
 bh=/hdz+i+nYRUKEXgv7GQajTKcP8oCUU7AN+8fnhfL/Lw=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=SdFpj43ZoMG9P2j5lQj3TR7F78PzqFBIA1ayhOux4OkMZ032BpxQpbvZaOwsVBuZW
 J38BShYDkcZiIOXN1+BvNXvXVtFlNgZu/aovvoSnvfP+Ay3Jg4Ifs0Y8xF3tnEnhwI
 KShPRLY+CAAmshhFeFRWBrI6XEzcSJoQoy8iaQyUVGmV4s+pilbdmJMwmA0UU18GQf
 hjVuq8kH7sOMZwa5knJINvFuwCoRQnpKCCteKCAn+QfhuQ9VIjECwUIfQZZHN4FhDQ
 8c9fdIF8e47SSzCURY5HnJ3zh9JxGK6SPsWQe7bBXpmC4AFn24+WXxXIT8pDvVqd2/
 GsEmfCZbyV+Fw==
Message-ID: <99c955da-6551-dd63-6587-7f515dd5be32@kernel.org>
Date: Mon, 24 Apr 2023 00:03:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230406193716.70796-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230406193716.70796-1-frank.li@vivo.com>
X-Headers-End: 1pqcBY-00GnUS-Gh
Subject: Re: [f2fs-dev] [PATCH] f2fs: add sanity check for proc_mkdir
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

On 2023/4/7 3:37, Yangtao Li wrote:
> Return -ENOMEM when proc_mkdir failed.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   fs/f2fs/sysfs.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 3aad3500a701..dcd497e0920a 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1385,12 +1385,19 @@ int __init f2fs_init_sysfs(void)
>   
>   	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
>   				   NULL, "features");
> -	if (ret) {
> -		kobject_put(&f2fs_feat);
> -		kset_unregister(&f2fs_kset);
> -	} else {
> -		f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
> +	if (ret)
> +		goto put_kobject;
> +
> +	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
> +	if (!f2fs_proc_root) {

How about removing below check for f2fs_proc_root in f2fs_register_sysfs()?

	if (f2fs_proc_root)
		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);

Thanks,

> +		ret = -ENOMEM;
> +		goto put_kobject;
>   	}
> +
> +	return 0;
> +put_kobject:
> +	kobject_put(&f2fs_feat);
> +	kset_unregister(&f2fs_kset);
>   	return ret;
>   }
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
