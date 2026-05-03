Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6103DFF886F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  3 May 2026 08:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=veyH99D7BwJMptJTL5CH8jknSvW3kAWxlTcbpMqzpms=; b=ekq/jwJ8Zg57GSt4bTq4blVX73
	20ohG520v2Jd+d7rr6wDYMRQiH8eVlPN5j7xg0zohzO7N/eAn1HlbukvfphEQE8c7s6tbqVoOyroM
	yIQvO4ydZfZ8KXL0/0YA2ctMS2xxFJsrn+oOJQkIHOdxh5XO/Fykdnrcta/R2XlmYG20=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJSaH-0001O1-Tu;
	Sun, 03 May 2026 08:53:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wJSaH-0001Nv-6s
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 03 May 2026 08:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d5AWLYFNpbg0d6RZSRZk3VW+g7HEzdMRCQvE0+9jqfA=; b=NyFu+22MWtGQLna80si+D7n7Yf
 2+McJ2X6qDMkgPmTfzB8bPBolAv4M22PJab6aaWHj02V740jnX3kjkbKCTkaDK9XxNO8z1LuAJJU4
 lwSInV1dyeu5cgKpmJaATCOKpy3ZRRyrgbrp0u6rpd/5YjaJLxZlxzqf6lbriuSI99sY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=d5AWLYFNpbg0d6RZSRZk3VW+g7HEzdMRCQvE0+9jqfA=; b=TcHJW1ZpbeMwZSKvibrCKxU03n
 L6kdEh4VVNKW51A0qpyUgIy68M9JGaPM7mwbL6gY/qQPo7dzFH5kegtaVvifVG+9iLmT/+aqq6b9L
 rYLvL3J72i7z+55794ZOABwTq3TFgu2afdZNxqeEKoqjV/0B7eZk7C/PeK2MEby6r2cc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJSaG-0008Tg-L8 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 03 May 2026 08:53:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 29B2543405
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  3 May 2026 08:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D71FC2BCB4;
 Sun,  3 May 2026 08:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777798422;
 bh=eYHQAy53cgDoUYMgH8pmK8gD8aznH5HU9ewz6B/hlV0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=fOX3TIjvqAasowRnLRGaR3j/yAmLmf3Q4nlvvP4qIul/I95bN3Ewc2QpNxRZ0p48I
 M4HTxSM8zh0zQMnLsdqQFintiaZtrNh5ecPBeBNM0KPCrT7qFXxU230YyfNloOS10P
 vGtjavmwEMyQ4NHpXe4OcRkfT3sO3ZuXPhGcO63MPuEfq5nySxpLR8seDPJ+UH1Ih+
 zIujwrONxYsBfa6L+GHbUZmBNOMaFXu2gWFlJOGTmnshGByYoI90glt4+SR1DPofDp
 3XlNx30y7M0M3ItBcmfBV6CMujCRc+i7woewUDekEq1BXatVEC1Oz6qeBQEwHOGaZ1
 rBVptX7T3iZew==
Message-ID: <aed4df88-bf36-4426-a794-4468b54360dd@kernel.org>
Date: Sun, 3 May 2026 16:53:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20260409134630.3693274-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20260409134630.3693274-1-jaegeuk@kernel.org>
X-Headers-End: 1wJSaG-0008Tg-L8
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs_io: support xattr(large_folio)
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/9/26 21:46, Jaegeuk Kim via Linux-f2fs-devel wrote:
> [Script]
> dd if=/dev/zero of=/mnt/test/test bs=1M count=1024
> f2fs_io setxattr user.fadvise 1 /mnt/test/test
> chmod 0400 /mnt/test/test
> sync -f /mnt/test/test
> echo 3 > /proc/sys/vm/drop_caches
> f2fs_io read 1 0 100000 mmap 0 1 /mnt/test/test
> f2fs_io get_fadvise /mnt/test/test
> 
> [Output]
> 1024+0 records in
> 1024+0 records out
> 1073741824 bytes (1.1 GB, 1.0 GiB) copied, 0.520712 s, 2.1 GB/s
> setxattr /mnt/test/test CREATE: name: user.fadvise, value: 1: ret=0
> Read 409600000 bytes total_time = 106757 us, BW = 4286 MB/s, IO time = 95577 us, mlock time = 11173 us, print 1 bytes:
> 00000000 : 00
> fadvise=0x1, advise_type: largefolio
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   tools/f2fs_io/f2fs_io.c | 32 ++++++++++++++++++++++++++++++++
>   tools/f2fs_io/f2fs_io.h |  6 ++++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index 680c06218394..8b9f9ef22eef 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -2084,6 +2084,7 @@ static void do_setxattr(int argc, char **argv, const struct cmd_desc *cmd)
>   	int ret, len;
>   	char *value;
>   	unsigned char tmp;
> +	unsigned int tmp_u;
>   
>   	if (argc != 4) {
>   		fputs("Excess arguments\n\n", stderr);
> @@ -2095,6 +2096,10 @@ static void do_setxattr(int argc, char **argv, const struct cmd_desc *cmd)
>   		tmp = strtoul(argv[2], NULL, 0);
>   		value = (char *)&tmp;
>   		len = 1;
> +	} else if (!strcmp(argv[1], F2FS_USER_FADVISE_NAME)) {

Missed to add description in doc?

> +		tmp_u = strtoul(argv[2], NULL, 0);
> +		value = (char *)&tmp_u;
> +		len = sizeof(unsigned int);
>   	} else {
>   		value = argv[2];
>   		len = strlen(value);
> @@ -2217,6 +2222,32 @@ static void do_get_advise(int argc, char **argv, const struct cmd_desc *cmd)
>   	printf("\n");
>   }
>   
> +#define get_fadvise_desc "get_fadvise"
> +#define get_fadvise_help "f2fs_io get_fadvise [file_path]\n\n"
> +
> +static void do_get_fadvise(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	int ret;
> +	unsigned int value;
> +
> +	if (argc != 2) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	ret = getxattr(argv[1], F2FS_USER_FADVISE_NAME, &value, sizeof(value));
> +	if (ret != sizeof(value)) {
> +		perror("getxattr");
> +		exit(1);
> +	}
> +
> +	printf("fadvise=0x%x, advise_type: ", value);
> +	if (value & (1 << F2FS_XATTR_FADV_LARGEFOLIO))
> +		printf("largefolio");
> +	printf("\n");
> +}
> +
>   #define ftruncate_desc "ftruncate a file"
>   #define ftruncate_help					\
>   "f2fs_io ftruncate [length] [file_path]\n\n"	\
> @@ -2626,6 +2657,7 @@ const struct cmd_desc cmd_list[] = {
>   	CMD(removexattr),
>   	CMD(lseek),
>   	CMD(get_advise),
> +	CMD(get_fadvise),

Ditto,

Thanks,

>   	CMD(ioprio),
>   	CMD(ftruncate),
>   	CMD(test_create_perf),
> diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
> index b0d40996f302..539964fc27d3 100644
> --- a/tools/f2fs_io/f2fs_io.h
> +++ b/tools/f2fs_io/f2fs_io.h
> @@ -186,6 +186,7 @@ struct fsverity_enable_arg {
>   #define F2FS_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
>   
>   #define F2FS_SYSTEM_ADVISE_NAME	"system.advise"
> +#define F2FS_USER_FADVISE_NAME "user.fadvise"
>   #define FADVISE_COLD_BIT	0x01
>   #define FADVISE_LOST_PINO_BIT	0x02
>   #define FADVISE_ENCRYPT_BIT	0x04
> @@ -195,6 +196,11 @@ struct fsverity_enable_arg {
>   #define FADVISE_VERITY_BIT	0x40
>   #define FADVISE_TRUNC_BIT	0x80
>   
> +/* used for F2FS_USER_FADVISE_NAME */
> +enum {
> +	F2FS_XATTR_FADV_LARGEFOLIO,
> +};
> +
>   /* used for F2FS_IOC_IO_PRIO */
>   enum {
>   	F2FS_IOPRIO_WRITE = 1,  /* high write priority */



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
