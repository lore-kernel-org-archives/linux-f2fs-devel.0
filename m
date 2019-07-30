Return-Path: <SRS0=dVfM=V3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D997C433FF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Jul 2019 08:45:10 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB5B4206A2;
	Tue, 30 Jul 2019 08:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="KYZDmkmO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Bfx7EGR4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB5B4206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hsNkr-0006Bs-8Z; Tue, 30 Jul 2019 08:45:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <hirofumi@parknet.co.jp>)
 id 1hsNkp-0006Bh-ND; Tue, 30 Jul 2019 08:45:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:In-Reply-To:
 Date:References:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Eza2nU14ZlGk3a3LJIDfvjzgvs1quWrC2jQ+p/Z0QnM=; b=KYZDmkmObineq43/F2nCd6nY8Y
 H/V2mmLi+W3KaaZXL9r/hTp3EJb3Xz6+DFdb1fjejcAnwfQXVwKV/G/HUsVkBBDd/Gd5AlQoVVObw
 uv1yak6n0acqChTndegSOqFzHsPc3mQMQa7GJnOYP4c5GUOSaaf1OcJi47I38x8LFoTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:In-Reply-To:Date:References:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Eza2nU14ZlGk3a3LJIDfvjzgvs1quWrC2jQ+p/Z0QnM=; b=Bfx7EGR4SNmf+hAAWKw9mwIIlt
 2BPN6vGfEd6TzdLb5jh3QJJ9GboB7DaBBLEaBfETUxC2ZRFW4BE2lgN0AMCX8ol1Uoa4ELeJIN6JJ
 apnHVeuKuwJeNwYKSK6kd9J+s32s24SSaE/UcDv5zJDfJYpq43S1JhODmvqvGTMqd0C4=;
Received: from mail.parknet.co.jp ([210.171.160.6])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1hsNkm-004CUU-2I; Tue, 30 Jul 2019 08:45:07 +0000
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
 by mail.parknet.co.jp (Postfix) with ESMTPSA id 9A60115F924;
 Tue, 30 Jul 2019 17:27:05 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
 by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id
 x6U8R47a029798
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2019 17:27:05 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
 by devron.myhome.or.jp (8.15.2/8.15.2/Debian-12) with ESMTPS id x6U8R4HR032190
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 30 Jul 2019 17:27:04 +0900
Received: (from hirofumi@localhost)
 by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id x6U8R0Qq032189;
 Tue, 30 Jul 2019 17:27:00 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Deepa Dinamani <deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-4-deepa.kernel@gmail.com>
Date: Tue, 30 Jul 2019 17:27:00 +0900
In-Reply-To: <20190730014924.2193-4-deepa.kernel@gmail.com> (Deepa Dinamani's
 message of "Mon, 29 Jul 2019 18:49:07 -0700")
Message-ID: <87d0hsapwr.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
X-Headers-End: 1hsNkm-004CUU-2I
Subject: Re: [f2fs-dev] [PATCH 03/20] timestamp_truncate: Replace users of
 timespec64_trunc
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
Cc: arnd@arndb.de, dedekind1@gmail.com, y2038@lists.linaro.org,
 gregkh@linuxfoundation.org, adrian.hunter@intel.com,
 linux-kernel@vger.kernel.org, tj@kernel.org, linux-mtd@lists.infradead.org,
 viro@zeniv.linux.org.uk, richard@nod.at, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-ntfs-dev@lists.sourceforge.net, hch@lst.de, anton@tuxera.com,
 jlbec@evilplan.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Deepa Dinamani <deepa.kernel@gmail.com> writes:

> diff --git a/fs/fat/misc.c b/fs/fat/misc.c
> index 1e08bd54c5fb..53bb7c6bf993 100644
> --- a/fs/fat/misc.c
> +++ b/fs/fat/misc.c
> @@ -307,8 +307,9 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
>  		inode->i_atime = (struct timespec64){ seconds, 0 };
>  	}
>  	if (flags & S_CTIME) {
> -		if (sbi->options.isvfat)
> -			inode->i_ctime = timespec64_trunc(*now, 10000000);
> +		if (sbi->options.isvfat) {
> +			inode->i_ctime = timestamp_truncate(*now, inode);
> +		}
>  		else
>  			inode->i_ctime = fat_timespec64_trunc_2secs(*now);
>  	}

Looks like broken. It changed to sb->s_time_gran from 10000000, and
changed coding style.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
