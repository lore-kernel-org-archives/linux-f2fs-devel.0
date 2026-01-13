Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD85D2F332
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Jan 2026 15:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqYzbGB6+zy0uD/wM+uVVyr30ycbIdQ0NPkSLqJuAiU=; b=e0uEw01e00E4dxCs9iT3WJ2PHz
	M+Sg4SkILU7tc+uW2Ig+5g1nmDoC3j3VtexaHJXyid7e0Wu9S7uXmjZ3vKAr6wWxQHeA6seytbSxL
	n8gHdrcDPs1W5ue59gzy34h+b1+hClYnbtIWBrmTdHUM6VrGbBJpStFEcFm3Q+Pm8Yek=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vfgEk-0006uE-W1;
	Tue, 13 Jan 2026 15:23:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+b9745b0d722f245fd565+8178+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1vfgEj-0006u5-Lw for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jan 2026 15:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r4deXc7HegwnHrb+EBuAAMgs1ckJi6PkLXe6iw1M+NE=; b=lRV1awblAzYlbZRcIPk8nystaC
 y4r99DA/w6ZBf2p1vvykL2PrHBSbuF2vJSJSFvhgp3fpn4zlOq1pS/y8kHcM3hwF3eaMxbBRIJMKt
 ItBHGhzjk8P6OZf96ANsVnUF5sSxJgQx8tOdH+qpO43cUPAWap0ZxIT7neVMMzGOFNqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r4deXc7HegwnHrb+EBuAAMgs1ckJi6PkLXe6iw1M+NE=; b=C8t8NERzc4Zl3umvMtu2e74sjB
 UJWn1HqFWqCDF+fwNBND5jqc9W6eptnZ28mlzsfmCPRKRdP7Dedj6s3w5Drd5zFP8T2iwLyBcfeLu
 IkfvQxbOeBPtuVXFFwksXUjKrBZ7nkYlRYXnMVSSIguoef6ua0FtfZxLlhuB9jqHpNc4=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vfgEj-00018L-0U for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Jan 2026 15:23:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=r4deXc7HegwnHrb+EBuAAMgs1ckJi6PkLXe6iw1M+NE=; b=CqNE+MCH7ZhGgwgkTP/P8umWVk
 dwtCfU4NnvIfozpQzLJxGDR54pOU3XX05XBY/XUIm2vNb9Eu+o7iuwfLbbpyXsX7u08mVtgnQoJu3
 JwFsxJl+AmjdWlIUOx1bEeWHnjOhlufPlaWAUcriAl6wWaS2IGI5XLbS28tKg6OpviX5HgX+0HRR2
 jT2g/OAwClSSrc+DfmSxXiuJg027czYo2I1XCZhqLZFLIg9qzt+shiIPExPx0vAEo0D8wmgmS2zpB
 nrz+EgCi4E3/ATHoCD8MApUxW8GUVC6dJEOsHLTU8jGKIrOJlgzRLpBK0paMpmriVTg+w3hBgEJ+6
 085uTIWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red
 Hat Linux)) id 1vfgEY-00000007MId-0i74;
 Tue, 13 Jan 2026 15:23:02 +0000
Date: Tue, 13 Jan 2026 07:23:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Message-ID: <aWZjVkb9fSigpW2L@infradead.org>
References: <20260112174629.3729358-1-cel@kernel.org>
 <20260112174629.3729358-3-cel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260112174629.3729358-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1vfgEj-00018L-0U
Subject: Re: [f2fs-dev] [PATCH v3 02/16] fat: Implement fileattr_get for
 case sensitivity
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
Cc: Jan Kara <jack@suse.cz>, pc@manguebit.org, yuezhang.mo@sony.com,
 cem@kernel.org, almaz.alexandrovich@paragon-software.com,
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, vira@web.codeaurora.org,
 sfrench@samba.org, slava@dubeyko.com, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, sprasad@microsoft.com, frank.li@vivo.com,
 linux-nfs@vger.kernel.org, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> +extern int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa);

No need for "extern" for function prototypes.

> +int fat_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
> +{
> +	struct msdos_sb_info *sbi = MSDOS_SB(dentry->d_sb);
> +
> +	/*
> +	 * FAT filesystems do not preserve case: stored names are

Is that actually true?  It's been a while since I deal with them,
but IIRC at least vfat is case preserving.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
