Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B02DC001DF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Aug 2023 13:16:51 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qRYC9-0004NU-EG;
	Thu, 03 Aug 2023 13:16:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1qRYC7-0004NN-5r
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 13:16:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u354+D6fXMwflzIguDkXJwfsSkO6vRI2JZd9gBpk1w8=; b=TzP3KvYs7yhz1z2EgDViSM6BwI
 NiwA2Svv/fppkFCjAavWSqymyTCx1i0Fe1mJGaX9+mFQvV2c9djC7K1u9Eu+vzMCbZRpdmycyuds7
 iWis/32U/N7Z7jPOO/iJMEWf7/vvXdsrMlFOQtDokoAH1hM8kPIbyAOUC/jEPy/fDKTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u354+D6fXMwflzIguDkXJwfsSkO6vRI2JZd9gBpk1w8=; b=ACpvFHyPyKWnw70Zoi4IpA36to
 r9k8yCsOYMgC3F65TKorb8xAkwjqiZMAkjWN+aFKtPBLTEd3TmfM/EpEfuA763j+fk3bEtkHvSYGD
 jJtRXkDgGz37f+Q/twIkl2siIVoQB/wK6j2oNuuxLy1KU0Si14zCPEjDx4mKMT0pJa5U=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qRYC6-0005eS-Fa for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 13:16:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36FEB21940;
 Thu,  3 Aug 2023 13:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691068600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u354+D6fXMwflzIguDkXJwfsSkO6vRI2JZd9gBpk1w8=;
 b=OInI+ey5VB7bzlioGeMTFK6cIMQcbmPzuBjm1cod6P5t4UnAeQVLtUmUu1ow9TDDPGWiPS
 atDqYLDfOQiSeLf9a8Mxe+jzJt4kWnT5rRiebmQjJeWOqxCO++WGDUVBxHjKk+yd1qbRDm
 s/39yG0lPvvzKys6HDoWqHVcWWAMeF8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691068600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u354+D6fXMwflzIguDkXJwfsSkO6vRI2JZd9gBpk1w8=;
 b=SmreZ91bm3h8DRDbHSeo79QkJcwnmaQYt9hiZl0HQQG8+NzwgUM1M7+nZhg4RER1VLY2aq
 a6c0libI9aZYmsBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28A5C134B0;
 Thu,  3 Aug 2023 13:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /jbsCbioy2RJagAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 13:16:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A4DE7A076B; Thu,  3 Aug 2023 15:16:39 +0200 (CEST)
Date: Thu, 3 Aug 2023 15:16:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230803131639.eq6i7hq7mo4nvinr@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-9-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-9-hch@lst.de>
X-Headers-End: 1qRYC6-0005eS-Fa
Subject: Re: [f2fs-dev] [PATCH 08/12] fs: export fs_holder_ops
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Christian Brauner <brauner@kernel.org>, linux-nilfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 "Darrick J. Wong" <djwong@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed 02-08-23 17:41:27, Christoph Hellwig wrote:
> Export fs_holder_ops so that file systems that open additional block
> devices can use it as well.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c             | 3 ++-
>  include/linux/blkdev.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 0cda4af0a7e16c..dac05f96ab9ac8 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1244,9 +1244,10 @@ static void fs_mark_dead(struct block_device *bdev)
>  	up_read(&sb->s_umount);
>  }
>  
> -static const struct blk_holder_ops fs_holder_ops = {
> +const struct blk_holder_ops fs_holder_ops = {
>  	.mark_dead		= fs_mark_dead,
>  };
> +EXPORT_SYMBOL_GPL(fs_holder_ops);
>  
>  static int set_bdev_super(struct super_block *s, void *data)
>  {
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index ed44a997f629f5..83262702eea71a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1464,6 +1464,8 @@ struct blk_holder_ops {
>  	void (*mark_dead)(struct block_device *bdev);
>  };
>  
> +extern const struct blk_holder_ops fs_holder_ops;
> +
>  /*
>   * Return the correct open flags for blkdev_get_by_* for super block flags
>   * as stored in sb->s_flags.
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
