Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F8FCA9EC7
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Oct 2026 08:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pOvoE17xH28M2xEw9wGsOS/2T4MoGd0m6GTAsmaBDOg=; b=NfUAF/Nz/CkERBgE0i91HNFEYR
	OeDgUGePKfpYZPxyFI5beWU3EESV1+8ob5iDZVtvNhwqtn6934zgAqe8DfDFS+cilEMNhMA7rDPUV
	wcVAkCdlAiiRnFdQ/Z1ZluFm+uLiEWYawESKIDzNlp63ROgOqGe9DsPRnCiwPfjqvEQI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFojP-0004nG-Of;
	Sun, 11 Oct 2026 08:16:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xFojO-0004n2-Gu
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 08:16:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4WcCA1E0CSTBkfr6toll4II58krvvlbL+7BiwRn1ctM=; b=J2MnGC26yZgYiIZJ4G16AiH4iD
 w6W8umPy/FCVTTo7F6rQZLh7115e3VYXfbM1+E7mdvcn+TiX4nt+aYwbfyaAl1sFFYCgApVx7e6kx
 /C0AukCR15KEyU/0o4kCJxghgtkrCgihf0ZyxiJLbtHneIlqhmUKdpkeYLRJ3uQF324k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4WcCA1E0CSTBkfr6toll4II58krvvlbL+7BiwRn1ctM=; b=SFfo6puJL9cJfND+o4IxOwaOVb
 d8DPLAFT+NhYp1q+34KE7o+EPoDW6lxfQ2Uoi7nXjUC1JnOLvxnLX52wMN+9q/0RbVegb51Y/kQto
 kYAEH02T2iPzj6r44KBTQhsMkWLvR3E15eCWIAMDZ5s7xS98jw32dg3YkFTd7DjKxB3I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFojO-0004tf-PE for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 08:16:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26AC8600E2;
 Sun, 11 Oct 2026 08:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D7E1F0089C;
 Sun, 11 Oct 2026 08:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791706584;
 bh=4WcCA1E0CSTBkfr6toll4II58krvvlbL+7BiwRn1ctM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=FxKMtJGa03OWcEHZIJL8VNOlf8cGdliveQCweEt85vANZ55UR7DNgCk63TlzlbsUT
 5Xed5gFDhaDOpQaPJTfes6B5Pf10EN3UtPCTQjx1sbku9a5LktvJBTx1BD/KD5SPhH
 Jlai2WUK6P/4ngxfTET4Ov3FDyHJPShOoof48dliBb9qrrPnAucBuF3lHJZjkQLRrx
 /121ePCIkRNbkh+ewsLndifgFQigqoH2TvzEJ4NoRxGVYBXWs1B2HpA26nPoI6ybtq
 gxqdIj9xM8ZL7ESDZ2edeWYVbC5ztuBFVa16YXxvuNwbv8bfuSc9yT26hC6I6pLOQQ
 sXM0WFoxgqatA==
Message-ID: <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
Date: Sun, 11 Oct 2026 16:16:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>, jaegeuk@kernel.org
References: <20261004061007.7433-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20261004061007.7433-1-jsjlee1020@gmail.com>
X-Headers-End: 1xFojO-0004tf-PE
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
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
Cc: linux-kernel@vger.kernel.org, yi.sun@unisoc.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/4/26 14:10, Seongjae Jeong wrote:
> When update_sit_entry_for_release() encounters a block whose bit is
> already cleared in cur_valid_map, it reports the inconsistency and
> corrects se->valid_blocks and del. However, it still proceeds with
> the discard bitmap and checkpoint accounting updates.
> 
> This can clear the discard bit unnecessarily and incorrectly decrement
> the segment and section ckpt_valid_blocks counters when the block is
> not marked in ckpt_valid_map.
> 
> Continue to the next block after correcting se->valid_blocks and del,
> so that an already invalidated block does not trigger further discard
> bitmap or checkpoint counter updates.
> 

Cc stable.

> Fixes: 81ffbd224e5f ("f2fs: update_sit_entry_for_release() supports consecutive blocks.")

This commit didn't change previous logic? IIUC.

Otherwise it looks good to me.

Thanks,

> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
> ---
>   fs/f2fs/segment.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 51858f64e43e..fc2f0fd8e318 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2560,7 +2560,10 @@ static int update_sit_entry_for_release(struct f2fs_sb_info *sbi, struct seg_ent
>   			f2fs_bug_on(sbi, 1);
>   			se->valid_blocks++;
>   			del += 1;
> -		} else if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> +			continue;
> +		}
> +
> +		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>   			/*
>   			 * If checkpoints are off, we must not reuse data that
>   			 * was used in the previous checkpoint. If it was used



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
