Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA56C00144
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Aug 2022 03:56:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oJRyf-0004ic-8N; Thu, 04 Aug 2022 03:56:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1oJRye-0004iS-2s
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 03:56:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F14ajoIt/Kptam10Sw1kyWLxq3j57vLWX+cN8OTPhys=; b=mCxkwAFa/Ei2giPGkGh3l45Fjs
 PRRjz3jFkpge0rjoWrhrZyYTz6UeIVCV9E1u9GNRuJM/28zDSIs8OSkWEt7a7ocp+7izSbCgaWe1C
 pZKr48XviNfH+KKWyFqNalyBq7nKogkbebnYk1+oyPcfTrZD9y6nGS3TpsfZ6vT32FTo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=F14ajoIt/Kptam10Sw1kyWLxq3j57vLWX+cN8OTPhys=; b=L00oCsRyTIqr8ZNgM0z1DpB0L2
 UWOGMoEHvCUeoEl4iaMVrA/76zxwLDLvLg4qy4h/JWTqE4jYKh4RHZU55VTP3Goc0ZAiF09J+2ajQ
 cQI/OxdVdrQtgNLomjUHTaA90dVi9ykLfOG1KoAIan1jF5Jr6QJ3c/p5mt5lo1nBaQek=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oJRyX-0003iD-Jr
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 03:56:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D2D69B8248F;
 Thu,  4 Aug 2022 03:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4121CC433D6;
 Thu,  4 Aug 2022 03:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659585397;
 bh=ZE63X+HpqSJiRhP61iaYy9y7WLLTkPFf7E1SvBXIbwE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Znb5rMZmSWKe8Uj+o5Q5nsBEOP1pBj10+v6lOUNmIr0ybY8eYQO/KonsOz1LJfsNk
 rPL0xGXFud7/gV27kqhtIpgSm+gLqgjI1PrGp9aEZZuP5HkWwBU9CZPj1qcRJgdHc1
 44+9sXG9NaQkzvmRsZszXY0Y0eEtsXMdrQgHthm4D7dWqias6N6jImoAoAhqSwt43S
 b0OxNl7fTSzW02SG1cazvIJQVpFA+YkY4Bu4dE8uuZL70E3D/CnXjrhLadF2/3wTme
 WIeYKDvTcQObxK6OA/5kGO+47P7Px1AsFLH/z5O4UIO9VSM/8FWkoKSuYgNtxjv/WH
 YpFOM5O1GOC3A==
Date: Wed, 3 Aug 2022 20:56:35 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: studentxswpy@163.com
Message-ID: <YutDc6n08xw0iG+3@google.com>
References: <20220801092202.3134668-1-studentxswpy@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220801092202.3134668-1-studentxswpy@163.com>
X-Headers-End: 1oJRyX-0003iD-Jr
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Replace kmalloc() with
 f2fs_kmalloc
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
Cc: Hacash Robot <hacashRobot@santino.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/01, studentxswpy@163.com wrote:
> From: Xie Shaowen <studentxswpy@163.com>
> 
> replace kmalloc with f2fs_kmalloc to keep f2fs code consistency.
> 
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: Xie Shaowen <studentxswpy@163.com>
> ---
>  fs/f2fs/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index d5bd7932fb64..712b51f69c04 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -232,7 +232,7 @@ static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
>  		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
>  			return -EINVAL;
>  
> -		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
> +		decrypted_name.name = f2fs_kmalloc(de_name_len, GFP_KERNEL);

Please fix the build breakage.

fyi;

static inline void *f2fs_kmalloc(struct f2fs_sb_info *sbi, size_t size, gfp_t flags)

>  		if (!decrypted_name.name)
>  			return -ENOMEM;
>  		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
