Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68CEC07CA9
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Nov 2023 11:20:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r7w8j-0004Jh-FA;
	Tue, 28 Nov 2023 11:20:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1r7w8i-0004JY-DT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Nov 2023 11:20:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kVD9cpIxQxlHQBTO+E9xaUGf8SVgbYHSIaOxapk5BPo=; b=cOMhKDmSNireC53wMyxQ/5p5Or
 1QiOSpnEFCKSkNzb7InLQxXWY/Us0dHbaO6jYO1WE63GxqYOJyPsMKhdP54+9jzwq41/1+0xJ6hgC
 Af+Ui1+BBrecamuk34zVGOOr+CWRVs7SdUwKWp0nQUVKAMYf4riYx77OT4aYC5QfD4NE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kVD9cpIxQxlHQBTO+E9xaUGf8SVgbYHSIaOxapk5BPo=; b=CkCfqpxVy7jADs2HIESqUJJbCC
 GqbDP3w+R8rV7KUakSWkmvTo6RMQnhQvkXvgezKYxnYiNpittoAmcMa/EGgnc52U5yt0ag9OqUVvN
 SF5HxLMZ1HR2LlNZeSIpaZfotInftndQVLLUyXdxmS68rqj2/ugwbyyDErjjGBcBH60I=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1r7w8h-0007UZ-RY for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Nov 2023 11:20:28 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 23ACC2195A;
 Tue, 28 Nov 2023 11:03:02 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A1FA139FC;
 Tue, 28 Nov 2023 11:03:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id UV1cBubIZWUVcAAAn2gu4w
 (envelope-from <jack@suse.cz>); Tue, 28 Nov 2023 11:03:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A8438A07CB; Tue, 28 Nov 2023 12:03:01 +0100 (CET)
Date: Tue, 28 Nov 2023 12:03:01 +0100
From: Jan Kara <jack@suse.cz>
To: Chao Yu <chao@kernel.org>
Message-ID: <20231128110301.pk3qbhopptmhvxet@quack3>
References: <20231128092516.2882629-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231128092516.2882629-1-chao@kernel.org>
X-Spamd-Bar: ++++++++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de; dkim=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz; 
 dmarc=none
X-Rspamd-Queue-Id: 23ACC2195A
X-Spamd-Result: default: False [14.12 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(2.75)[0.917];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 DMARC_NA(1.20)[suse.cz]; R_SPF_SOFTFAIL(4.60)[~all:c];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.52)[80.29%]
X-Headers-End: 1r7w8h-0007UZ-RY
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid dirent corruption
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
Cc: jaegeuk@kernel.org, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue 28-11-23 17:25:16, Chao Yu wrote:
> As Al reported in link[1]:
> 
> f2fs_rename()
> ...
> 	if (old_dir != new_dir && !whiteout)
> 		f2fs_set_link(old_inode, old_dir_entry,
> 					old_dir_page, new_dir);
> 	else
> 		f2fs_put_page(old_dir_page, 0);
> 
> You want correct inumber in the ".." link.  And cross-directory
> rename does move the source to new parent, even if you'd been asked
> to leave a whiteout in the old place.
> 
> [1] https://lore.kernel.org/all/20231017055040.GN800259@ZenIV/
> 
> With below testcase, it may cause dirent corruption, due to it missed
> to call f2fs_set_link() to update ".." link to new directory.
> - mkdir -p dir/foo
> - renameat2 -w dir/foo bar
> 
> [ASSERT] (__chk_dots_dentries:1421)  --> Bad inode number[0x4] for '..', parent parent ino is [0x3]
> [FSCK] other corrupted bugs                           [Fail]
> 
> Fixes: 7e01e7ad746b ("f2fs: support RENAME_WHITEOUT")
> Cc: Jan Kara <jack@suse.cz>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Chao Yu <chao@kernel.org>

Thanks for fixing this! Makes sense to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/f2fs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 3b1793cfb002..ede6afb81762 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -1105,7 +1105,7 @@ static int f2fs_rename(struct mnt_idmap *idmap, struct inode *old_dir,
>  	}
>  
>  	if (old_dir_entry) {
> -		if (old_dir != new_dir && !whiteout)
> +		if (old_dir != new_dir)
>  			f2fs_set_link(old_inode, old_dir_entry,
>  						old_dir_page, new_dir);
>  		else
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
