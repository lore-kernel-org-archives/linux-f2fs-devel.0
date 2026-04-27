Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDEF9FF8861
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBuqss33KDVxNVWtxXsGFu8cKRLy4kXdaEU2+dZjf6Q=; b=DMPLLFcEZOpRTJiWceed6qOQun
	s3JoN6fgS+cWYeD9CkMC5Ud+CggQvoUw5YUCVEnYfeVVDZ/DUNQoKcxGJu9ccdKDTXaJxLNXhI9L6
	OrxkbuIO4ndYqhETfRNtSGv1TQLz8NPK5bnoccs0oYMs3P5iQdghEOjctSEMrUxFFz8Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHJdI-0004kd-9r;
	Mon, 27 Apr 2026 10:56:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1wHJdH-0004kU-I6
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 10:56:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=; b=WVx5JRoZTBkUWixh6OFVlIh/1J
 F33CxSnuI0/Zb1+qUlTA9vOwUNCZCGmN3fUt5RR9A2aRS8++3roY5ks3saSJubUpbB3RiVLoJb82M
 cU/b0rf649bX36ug5Rrd1uEPBUwU8Ub66g3V3tPm6mlPf371BrfDScg950s5XXCgWAUw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=; b=RunHjZlojPf7Eh0jDrG5eTtRWz
 nd2j+7kzZM/uRN+f7HmpTOEth5xy/DKVjdLsdYw4cQ5OvJH/pk9UBg7cJvlUSaWtxPRx56CptSqmi
 1JqenlgiGOTq8VfeikcewXzElPn1ZmpNHMnZxrjEQv/cSiewWI6O2r4oyDJtH+Fm61Eo=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wHJdH-0008CY-Nl for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 10:56:08 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB1DF6A90C;
 Mon, 27 Apr 2026 10:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777287355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=;
 b=mL3ngl1cqaRUt8Fn5dYnLoFF2Acv+D9WQtqParWsKqzU/P5IXj0SXcU98WOltiA1mn4zVm
 BOKmz6VoxTsS6U2V1Z8vMrEHG8P9XabHEblzsATlsxjFsMFI251OYIDwEOn0XYFbgu1xzD
 uX3AFNBs03zK1OvzoLoIcxzuG1vWQuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777287355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=;
 b=ILylDamPZoKLtgaAkFGi18Zgg+LC8tTd9UFmlIrhO7AJ1n2wvk+mr09kzXnhdJRJ2siVKG
 yLiBMSGqbMZCTwBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mL3ngl1c;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ILylDamP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777287355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=;
 b=mL3ngl1cqaRUt8Fn5dYnLoFF2Acv+D9WQtqParWsKqzU/P5IXj0SXcU98WOltiA1mn4zVm
 BOKmz6VoxTsS6U2V1Z8vMrEHG8P9XabHEblzsATlsxjFsMFI251OYIDwEOn0XYFbgu1xzD
 uX3AFNBs03zK1OvzoLoIcxzuG1vWQuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777287355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7v7Dqr0yFbYHWxuadHzDP6hn5aEfxXOyhRHqVAyeSDA=;
 b=ILylDamPZoKLtgaAkFGi18Zgg+LC8tTd9UFmlIrhO7AJ1n2wvk+mr09kzXnhdJRJ2siVKG
 yLiBMSGqbMZCTwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CACD3593B0;
 Mon, 27 Apr 2026 10:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0DN3MbtA72lvOAAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 10:55:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 8ABE3A0AFF; Mon, 27 Apr 2026 12:55:55 +0200 (CEST)
Date: Mon, 27 Apr 2026 12:55:55 +0200
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Message-ID: <yc7ygk6w6zvf46arzzvmxnuoqjrni2dtlhmywaivzmvfxnilf3@xv7tthtrowns>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[36]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_COUNT_THREE(0.00)[3];
 R_RATELIMIT(0.00)[to_ip_from(RLa77mm4gi8mw7uppieotozii3)];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_LAST(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: DB1DF6A90C
X-Headers-End: 1wHJdH-0008CY-Nl
Subject: Re: [f2fs-dev] [PATCH v11 00/15] Exposing case folding behavior
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
 cem@kernel.org, Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 "Darrick J. Wong" <djwong@kernel.org>, linux-ext4@vger.kernel.org,
 linkinjeon@kernel.org, Steve French <stfrench@microsoft.com>,
 sprasad@microsoft.com, frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri 24-04-26 21:53:02, Chuck Lever wrote:
> Changes since v10:
> - cifs: Source case-handling flags from the server's cached
>   FS_ATTRIBUTE_INFORMATION reply instead of the nocase mount
>   option, with a nocase fallback when the reply is absent
> - Address findings from sashiko(gemini-3) and gpt-5.5:
>   - nfs: Skip pathconf case bits on NFSv4 (set via FATTR4_CASE_*
>     instead)
>   - xfs: Hide FS_CASEFOLD_FL from the legacy flags view so
>     chattr round-trips do not hit the setflags whitelist
>   - ext4, f2fs: Drop redundant fileattr_get patches; the
>     FS_CASEFOLD_FL translation in fileattr_fill_flags() already
>     reports FS_XFLAG_CASEFOLD for casefolded directories

Err, how is this supposed to work? I wasn't able to find any code
transforming S_CASEFOLDED inode flag into FS_CASEFOLD_FL on fileattr_get
path. Sure, fileattr_fill_flags() takes care of setting FS_XFLAG_CASEFOLD
once FS_CASEFOLD_FL is set. What am I missing?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
