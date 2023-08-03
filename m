Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8F4C04A6A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Aug 2023 11:21:39 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qRWOe-0003Ex-D1;
	Thu, 03 Aug 2023 11:21:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1qRWOc-0003Ej-6h
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 11:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/oqdnU2hVSvQjG7zr7ybcm4vgtUzeJvEjdOgZyr5MDo=; b=Lgfqjad+OvPnsh7PvFJmupThxf
 TPAlM8+eTdtJxQtwQC2vdezjviAv7R2gKnfLX7ee5VtAghGCApBcstBmp8bBZVqBqfZZfiI9Aguri
 0ApXm0TnXENpS27977lmn7VtfY6gYL5AcEpT/xHIDBTPNxo88cPsQa4Kydxx0RUzAjdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/oqdnU2hVSvQjG7zr7ybcm4vgtUzeJvEjdOgZyr5MDo=; b=QIglMoFw57zzv/A4NM+72z46km
 4hrEQuCZwNRGT6CcA3iCKUEz8ceCPoMt1LGe7rqq8TS4B2I+FCGMkcjbSw83gJeWqS0Og/U9wsazh
 N0LMQSq1Qx7/3vBY924twsICY4fVSKm9kUE33q47bhlBWB5NRt8og7KOtRfiM31WBqSA=;
Received: from smtp-out2.suse.de ([195.135.220.29])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qRWOQ-0002a8-Ii for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Aug 2023 11:21:29 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 982C91F45A;
 Thu,  3 Aug 2023 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1691061671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oqdnU2hVSvQjG7zr7ybcm4vgtUzeJvEjdOgZyr5MDo=;
 b=SshCa3at/QVqc2HIIpLg9LhDhKTreRaL2cZGX45vYwIeK3cx7PttlNBGYy6OudlZNlY9ra
 MOv4rt6y4ZaVGS2gQBky7dhvCX5sAuEwxT7t0AG/xr4WPg3HrvCw3+qX5Fp1tt3Cecc/DQ
 xnTqKiRxO3ni8MzYtqEIGMQIwjC94ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1691061671;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/oqdnU2hVSvQjG7zr7ybcm4vgtUzeJvEjdOgZyr5MDo=;
 b=H+MFCeAyi3R3yXuvvMJFuzNpnCx698yyaUcPgHxx1B/25fIvZ6HmN/YfD5MBWOxvwIKJn3
 LdjGjluOtzdqOXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85D45134B0;
 Thu,  3 Aug 2023 11:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id C3WjIKeNy2SCLgAAMHmgww
 (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 11:21:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id D9E0FA076B; Thu,  3 Aug 2023 13:21:10 +0200 (CEST)
Date: Thu, 3 Aug 2023 13:21:10 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20230803112110.7qybhrgn2rwaguu2@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-6-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-6-hch@lst.de>
X-Headers-End: 1qRWOQ-0002a8-Ii
Subject: Re: [f2fs-dev] [PATCH 05/12] ext4: make the IS_EXT2_SB/IS_EXT3_SB
 checks more robust
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

On Wed 02-08-23 17:41:24, Christoph Hellwig wrote:
> Check for sb->s_type which is the right place to look at the file system
> type, not the holder, which is just an implementation detail in the VFS
> helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c94ebf704616e5..193d665813b611 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -140,7 +140,7 @@ static struct file_system_type ext2_fs_type = {
>  };
>  MODULE_ALIAS_FS("ext2");
>  MODULE_ALIAS("ext2");
> -#define IS_EXT2_SB(sb) ((sb)->s_bdev->bd_holder == &ext2_fs_type)
> +#define IS_EXT2_SB(sb) ((sb)->s_type == &ext2_fs_type)
>  #else
>  #define IS_EXT2_SB(sb) (0)
>  #endif
> @@ -156,7 +156,7 @@ static struct file_system_type ext3_fs_type = {
>  };
>  MODULE_ALIAS_FS("ext3");
>  MODULE_ALIAS("ext3");
> -#define IS_EXT3_SB(sb) ((sb)->s_bdev->bd_holder == &ext3_fs_type)
> +#define IS_EXT3_SB(sb) ((sb)->s_type == &ext3_fs_type)
>  
>  
>  static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
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
