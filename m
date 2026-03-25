Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A6A109C028
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RG9rG2AZAAEa5Kebjy08mWZ/X9FQ9pFYItHrUXEXYDc=; b=YbswrzqaKk6veo9T2vHk4+mBca
	Dwji1pQpdzgXcOBYRCmn7IdjQnqbkT1BoWMb92P/qBq6TsIF0HinUFaUQ0KrVGlNpiGM0y0QtjCCm
	/5HKcRQpLQXQDsD5lW2pmZ2vDx6z+AhgQ8xF2Pqh8VbUwrhO0iiGUfuXlm2JaoyPEalo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5Plj-0005tH-3r;
	Wed, 25 Mar 2026 15:03:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w5Plh-0005t8-Sl
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:03:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DzxASLxZS4HvxYDAUA8yfM2UezI5z6VfoFofepEiZig=; b=XZCyM9nLSFw2Wlt7ztM3pxfMnC
 UR7BKW1VgBmzlct/NQJKViSwSB8Rm3XXa2usnmfRe8hH3YAjuhnedng9OWMPlbGfHuaCsZxk+Asrh
 RGYEToetH3DRm8rhfbLTIv7jvhQ9ojbTPYr3nCLwT/UxrUEd3iPh+DXeNTXJx94VWXzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DzxASLxZS4HvxYDAUA8yfM2UezI5z6VfoFofepEiZig=; b=H2rRatnh1BMbbT8Qdz90TLxZJm
 jnU51G10Pua5dGBgnDmRQ/wJwLJ7G+hhRf46OA+58K2+UiLgQz6qBCe/5cQW2Zmu6fMEcdwWMcEpj
 a3GexwoVEx5UZR31GLe7b02IiG1MVXRlKqD9PvcN+aK17X0GzGeDtak3xfkRhUeCToLg=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5Plh-0006SP-1W for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:03:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B87BB68C4E; Wed, 25 Mar 2026 08:56:11 +0100 (CET)
Date: Wed, 25 Mar 2026 08:56:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260325075611.GB952@lst.de>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-3-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319170231.1455553-3-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w5Plh-0006SP-1W
Subject: Re: [f2fs-dev] [PATCH v5 02/25] fsverity: expose
 ensure_fsverity_info()
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> -static int ensure_verity_info(struct inode *inode)
> +int fsverity_ensure_verity_info(struct inode *inode)

This should grow a kerneldoc comment.

> +static inline int fsverity_ensure_verity_info(struct inode *inode)
> +{
> +	WARN_ON_ONCE(1);
> +	return -EOPNOTSUPP;
> +}

We should not need a stub for this as the only non-fsverity caller
already checks fsverity_active and the compiler will eliminate the
dead call.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
