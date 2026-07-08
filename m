Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F9BC43602
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2026 16:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HSDe4ZPk1g1pp6CvxXslu62eqqqRyxIvUFw9gUOzdWw=; b=KznaGn1Il3wgJkuK5E6GFH6gRH
	/Wp4Rfc9ZbKlKs9knSXpoKqktiYVsKABCNuDD/slylPkbLKE5y7GUl667wb5CIyQkbLHKMFjPS+gy
	C/La0/C7ZvG+A3TiG6h2HdfFVaBxvbTOLuPBGpxZuAr/zia8+RubmT7bhzwppnsBFxJE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1whUiH-0007is-2q;
	Wed, 08 Jul 2026 16:01:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1whUi5-0007hw-QB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 16:01:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dEdqVpLfo0zxiVHZ5Hca2wH1NA58KJPOna1s5syEqgY=; b=f+QCROD2PWKz4EPC0YqceZEEHh
 u5G2O1qSmzvQJZ4MagMZBbkQnwnGNiXUzOPCHLu/NDc7h4if1RFv9DcvtyCrRTFpvu+GH19pKK5VJ
 cVKx58HxxnybCLC9yjxp6jF+wrJZvaeuZAvt5uio0bAM4y9NAAGrTarGsH+DUuwYbePE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dEdqVpLfo0zxiVHZ5Hca2wH1NA58KJPOna1s5syEqgY=; b=iurg8tIbOA+3Vogl+0U0EECuMV
 /z9mkERtKaSkKzyu7TwqVYZsWvPEuizIhUP33JWZCIHCi5zAuBmRGUxheNz8PilXE+NudyQ4reh3N
 RhTaSk9SRSRPSgHKj/nZs8ltpDaDvZmjJ2Qo1bCLlE72mB2y3j/GWD55+5jXqoQ/m+Ec=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whUi3-0001mt-4i for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 16:01:18 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AD1E75E59;
 Wed,  8 Jul 2026 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783526468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEdqVpLfo0zxiVHZ5Hca2wH1NA58KJPOna1s5syEqgY=;
 b=WNKDs7kzsD+ejDCxTKpxh/4UTMXqRiwxqZCiY1OD1pWBkjLU2rt74Dml3QmeOC1IFOkdtW
 Pxj/JFWBJLRnNeYcces4x6xwoj3w3OA2MGYqXsnoZSHlh8+pZMDeyXqWQLcIuMQMx0kr6r
 e9EceKJSkjqq3s9V5zZ9wkpvoJGjkTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783526468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEdqVpLfo0zxiVHZ5Hca2wH1NA58KJPOna1s5syEqgY=;
 b=noLT/CiEA53ybMrIWsCOxXzY+gZEBmg/NRs1+ck8oaQ7jT31lPW5/RJYo1+J7LagCqdjMp
 wO2mJUvdaK/kexAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Uc5xxRgo;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=UnRPN2+C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783526465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEdqVpLfo0zxiVHZ5Hca2wH1NA58KJPOna1s5syEqgY=;
 b=Uc5xxRgoIzNp6zzYFJDKsFKGAMc3FBTT5Ybkvy1VjhQSiV2qAFh0Hko6vSQ8bm7pDSwYE1
 YbRKrlp8L2/e4YOG3kUyb5sEsEl/waFn0XySSyDP0ANsyPxjAYRyVb/R3ECEtiCNGSFDoj
 UxyUFNaDRYdsvCQmImLdVnj3h179DPg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783526465;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEdqVpLfo0zxiVHZ5Hca2wH1NA58KJPOna1s5syEqgY=;
 b=UnRPN2+Cgqe2o697vJKHkgoiBj4qT4nlVGmgjBXwxXguByKxHUSGI/B3w9rwapT+VITE6U
 sTAVfMTej8ersqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0216A779AE;
 Wed,  8 Jul 2026 16:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ks94AEF0TmpqXAAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 08 Jul 2026 16:01:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 9E77BA12D6; Wed, 08 Jul 2026 18:01:04 +0200 (CEST)
Date: Wed, 8 Jul 2026 18:01:04 +0200
From: Jan Kara <jack@suse.cz>
To: Chao Yu <chao@kernel.org>
Message-ID: <xdicd4lsm44vsidxkrrul6waqdnb4gcof35e2pwurpnz7rvh6g@xjvhdqnen3vy>
References: <20260707113934.3003158-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260707113934.3003158-1-chao@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0AD1E75E59
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_LAST(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Headers-End: 1whUi3-0001mt-4i
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: quota: do not use GFP_NOFS in
 f2fs_quota_read()
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
 Matthew Wilcox <willy@infradead.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue 07-07-26 19:39:33, Chao Yu wrote:
> Commit 02117b8ae9c0 ("f2fs: Set GF_NOFS in read_cache_page_gfp while doing
> f2fs_quota_read") adds GFP_NOFS in f2fs_quota_read() to avoid below deadlock:
> 
> - do_sys_open
>  - vfs_open
>   - dquot_file_open
>    - dquot_initialize
>     - dqget
>      - dquot_acquire
>       : locks &dqopt->dqio_mutex (VFS Quota Mutex)
>       - qtree_read_dquot
>        - f2fs_quota_read
>         - read_mapping_page (GFP_KERNEL / allows GFP_FS)
>          - __alloc_pages_nodemask
>           - try_to_free_pages (Direct Reclaim)
>            - prune_icache_sb
>             - evict
>              - f2fs_evict_inode
>               - dquot_drop
>                - dqput
>                 - dquot_commit
>                  : tries to lock &dqopt->dqio_mutex again
>                  ==> DEADLOCK (waiting for itself)
> 
> As Jan Kara mentioned, quota system has fixed this issue w/ commit
> 537e11cdc7a6 ("quota: Prevent memory allocation recursion while holding
> dq_lock"), so this GFP_NOFS flag should be relic, let's use GFP_KERNEL
> instead.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Chao Yu <chao@kernel.org>

Looks sound to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2:
> - fix to use GFP_KERNEL instead of 0.
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index da468df058eb..b1725ca68010 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3168,7 +3168,7 @@ static ssize_t f2fs_quota_read(struct super_block *sb, int type, char *data,
>  
>  repeat:
>  		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT,
> -				GFP_NOFS);
> +				GFP_KERNEL);
>  		if (IS_ERR(folio)) {
>  			if (PTR_ERR(folio) == -ENOMEM) {
>  				memalloc_retry_wait(GFP_NOFS);
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
