Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B6EC07548
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Nov 2023 07:21:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r3ADD-0001wC-Q9;
	Wed, 15 Nov 2023 07:21:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1r3ADC-0001w6-Ar
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Nov 2023 07:21:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nvMWSVp/2WioyWYiJDal3E/+DcNHvcQWvl1rrIlhxW0=; b=CqqtT/VDkk/4TgDCixZr1f7NGA
 oqN5szoz7ybOUcPTR7qWcH8eD1SS/6BcySp+MbnhX2InPNeLTj7POVZec2ARHGFCnfp4vPuSkVljJ
 8Wc6gGbHoIHgJ/ccI1dn3SQZw6AwCylBqtO49gApoo7tZMOnGxQY2VCBuD12gKkdt8vM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nvMWSVp/2WioyWYiJDal3E/+DcNHvcQWvl1rrIlhxW0=; b=VCvC3iKbG6RD/ju2/ceGs5wuqf
 GNGuDbqVd0naHFTzWYwp+qf6xzMOl8Hu034pgu4Oqu9qpnRZRCfjT53DgOwoq7ArluWvcXYDsKUWJ
 mtjpCSLOVW8Xq6DWxSwx63CT90fO/YUxLi/Gm9YQkSy3HZ9JgXrVZmCftc/yX+VTgO3k=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r3ADB-006D2t-VX for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Nov 2023 07:21:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9602A61558
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 15 Nov 2023 07:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3418FC433CB;
 Wed, 15 Nov 2023 07:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700032875;
 bh=B+MTC8/o1uOUvf3j6sGWEkznz//HoKB9SaTe9VoUDu4=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=K+pCWTBVzY4hPro/ZMyI+roysuNJnXvhReTwaRRNxz2pVKYMyz9fX9/S7B0ACzGxO
 GCl4J2dDhBCCyYQRGWRQp+JQGSD+lTWzKNfFXLGLSCNq2qzSqVGD5RUn4R0q6B3BgJ
 ChdVfPQ38V8a5hMuHyPYgizfRrcX52mziHQxD5ZgROUD1+rnnr922krFi76U1YVcxJ
 VpTb8Un194dM/Zw+261OSlPpmPe33QaAGL6QNy9gYIlUDZ7kHyWYldD+oCVxq5Dkuw
 ws2sHUnhkheug1MhW4oRPEV5Ok63IUVc8QHxVu4ke4CPWl2jm8ExTs8l9nWxoeK0Nh
 r4narNWycFvVg==
Message-ID: <9d6502f2-f47c-d4af-347f-76bb8e39fe24@kernel.org>
Date: Wed, 15 Nov 2023 15:21:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20231020012213.2606422-1-jaegeuk@kernel.org>
 <ZTHoeBTX7SlbIxOg@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZTHoeBTX7SlbIxOg@google.com>
X-Headers-End: 1r3ADB-006D2t-VX
Subject: Re: [f2fs-dev] [PATCH v2] f2fs_io: add list/setattr command
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/10/20 10:39, Jaegeuk Kim wrote:
> Let's add list/set/removexattrs commands.

It looks it missed to add related description in man/f2fs_io.8.

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
>   - add removexattrs
> 
>   tools/f2fs_io/f2fs_io.c | 107 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 107 insertions(+)
> 
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index c812aa1458a2..e7d286a67939 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -35,6 +35,7 @@
>   #include <termios.h>
>   #include <time.h>
>   #include <unistd.h>
> +#include <sys/xattr.h>
>   
>   #ifdef HAVE_CONFIG_H
>   #include <config.h>
> @@ -1526,6 +1527,109 @@ static void do_gc_range(int argc, char **argv, const struct cmd_desc *cmd)
>   	exit(0);
>   }
>   
> +#define listxattr_desc "listxattr"
> +#define listxattr_help "f2fs_io listxattr [file_path]\n\n"
> +
> +static void do_listxattr(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	char *buf, *key, *val;
> +	ssize_t buflen, vallen, keylen;
> +
> +	if (argc != 2) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	buflen = listxattr(argv[1], NULL, 0);
> +	if (buflen == -1) {
> +		perror("listxattr");
> +		exit(1);
> +	}
> +	if (buflen == 0) {
> +		printf("%s has no attributes.\n", argv[1]);
> +		exit(0);
> +	}
> +	buf = xmalloc(buflen);
> +	buflen = listxattr(argv[1], buf, buflen);
> +	if (buflen == -1) {
> +		perror("listxattr");
> +		exit(1);
> +	}
> +
> +	key = buf;
> +	while (buflen > 0) {
> +		printf("%s: ", key);
> +		vallen = getxattr(argv[1], key, NULL, 0);
> +		if (vallen == -1) {
> +			perror("getxattr");
> +			exit(1);
> +		}
> +		if (vallen == 0) {
> +			printf("<no value>");
> +		} else {
> +			val = xmalloc(vallen + 1);
> +			vallen = getxattr(argv[1], key, val, vallen);
> +			if (vallen == -1) {
> +				perror("getxattr");
> +				exit(1);
> +			}
> +			val[vallen] = 0;
> +			printf("%s", val);
> +			free(val);
> +		}
> +		printf("\n");
> +		keylen = strlen(key) + 1;
> +		buflen -= keylen;
> +		key += keylen;
> +	}
> +	exit(0);
> +}
> +
> +#define setxattr_desc "setxattr"
> +#define setxattr_help "f2fs_io setxattr [name] [value] [file_path]\n\n"
> +
> +static void do_setxattr(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	int ret;
> +
> +	if (argc != 4) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	ret = setxattr(argv[3], argv[1], argv[2], strlen(argv[2]), XATTR_CREATE);
> +	printf("setxattr %s CREATE: name: %s, value: %s: ret=%d\n",
> +			argv[3], argv[1], argv[2], ret);
> +	if (ret < 0 && errno == EEXIST) {
> +		ret = setxattr(argv[3], argv[1], argv[2], strlen(argv[2]), XATTR_REPLACE);
> +		printf("setxattr %s REPLACE: name: %s, value: %s: ret=%d\n",
> +				argv[3], argv[1], argv[2], ret);
> +	}
> +	if (ret < 0)
> +		perror("setxattr");
> +	exit(0);
> +}
> +
> +#define removexattr_desc "removexattr"
> +#define removexattr_help "f2fs_io removexattr [name] [file_path]\n\n"
> +
> +static void do_removexattr(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	int ret;
> +
> +	if (argc != 3) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	ret = removexattr(argv[2], argv[1]);
> +	printf("removexattr %s REMOVE: name: %s: ret=%d\n", argv[1], argv[2], ret);
> +	exit(0);
> +}
> +
>   #define CMD_HIDDEN 	0x0001
>   #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
>   #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
> @@ -1564,6 +1668,9 @@ const struct cmd_desc cmd_list[] = {
>   	CMD(precache_extents),
>   	CMD(move_range),
>   	CMD(gc_range),
> +	CMD(listxattr),
> +	CMD(setxattr),
> +	CMD(removexattr),
>   	{ NULL, NULL, NULL, NULL, 0 }
>   };
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
