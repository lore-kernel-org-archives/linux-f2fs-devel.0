Return-Path: <SRS0=6Xs1=NI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7936DC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:33:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F6D460F39
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3F6D460F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFn3C-0003i2-2Y; Tue, 17 Aug 2021 00:33:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1mFn3A-0003hv-UQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 00:33:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NcIEl2LM1TebjZgSO9oP+JCAb5lPCN8L4FAuemQAfn4=; b=T//cQddhxkzCeZxRKfQqj/vXce
 pvqwJNcH/aSlAAFU7e83yCJzuFzlmZaXGB2DYa4N2eGcket+StCsxp7x9InkpGdtOnQfL3Gi4Ke5g
 gruMi2lKxxEK4tlj8tQ5r9V9PQFn3/3htFbsU6Vdv2P7VqDeSSQHlIBz/KZxO/ziCNmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NcIEl2LM1TebjZgSO9oP+JCAb5lPCN8L4FAuemQAfn4=; b=VEy5+YwcwblZnW+ByNUXHfofSG
 I3WLL5Hb5Y+TkOGVJQ7yL1K6Ammd+Ys1zTPPetI70wzu4/n337TP4i4Fh93nZ5OJ1jA46vMSuqQV3
 qWlfEP5dQUlf8xNMET6jFgRzzh1CCxG+Lqm9dnBWkVLJ4+SXbgfOgiNJ5vDni32TRk8E=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFn3B-0006Mk-1b
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 00:33:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AC3B60F55;
 Tue, 17 Aug 2021 00:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629160426;
 bh=0WyoP9C0dbqqhcVR2hK/9OHEIvTuu5XMiMVutsFRIiI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lwyo1UD5tdAsySWy2W6wOGyPUwMm3rKPc9MI+AqHQtUDGBtJUOu6XrMMC1YpXVqPh
 bs8wc3zv0ZhP81A/loZzCY5UIFheFlJ1u2JDD7+HpJc7mvkWHFSudN/Z7zRxUKHg+j
 aWuJcTc/EeD8bEzzCDgd+bI82BVMQTUZE18HlCuhXD9lpGG7U9gzzMQ8VyLuLuWzxF
 Kx8i4h8prLkzhc9k4qypdWf46N7xYKEysdwpGdsA9G8h0J2BtCqyfm5l27/Oy0S6xU
 j2d4K570gSahuBncmdkDISA/mTpKAIEV5tO2KXUgp+BpuUzQjgi3CwU8CfCqyZ9Jf9
 uhgxi2kCN9jlw==
Date: Mon, 16 Aug 2021 17:33:44 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Message-ID: <YRsD6P4x9v38oDWl@google.com>
References: <20210816234247.139528-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816234247.139528-1-nathan@kernel.org>
X-Headers-End: 1mFn3B-0006Mk-1b
Subject: Re: [f2fs-dev] [PATCH] f2fs: Add missing inline to
 f2fs_sanity_check_cluster() stub
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Nathan,

On 08/16, Nathan Chancellor wrote:
> Without this, there is a warning in nearly every fs/f2fs/ file when
> F2FS_FS_COMPRESSION is not set:
> 
> In file included from fs/f2fs/super.c:31:
> fs/f2fs/f2fs.h:4251:13: warning: unused function 'f2fs_sanity_check_cluster' [-Wunused-function]
> static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
>             ^
> 1 warning generated.
> 
> Fixes: 1495870233e7 ("f2fs: compress: do sanity check on cluster")

This has not been merged yet, so if you don't mind, can I integrate your fix in
the original patch?

Thanks,

> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 0c978f934dcc..fe1097e678da 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4248,7 +4248,7 @@ static inline void f2fs_put_page_dic(struct page *page)
>  	WARN_ON_ONCE(1);
>  }
>  static inline unsigned int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn) { return 0; }
> -static bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
> +static inline bool f2fs_sanity_check_cluster(struct dnode_of_data *dn) { return false; }
>  static inline int f2fs_init_compress_inode(struct f2fs_sb_info *sbi) { return 0; }
>  static inline void f2fs_destroy_compress_inode(struct f2fs_sb_info *sbi) { }
>  static inline int f2fs_init_page_array_cache(struct f2fs_sb_info *sbi) { return 0; }
> 
> base-commit: f4b05791dda93edb03ebb6b48f1be104b2e64274
> -- 
> 2.33.0.rc2


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
