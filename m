Return-Path: <SRS0=I8Ey=OS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD298C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Sep 2021 15:33:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8622E61246;
	Tue, 28 Sep 2021 15:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8622E61246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mVF6O-0003TU-1j; Tue, 28 Sep 2021 15:33:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mVF6M-0003TJ-Bi
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Sep 2021 15:33:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/443FhvSZIjrLp/R2gZhEmuF6e1cNY1c1GsZrzFNkiY=; b=S0xCr/5/8q/M74ZxGalV/miPek
 AjiBevbqFGVoiujPSP4znCqFToZ6X5lWSEW/5HnRWYd480ox32sptLsZEj5ZK9sZgqbydfo0rbIfD
 vYZRM/qsj4u7YztOZ0OheBEdVAr5cmxxMQhnnCB131oNf10GvuZeAND0tC8//YvRAy/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/443FhvSZIjrLp/R2gZhEmuF6e1cNY1c1GsZrzFNkiY=; b=fBq/aNYhHAEcVUbXTN4y6DkuTp
 erJbD9qeScXFr6vQuUD3macIYchAcychmgkDmBKF71loyJ+/YzWGsrtKOVsgaqdiMrBDT95QKF/xd
 jd45U0Zrb7R1CKDcaIuKMoJ+FnJ7TAkrgUt0PC/YoMheVMrzCl4clVaPMVcXS7Fj4scI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mVF6I-0006LO-Sp
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Sep 2021 15:33:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A795B610FC;
 Tue, 28 Sep 2021 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632843173;
 bh=vWkuPqxX+KKehbXBzNOpyQAfyzSReiJuMLJfas8IHIg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=eLHUPT0zyanEQDnYLr0UR6Dc+bdnWriVtaiHlAGatvG32DfGkFqa4Rz2AmMCQIH8X
 kLXT797LCEsTkQdXGczLAdwUjhGLJYQvsdeW005e0X5JEb8AsFpY8r39k7nt2HuD3Z
 BN4qYneRIJTUIqF1HEV27I8KW3Olvvs7PClQ/LE36nH6rqZgdGiYcg4Rh+DpRf5Eyb
 x6cQ7Xcg1JsPLWEu248j2WXqttMoQHxV5P5QKxPuEIQ1S8yYWweQ+zhSV/WcdyDfG0
 c8PsUYbjbtD1bXh1FRLFe2HUVmAyrhDQbxOYSYFs37tJrDD8vJcMq2iQ2eckBewyZW
 DK0kBCndov1hQ==
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20210927060905.68318-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <6c114c4d-7e02-9d4e-7308-0810aa31339d@kernel.org>
Date: Tue, 28 Sep 2021 23:32:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927060905.68318-1-changfengnan@vivo.com>
Content-Language: en-US
X-Headers-End: 1mVF6I-0006LO-Sp
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix whint_mode mount option error
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
Cc: tanghuan <tanghuan@vivo.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/9/27 14:09, Fengnan Chang wrote:
> When mount with whint_mode option, it doesn't work, Fix it.
> Fixes: d0b9e42ab615 (f2fs: introduce inmem curseg)

Thanks for the patch, it looks Keoseong Park has submitted the same
fix patch a little bit earlier....

I guess we need to select one of your patches, and merge Singed-off
and Reported tags from another one.

Thanks,

> 
> Reported-by: tanghuan <tanghuan@vivo.com>
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> ---
>   fs/f2fs/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 78ebc306ee2b..86eeb019cc52 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1292,7 +1292,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   	/* Not pass down write hints if the number of active logs is lesser
>   	 * than NR_CURSEG_PERSIST_TYPE.
>   	 */
> -	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_TYPE)
> +	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_PERSIST_TYPE)
>   		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
>   
>   	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
