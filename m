Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7639C77B7F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 May 2023 12:33:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1puucZ-00076X-6n;
	Fri, 05 May 2023 12:33:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1puucY-00076Q-6G
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 12:33:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QwJL3AaPFIkPQBKJJ0ggRIxMmET/1TIwgfDD5Oal4wc=; b=lfaDGqnlaLXVJGBgr/0HmMCeRJ
 DwhMoP33y4WWap5Cbff1eoy1Uj5jOTCA7cFS2vPgiTV+AZro+QQqE97UA6Yno1o5AbQuRI1ggWARX
 StsbOYqaCqSTAmzZxawn0HmKmnCKiamTSF7OFalFEot5rqFnBgDmSJKj9t4BuAl+exck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QwJL3AaPFIkPQBKJJ0ggRIxMmET/1TIwgfDD5Oal4wc=; b=PCOpw5ztjdD+/SdlmONtxxDF1X
 nyca36Bzj8epTFCqsoJPA0sA4OmkKTSxwRabc0jTszTru+91fFrUWGj74rjcm9whzXUaxZdHCy3J6
 fGtNI5HLKcotIDdcc7pqYMRW+Xcwdh7O1zQ7BO2+LU2t3Iw9r6mdOT7au7r/PS+FdxPw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1puucX-00FEVW-Cf for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 05 May 2023 12:33:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 06A2F60B66;
 Fri,  5 May 2023 12:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6010C433D2;
 Fri,  5 May 2023 12:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683289983;
 bh=pKG4Mf1bb5gbOdPLge/zmMjdEqspBKyucO7r0APgGMg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AAVyB+eImxXSdHKQeX+a1ytJ4aYUF9jejBsjDavPyRP/Iw66yBoHdGaAdCgMtcfHe
 pe1LKTN5L7iwKKjqDVOHsYZv/JMy2R3fjU4k51bb5whcW8OMF6ttJbWkt4PIxE4SXG
 wazkSXjR4yEtht1pX+SC9I0GI/wX7Aki7HtFjilD2ym5IMejQHQsS4EOtxIby3HoeF
 hgqkMuaEmmJbBQSzmN053FwY9hdXyj+inDCUViWfJnkLQjlbUESp6McmwCT7Vw2hct
 YPxyHx0XF9x5ATo8JhPG7+z8N2y5eluoZWTT2Pg292pSIAHAyd01xux0hoKiazayKc
 opd0qZyraVjEQ==
Message-ID: <d853431a-897c-71b2-d97f-5572bd7f79cb@kernel.org>
Date: Fri, 5 May 2023 20:32:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230504144406.33713-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230504144406.33713-1-frank.li@vivo.com>
X-Headers-End: 1puucX-00FEVW-Cf
Subject: Re: [f2fs-dev] [PATCH] f2fs_io: support move_range command
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

On 2023/5/4 22:44, Yangtao Li wrote:
> This patch supports a new sub-command 'move_range' in f2fs_io
> to move a range of data blocks from source file to destination
> file via F2FS_IOC_MOVE_RANGE ioctl.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>   man/f2fs_io.8           |  4 ++++
>   tools/f2fs_io/f2fs_io.c | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+)
> 
> diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
> index 13d4bf3..b25f807 100644
> --- a/man/f2fs_io.8
> +++ b/man/f2fs_io.8
> @@ -138,8 +138,12 @@ Trigger filesystem GC
>   .TP
>   \fBcheckpoint\fR \fI[file]\fR
>   Trigger filesystem checkpoint
> +.TP
>   \fBprecache_extents\fR \fI[file]\fR
>   Trigger precache extents
> +.TP
> +\fBmove_range\fR \fI[src_path] [dst_path] [src_start] [dst_start] [length]\fR
> +Move a range of data blocks from source file to destination file
>   .SH AUTHOR
>   This version of
>   .B f2fs_io
> diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
> index ac7b588..d545d8e 100644
> --- a/tools/f2fs_io/f2fs_io.c
> +++ b/tools/f2fs_io/f2fs_io.c
> @@ -1357,6 +1357,40 @@ static void do_precache_extents(int argc, char **argv, const struct cmd_desc *cm
>   	exit(0);
>   }
>   
> +#define move_range_desc "moving a range of data blocks from source file to destination file"
> +#define move_range_help						\
> +"f2fs_io move_range [src_path] [dst_path] [src_start] [dst_start] [length]\n\n"		\

It's better to wrap the long line as below?

#define move_range_help							\
"f2fs_io move_range [src_path] [dst_path] [src_start] [dst_start] "	\
"[length]\n\n"								\

Thanks,

> +"  src_path  : path to source file\n"					\
> +"  dst_path  : path to destination file\n"				\
> +"  src_start : start offset of src file move region, unit: bytes\n"	\
> +"  dst_start : start offset of dst file move region, unit: bytes\n"	\
> +"  length    : size to move\n"						\
> +
> +static void do_move_range(int argc, char **argv, const struct cmd_desc *cmd)
> +{
> +	struct f2fs_move_range range;
> +	int ret, fd;
> +
> +	if (argc != 6) {
> +		fputs("Excess arguments\n\n", stderr);
> +		fputs(cmd->cmd_help, stderr);
> +		exit(1);
> +	}
> +
> +	fd = xopen(argv[1], O_RDWR, 0);
> +	range.dst_fd = xopen(argv[2], O_RDWR | O_CREAT, 0644);
> +	range.pos_in = atoi(argv[3]);
> +	range.pos_out = atoi(argv[4]);
> +	range.len = atoi(argv[5]);
> +
> +	ret = ioctl(fd, F2FS_IOC_MOVE_RANGE, &range);
> +	if (ret < 0)
> +		die_errno("F2FS_IOC_MOVE_RANGE failed");
> +
> +	printf("move range ret=%d\n", ret);
> +	exit(0);
> +}
> +
>   #define CMD_HIDDEN 	0x0001
>   #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
>   #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
> @@ -1391,6 +1425,7 @@ const struct cmd_desc cmd_list[] = {
>   	CMD(gc),
>   	CMD(checkpoint),
>   	CMD(precache_extents),
> +	CMD(move_range),
>   	{ NULL, NULL, NULL, NULL, 0 }
>   };
>   


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
