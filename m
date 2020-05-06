Return-Path: <SRS0=zUg3=6U=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115F1C28CBC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 May 2020 06:36:11 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD01206E6;
	Wed,  6 May 2020 06:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Wh+f+hR9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="m3st7D8a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD01206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jWDf8-0005Rr-Ep; Wed, 06 May 2020 06:36:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jWDf7-0005Rk-Ou
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 May 2020 06:36:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V+JsmoKL0sBinO9/hPLLLopBoXnUFbodKq+on5xN67o=; b=Wh+f+hR9C6RFsiF2IP9BjAzHKx
 q1lG6oTQ6xY0WjKTX2yztDiz6D+PFJrK+hd/gCfhE26e1WINE53fJBIV5/rcL79rT2lmDtLQ8YPSK
 ZxfTjllI9TaQdtt7DjqpjtbmdQjx51oVo+cX1TVYj8PvU9PrElDyvb2F/KFkrtMZ59EU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V+JsmoKL0sBinO9/hPLLLopBoXnUFbodKq+on5xN67o=; b=m3st7D8adt7l+5VjK4gGdHQCvn
 j7k1iRqqHkc4TJtw+gFrCSseqBq+yUVt0FpvZBbsydaWnM17UHejHDNCp9fkmTHoF+2IWX8+EbhSq
 6bzpXQzZhi8GOJTcp7cNdlHJqeatGeXvLonki7eVoG5z+4EFABSQjhWOrzbc7qYiae0c=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jWDf5-00CO0R-Sc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 May 2020 06:36:09 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 665C1D096F5F4BE52522;
 Wed,  6 May 2020 14:35:57 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 6 May 2020
 14:35:56 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20200502002920.76569-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <66e59a2f-c877-6952-cae6-645ba18f9f75@huawei.com>
Date: Wed, 6 May 2020 14:35:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200502002920.76569-1-jaegeuk@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jWDf5-00CO0R-Sc
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs_io: add fsync
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

On 2020/5/2 8:29, Jaegeuk Kim wrote:
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  tools/f2fs_io/f2fs_io.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index c1edef1..c84b6ab 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -130,6 +130,30 @@ static void full_write(int fd, const void *buf, size_t count)
>  	}
>  }
>  
> +#define fsync_desc "fsync"
> +#define fsync_help						\
> +"f2fs_io fsync [file]\n\n"					\

What about supporting fdatasync via an additional argument here?

> +"fsync given the file\n"					\
> +
> +static void do_fsync(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	int fd;
> +
> +	if (argc != 2) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	fd = xopen(argv[1], O_WRONLY, 0);
> +
> +	if (fsync(fd) != 0)
> +		die_errno("fsync failed");
> +
> +	printf("fsync a file\n");
> +	exit(0);
> +}
> +
>  #define set_verity_desc "Set fs-verity"
>  #define set_verity_help					\
>  "f2fs_io set_verity [file]\n\n"				\
> @@ -780,6 +804,7 @@ static void do_reserve_cblocks(int argc, char **argv, const struct cmd_desc *cmd
>  static void do_help(int argc, char **argv, const struct cmd_desc *cmd);
>  const struct cmd_desc cmd_list[] = {
>  	_CMD(help),
> +	CMD(fsync),
>  	CMD(set_verity),
>  	CMD(getflags),
>  	CMD(setflags),
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
