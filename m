Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A505C4828D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Feb 2024 00:17:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rXs6H-0001AU-CU;
	Thu, 08 Feb 2024 00:17:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rXs6G-0001AO-4S
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Feb 2024 00:17:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wsjZZoiG5KTBz2iFXb/gdtjQVB57krENnMRb7VLv+TY=; b=DrngxqBTjsL4TZ1OCC0FkxWbmB
 vG7ThhBBX3hIiY5wTptCgllMLN2qbt2X5q8+kCSLIl7euSOEydNBKYXCMyhd83dHkx5ZLLx8hfhmF
 rAdDRULwJQuJL2vdbzJbEmpkdLy5ucB3yvYGrGPcWhgWkX+n4I/NgrLp4SSHIprC2Eeg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wsjZZoiG5KTBz2iFXb/gdtjQVB57krENnMRb7VLv+TY=; b=hgJIzyhImm3plvRZBAs2LJ0JUg
 Fclhz7PPxppXUPhwjhJnHUUUg68u/uVH1mLkeW1o8Da41zduloPVH+ZMxoON1OlxIgeD7XStsFghH
 4oZV/cOaX48+WPQmj76uzvBY5R1hT7ZrNPHBWqlVFz3Yf6lQSpyTc0DUy64ysbwIg4rQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rXs6B-0001wQ-I6 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Feb 2024 00:17:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CD55A61A53;
 Thu,  8 Feb 2024 00:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F04FC433C7;
 Thu,  8 Feb 2024 00:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707351418;
 bh=2egm5jFqueRjaknu6E3h71ZQadfGobiAaLx45nwM9Hw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EQzIFv1BZLrFWf4h0rnDxPP9adLZD6yoVFpeVsHTIpdoxkKoChEcGwXyQh0Zar9x5
 3qdzFj0z5ciW4kd15ko/hCrAuZbN1yc2cTa+jckrKHdKQgr0q08er/c2FPOfTApzV3
 1bSnlCsMZ9eIYTD/3wGAth+cZ4u3DNOY6VCympad9heCzANDrZQkLk5ADgZXRjwkPe
 /qeZJPMpJTRulmKCPtWpHnIFs3G5XvlOBE/oyAVb1XhwWxtrYUdhk3iMHnJPlvJaJz
 4EPM2jzGQtnM6NigHZ8Okd3SWrMVecicim94SFd0Q4SBrzos8ltLrrE7G5pbHgUo3F
 BeLWyix3PJghw==
Date: Wed, 7 Feb 2024 16:16:56 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Message-ID: <ZcQdeC4e7rnr9pCr@google.com>
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <1707271264-5551-5-git-send-email-zhiguo.niu@unisoc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1707271264-5551-5-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1rXs6B-0001wQ-I6
Subject: Re: [f2fs-dev] [PATCH v2 4/4] f2fs: stop checkpoint when get a
 out-of-bounds segment
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hongyu.jin@unisoc.com,
 niuzhiguo84@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 02/07, Zhiguo Niu wrote:
> There is low probability that an out-of-bounds segment will be got
> on a small-capacity device. In order to prevent subsequent write requests
> allocating block address from this invalid segment, which may cause
> unexpected issue, stop checkpoint should be performed.
> 
> Also introduce a new stop cp reason:  STOP_CP_REASON_OUTOF_RAGNE.

OUT_OF_RANGE?

> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/segment.c       | 12 ++++++++++--
>  include/linux/f2fs_fs.h |  1 +
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6772ad4..6fe2baf 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2666,7 +2666,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  		if (dir == ALLOC_RIGHT) {
>  			secno = find_first_zero_bit(free_i->free_secmap,
>  							MAIN_SECS(sbi));
> -			f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
> +			if (secno >= MAIN_SECS(sbi)) {
> +				f2fs_stop_checkpoint(sbi, false,
> +						STOP_CP_REASON_OUTOF_RAGNE);
> +				f2fs_bug_on(sbi, 1);
> +			}
>  		} else {
>  			go_left = 1;
>  			left_start = hint - 1;
> @@ -2682,7 +2686,11 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
>  		}
>  		left_start = find_first_zero_bit(free_i->free_secmap,
>  							MAIN_SECS(sbi));
> -		f2fs_bug_on(sbi, left_start >= MAIN_SECS(sbi));
> +		if (left_start >= MAIN_SECS(sbi)) {
> +			f2fs_stop_checkpoint(sbi, false,
> +					STOP_CP_REASON_OUTOF_RAGNE);
> +			f2fs_bug_on(sbi, 1);
> +		}
>  		break;
>  	}
>  	secno = left_start;
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 053137a0..72c6782 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -81,6 +81,7 @@ enum stop_cp_reason {
>  	STOP_CP_REASON_CORRUPTED_SUMMARY,
>  	STOP_CP_REASON_UPDATE_INODE,
>  	STOP_CP_REASON_FLUSH_FAIL,
> +	STOP_CP_REASON_OUTOF_RAGNE,
>  	STOP_CP_REASON_MAX,
>  };
>  
> -- 
> 1.9.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
