Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC53C77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Apr 2023 16:07:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ppWoL-0003TY-Sz;
	Thu, 20 Apr 2023 16:07:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ppWoK-0003TS-A4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Apr 2023 16:07:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AaxQqXjXwSivRI3VTOGi793L85HLDzmxt4tdxEzFC1U=; b=jzYP3GVNPYlBO9BwI4U9sZLnfh
 p89wUor5W2xrtd3RrddvPzBDqoSLIPuXibg9j+ZKmDQyZ7YcXBJsea++6FHqKAeDB5mQiFslDkJzq
 f9ygR6lNLzLp05l/rFRslkFzc3882E5UShZlWEfV0jVDSuvCxS1lo15RxbtxFWUO3GJg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AaxQqXjXwSivRI3VTOGi793L85HLDzmxt4tdxEzFC1U=; b=D1On1SlCXPxW9E25pb7UB9GjTg
 RNpeE5BzPi9fLT7Iw0LdKWNkMpO/VoVCKSjLvE6EyuSOU0EinKMK0nRAPeBKCSu6criXK46PJawme
 oTEZDuoxjVbbFLe2Dat4+5WfyCgJEC6RxOv18hrsCljr9+s19DjvR1+yDK6N1+M32GIw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ppWoJ-00Df8H-HV for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Apr 2023 16:07:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5F99764A63;
 Thu, 20 Apr 2023 16:06:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B36C433D2;
 Thu, 20 Apr 2023 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682006812;
 bh=eezJJknDGU+S0da2i2w6pTbFZ1YIFA5bKEQ4E7wFkDk=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=ckadDX5b/4cjV0As8IbbTsST375M3EwUQ8tEG/yyO0FbTw6w1GXPX8O69b4ZhIz7l
 GRj9wpynaqPq5HZGQcNdHtxj8qxY9z1Y0uFNm/AsubjLxkOr7w/N39ZuPQwGUsWeO2
 wjYohi1LEyvHyWN+t357aJqRp8cyTOg7x/6SUA/+PD0tPr1Xo7ubWbvfrn5+lPwT02
 OZs8I0xj6DgnQqFgD1C5exlEZLSGFPJ9eVpXVmh95NVct2ief/xNOmFKkVgl4OxIZX
 v1r07S01ejIvvpD4SXibRz4tvtYul+0/woGSyoScP9MBhmryNOPlwynFIMoxSEZlXt
 kknjRYkIolBgw==
Message-ID: <8da92504-a9db-4ca6-0979-039ba7a4c0fc@kernel.org>
Date: Fri, 21 Apr 2023 00:06:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Juhyung Park <qkrwngud825@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230404055446.1656296-1-qkrwngud825@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230404055446.1656296-1-qkrwngud825@gmail.com>
X-Headers-End: 1ppWoJ-00Df8H-HV
Subject: Re: [f2fs-dev] [PATCH] fsck.f2fs: fix sanity check logic for
 cp_payload
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
Cc: Alexander Koskovich <akoskovich@pm.me>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/4 13:54, Juhyung Park wrote:
> cp_payload is set differently [1] when extended node bitmap feature is
> enabled. Commit b79c3ba4ea9d broke fsck on f2fs file systems created on
> 2+ TB device with extended node bitmap feature enabled.
> 
> As the sanity check is for checking overflows, fix this to assume the max
> possible cp_payload size under the extended node bitmap.
> 
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/tree/mkfs/f2fs_format.c?h=v1.15.0#n372 [1]
> Fixes: b79c3ba4ea9d ("fsck.f2fs: sanity check cp_payload before reading checkpoint")
> Reported-by: Alexander Koskovich <akoskovich@pm.me>
> Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>
> ---
>   fsck/mount.c      | 2 +-
>   include/f2fs_fs.h | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 2b26701..df0314d 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -1208,7 +1208,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
>   	int ret;
>   
>   	cp_payload = get_sb(cp_payload);
> -	if (cp_payload > F2FS_BLK_ALIGN(MAX_SIT_BITMAP_SIZE))
> +	if (cp_payload > F2FS_BLK_ALIGN(MAX_CP_PAYLOAD))
>   		return -EINVAL;
>   
>   	cp_blks = 1 + cp_payload;
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 333ae07..f890634 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -1168,6 +1168,10 @@ static_assert(sizeof(struct f2fs_nat_block) == 4095, "");
>   #define MAX_SIT_BITMAP_SIZE    (SEG_ALIGN(SIZE_ALIGN(F2FS_MAX_SEGMENT, \
>   						SIT_ENTRY_PER_BLOCK)) * \
>   						c.blks_per_seg / 8)
> +#define MAX_CP_PAYLOAD         (SEG_ALIGN(SIZE_ALIGN(UINT32_MAX, NAT_ENTRY_PER_BLOCK)) * \
> +						DEFAULT_NAT_ENTRY_RATIO / 100 * \

DEFAULT_NAT_ENTRY_RATIO is 20 now, if we change it to 100 later,
old fsck will still report error on a new image?

Should we remove "DEFAULT_NAT_ENTRY_RATIO / 100"?

Thanks,

> +						c.blks_per_seg / 8 + \
> +						MAX_SIT_BITMAP_SIZE - MAX_BITMAP_SIZE_IN_CKPT)
>   
>   /*
>    * Note that f2fs_sit_entry->vblocks has the following bit-field information.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
