Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172A4C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Jun 2023 01:56:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q74sx-0007Zk-AV;
	Thu, 08 Jun 2023 01:56:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q74sv-0007Ze-UW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jun 2023 01:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a0x0K/7URK1acJ46oXyecyzqicHr7sBMtvhq4btkWMI=; b=KysZMdS9VyW/SddLEbtU+8/PZd
 qfrmMIL+x3k10MA9P+fbAFTbEm4aq/la6219kH/NkPPhmTknvoHyEHsguBja1NsnJT2bUEl+zTAnq
 3qPenn+tXokiOzNJIxi0zpv/p7UcPOH259Wgz3u2N6oYNuoX0bQFkHiicoX+yiIMel78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=a0x0K/7URK1acJ46oXyecyzqicHr7sBMtvhq4btkWMI=; b=Ro//7dvb9IkShejjXcjv+RxbKJ
 d2HA8PKQmk92BNs/aiwvvD5PXLHR42WfU7ClECL0RsVSYmFUgMtGx886do5JkBgH59Hi9gF1fhkED
 9xrOr1OPcd+vM0Ht5JT64G1TogfWOZt/CRyurLjZV1GlvrQ19mkiyUiuDjUytvEzppBg=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q74sr-00068t-3M for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Jun 2023 01:56:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 865DF64152;
 Thu,  8 Jun 2023 01:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE87BC4339B;
 Thu,  8 Jun 2023 01:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686189366;
 bh=zI4G/zMTzBh1j2ootVMCzxAs+++eYjxqqLRG1iq8wdA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h8a8DXHYT3sWfFLnZgIXZ2pP2pLLSGxSeX2G3jxpottPeMdiNwB4MomwVo3ayrgIM
 cmklzq0VXLqafxX2ZP2LJwzK9vj7QAV1iiCqYw0Uyj/wU7yOm8ePyE8e/7sTw6Zlp3
 OqjiOc78+9Hl3RiwE0vm7yJ8crnKN7Yln4/8KGoxt82/QLLuB7sWblmDe/ef5drzMA
 9EPLIsGEU6aIrUfKd7ElUTRYEydWQwVeJLlnJoCOsR1y5x0JLwx2+WlDwiaclYkb7s
 KwnM6tKMGPqp10aEip16p9qAfjb+CrkwZq/TlL3OsjQXPHMbnsjXkvmZW1JNxh0iIU
 IJx9V+Bwz4iyA==
Message-ID: <1e6878a7-df98-6199-5a9a-c18020b7b739@kernel.org>
Date: Thu, 8 Jun 2023 09:56:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230607145637.14769-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230607145637.14769-1-frank.li@vivo.com>
X-Headers-End: 1q74sr-00068t-3M
Subject: Re: [f2fs-dev] [PATCH v2] f2fs_io: expend fallocate command
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

On 2023/6/7 22:56, Yangtao Li wrote:
> Expend fallocate command to support more flags.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   tools/f2fs_io/f2fs_io.c | 39 +++++++++++++++++++++++++++++++++------
>   1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index 1774eca..5a6a6a0 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -413,9 +413,13 @@ static void do_pinfile(int argc, char **argv, const struct cmd_desc *cmd)
>   
>   #define fallocate_desc "fallocate"
>   #define fallocate_help						\
> -"f2fs_io fallocate [keep_size] [offset] [length] [file]\n\n"	\
> +"f2fs_io fallocate [-cipz] [keep_size] [offset] [length] [file]\n\n"	\

Yangtao,

It missed to update man/f2fs_io.8.

Thanks,

>   "fallocate given the file\n"					\
>   " [keep_size] : 1 or 0\n"					\
> +" -p : punch hole\n"						\
> +" -c : collapse range\n"					\
> +" -z : zero range\n"						\
> +" -i : insert range\n"						\
>   
>   static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
>   {
> @@ -423,20 +427,43 @@ static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
>   	off_t offset, length;
>   	struct stat sb;
>   	int mode = 0;
> +	int c;
>   
> -	if (argc != 5) {
> +	while ((c = getopt(argc, argv, "cipz")) != -1) {
> +		switch (c) {
> +		case 'c':
> +			mode |= FALLOC_FL_COLLAPSE_RANGE;
> +			break;
> +		case 'i':
> +			mode |= FALLOC_FL_INSERT_RANGE;
> +			break;
> +		case 'p':
> +			mode |= FALLOC_FL_PUNCH_HOLE;
> +			break;
> +		case 'z':
> +			mode |= FALLOC_FL_ZERO_RANGE;
> +			break;
> +		default:
> +			fputs(cmd->cmd_help, stderr);
> +			exit(2);
> +		}
> +	}
> +	argc -= optind;
> +	argv += optind;
> +
> +	if (argc != 4) {
>   		fputs("Excess arguments\n\n", stderr);
>   		fputs(cmd->cmd_help, stderr);
>   		exit(1);
>   	}
>   
> -	if (!strcmp(argv[1], "1"))
> +	if (!strcmp(argv[0], "1"))
>   		mode |= FALLOC_FL_KEEP_SIZE;
>   
> -	offset = atoi(argv[2]);
> -	length = atoll(argv[3]);
> +	offset = atoi(argv[1]);
> +	length = atoll(argv[2]);
>   
> -	fd = xopen(argv[4], O_RDWR, 0);
> +	fd = xopen(argv[3], O_RDWR, 0);
>   
>   	if (fallocate(fd, mode, offset, length) != 0)
>   		die_errno("fallocate failed");


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
