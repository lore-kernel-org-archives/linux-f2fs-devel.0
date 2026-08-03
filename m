Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF55C55162
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AL2SAwFUtpuCiAMueUcnrkR2lrhBZtzXwRRjm29tT9k=; b=jnucpy1MGdBWcAjkaiHe4X/jM7
	em+U3IpKloiaSVZN9azo5bbNeGVlTTyeNyi/unshiDp40TeVvd0PImecvE13HdpcbYEelKuyvADW7
	BfaiDs2mpx/YFColmMny4djXIW93q1slWAeBGXun0GImGEotXcRa9a/oP3QhYCCLj9ZE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqiAI-0003ct-HV;
	Mon, 03 Aug 2026 02:12:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqiAA-0003ch-DG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 02:12:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ld3fnnQevrRHNCxH/HctbVgrPv5BoFsH/RwdXZ9V4w4=; b=ZggsDRkeOaR8VyyQ+dkAgr6F5j
 iaWE/NOJ0H1pTZJ+S6jMI51PlOlJ/CShSIXLcQwr3w5BI9ouNM+srHaYEvsNqQfh8e+3aK3z1KAfd
 BwHIojOCEc63vfrxKVm1MakLO3BxeuiTXD2XD18R1AjexrR88yszp2xooSCqDJPVTWnw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ld3fnnQevrRHNCxH/HctbVgrPv5BoFsH/RwdXZ9V4w4=; b=bY6xsrxt4YrvFYpTuJ81dhlWHg
 wBoTerfwUkIHEfZBMaOm9Mk5HfoHOBHWOrS+gvmGxjpTL+50iiVEBZzW4arFT4g1bBNeoI/M+aobH
 1NPGr+cSNvJFzNr8QvRSzbhwASxByr65iexMRVtYptAJw+XS3zQ4oy1AieWvEFbniPFw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqiA9-0004pJ-PN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 02:12:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 374EA406C9;
 Mon,  3 Aug 2026 02:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6471F000E9;
 Mon,  3 Aug 2026 02:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785723136;
 bh=Ld3fnnQevrRHNCxH/HctbVgrPv5BoFsH/RwdXZ9V4w4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=b2SfWOxjEUBGOQMBFl0eWmrxDRdoqendt3DIjYSYZwWazNAW2WhSmrOUh7vwIFEzG
 6NZdAtJgFACGbGAWnUHTL6EJzlkLc1W6Wq2n1iq9EXkTXPJpRcdapczHFenC78VnSx
 SKX/HNCV21jABeRSK16H0gpKexNwPolYgq4N3yunKhr5rA4TyMzi36E9ZQXQkeJKBX
 ktAhHy/pZxm+djce0W1TIEpn2TVyK0ElC3GL4sKd/euY6a6ptN/jfXM6pPY+sEhH4x
 szOvxC99qfk8Cczil1mCT1be44FwC7wxExZY07Zn6w6+/6LpKgI6RHhXib1CQPDh/O
 kO8TQp0IwSQlw==
Message-ID: <01934160-5194-4a74-867a-11da373a3630@kernel.org>
Date: Mon, 3 Aug 2026 10:12:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260606011942.1206814-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260606011942.1206814-1-daeho43@gmail.com>
X-Headers-End: 1wqiA9-0004pJ-PN
Subject: Re: [f2fs-dev] [PATCH v2] f2fs_io: add dev_alias command for
 dynamic device aliasing management
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Daeho, can you please update this patch to use last ioctl interface?

On 6/6/26 09:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> This commit adds a new 'dev_alias' command to f2fs_io tool to support
> dynamic inclusion, exclusion and status querying of device alias ranges.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: remove a f2fs specific flag from getflags.
> ---
>   tools/f2fs_io/f2fs_io.c | 46 +++++++++++++++++++++++++++++++++++++++++
>   tools/f2fs_io/f2fs_io.h |  7 +++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index c977f4d..3fa323b 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -2509,6 +2509,51 @@ static void do_test_lookup_perf(int argc, char **argv, const struct cmd_desc *cm
>   	exit(0);
>   }
>   
> +#define dev_alias_desc "device alias control"
> +#define dev_alias_help						\
> +"f2fs_io dev_alias [include|exclude|status] [file]\n\n"			\
> +"include, exclude or status a range of device alias given the file\n"
> +
> +static void do_dev_alias(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	int fd, ret;
> +
> +	if (argc != 3) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	fd = xopen(argv[2], O_RDWR, 0);
> +
> +	if (!strcmp(argv[1], "exclude")) {
> +		ret = ioctl(fd, F2FS_IOC_EXCLUDE_DEV_ALIAS);
> +		if (ret < 0)
> +			die_errno("F2FS_IOC_EXCLUDE_DEV_ALIAS failed");
> +		printf("%s device alias range of %s\n", argv[1], argv[2]);
> +	} else if (!strcmp(argv[1], "include")) {
> +		ret = ioctl(fd, F2FS_IOC_INCLUDE_DEV_ALIAS);
> +		if (ret < 0)
> +			die_errno("F2FS_IOC_INCLUDE_DEV_ALIAS failed");
> +		printf("%s device alias range of %s\n", argv[1], argv[2]);
> +	} else if (!strcmp(argv[1], "status")) {
> +		u32 status = 0;
> +
> +		ret = ioctl(fd, F2FS_IOC_GET_DEV_ALIAS_STATUS, &status);
> +		if (ret < 0)
> +			die_errno("F2FS_IOC_GET_DEV_ALIAS_STATUS failed");
> +
> +		printf("device alias status of %s: %s\n", argv[2],
> +			status == F2FS_DEV_ALIAS_STATUS_EXCLUDED ? "excluded" : "included");
> +	} else {
> +		fputs("Wrong request type\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	exit(0);
> +}
> +
>   #define freeze_desc "freeze filesystem"
>   #define freeze_help "f2fs_io freeze [directory_path]\n\n"
>   
> @@ -2603,6 +2648,7 @@ const struct cmd_desc cmd_list[] = {
>   	CMD(get_advise),
>   	CMD(ioprio),
>   	CMD(ftruncate),
> +	CMD(dev_alias),
>   	CMD(test_create_perf),
>   	CMD(test_lookup_perf),
>   	CMD(freeze),
> diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
> index b0d4099..57d96b7 100644
> --- a/tools/f2fs_io/f2fs_io.h
> +++ b/tools/f2fs_io/f2fs_io.h
> @@ -96,6 +96,9 @@ typedef u32	__be32;
>   #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
>   #define F2FS_IOC_GET_DEV_ALIAS_FILE	_IOR(F2FS_IOCTL_MAGIC, 26, __u32)
>   #define F2FS_IOC_IO_PRIO		_IOW(F2FS_IOCTL_MAGIC, 27, __u32)
> +#define F2FS_IOC_EXCLUDE_DEV_ALIAS	_IO(F2FS_IOCTL_MAGIC, 28)
> +#define F2FS_IOC_INCLUDE_DEV_ALIAS	_IO(F2FS_IOCTL_MAGIC, 29)
> +#define F2FS_IOC_GET_DEV_ALIAS_STATUS	_IOR(F2FS_IOCTL_MAGIC, 30, __u32)
>   
>   #ifndef FSCRYPT_POLICY_V1
>   #define FSCRYPT_POLICY_V1		0
> @@ -200,6 +203,10 @@ enum {
>   	F2FS_IOPRIO_WRITE = 1,  /* high write priority */
>   };
>   
> +/* for F2FS_IOC_GET_DEV_ALIAS_STATUS */
> +#define F2FS_DEV_ALIAS_STATUS_INCLUDED	0
> +#define F2FS_DEV_ALIAS_STATUS_EXCLUDED	1
> +
>   #ifndef FS_IMMUTABLE_FL
>   #define FS_IMMUTABLE_FL			0x00000010 /* Immutable file */
>   #endif



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
