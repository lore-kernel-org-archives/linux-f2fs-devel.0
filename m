Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D3CFF8860
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mnZszx5pYC2GwLubxXb77uaaA2m3yS9jbdTH5XWbgKY=; b=dlewdcHNzH4FCCvvWmvIsQmd6m
	5ZVXJswipMTZIHCl8UkmbS91eSVAvOWfWNGyKx9i+yzKe6wux3K33J4xPh8eo9M03WqnAaea7ZRph
	fIaXZfX+ic8yp1nB2Dq1kEktuP/27mElXA+CIZtXcVZCdT8BnU9qZvXPAFReLmCqZZn8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHNvU-0002Zi-1I;
	Mon, 27 Apr 2026 15:31:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1wHNvR-0002ZY-PV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 15:31:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=; b=OKXPP8c7gaugSjBxbC2X+tPy5R
 rjLF5US/e63r8/pUDQ/jAfxuCKabwTAXtUGklWqwrqk8mS6xULqfedj1g9tkdkdguc4xKFDd6tcdq
 OdOppa8kNa5jYIGui4CKdI37kA3MLajnKOLsOqmFEaPXGK40LvCce8WIEvttWI1D4JkE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=; b=RIRgM1YQFViWUyMkuSEjbWyJl5
 VJpwSJ5U8nrOhud47rByYKC9MK9osx2SA6IFJ8Fx09S5oqMxyO8+o3PugJ6hxYCxRYcJmOsBFuD7s
 zX4h41nF5JYpH223gBG21/CWvdGHijYDX+u4yidGZtllxV6zRd2LQ7P7IbFEjMvoOruA=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wHNvO-0001Ts-BY for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Apr 2026 15:31:07 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83C405BD28;
 Mon, 27 Apr 2026 15:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777303854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=;
 b=Aysv71JgNdkUTLe/R48X+824uBNRHn71litaKG+1w3A/La231hoXUGBWz2y9yzsnn597mv
 3P03spY5S3DdVhHCq0qYKHFvVuwZg6pQhYxrLTt86tLSZR6efrU+hSdh7QqDVh0gGeiw4f
 hGZLTaIznZNVQWN0qZZWDoyKNyoU2/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777303854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=;
 b=ByfH34ewyF0hmVnffEbScDGb1ZxCDfRi+yKco+Xw6OzguYlECQXkamlnVtnXzZCBify66N
 bmYnyjqNmoSD5TBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Aysv71Jg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ByfH34ew
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777303854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=;
 b=Aysv71JgNdkUTLe/R48X+824uBNRHn71litaKG+1w3A/La231hoXUGBWz2y9yzsnn597mv
 3P03spY5S3DdVhHCq0qYKHFvVuwZg6pQhYxrLTt86tLSZR6efrU+hSdh7QqDVh0gGeiw4f
 hGZLTaIznZNVQWN0qZZWDoyKNyoU2/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777303854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S5TTh67heGQlOR0MPWIUkAW95GyTnx+icWBSCmm/7n0=;
 b=ByfH34ewyF0hmVnffEbScDGb1ZxCDfRi+yKco+Xw6OzguYlECQXkamlnVtnXzZCBify66N
 bmYnyjqNmoSD5TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 772B4593B0;
 Mon, 27 Apr 2026 15:30:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id po8VHS6B72npVQAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 27 Apr 2026 15:30:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 37EB1A0B3C; Mon, 27 Apr 2026 17:30:54 +0200 (CEST)
Date: Mon, 27 Apr 2026 17:30:54 +0200
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Message-ID: <jq4wmu34kstqgvjspfalgedpsv3xciwkc5uaj7ewdc73a3yt6f@ddoia6tddojv>
References: <20260424-case-sensitivity-v11-0-de5619beddaf@oracle.com>
 <yc7ygk6w6zvf46arzzvmxnuoqjrni2dtlhmywaivzmvfxnilf3@xv7tthtrowns>
 <af3f7518-7501-4c25-9bbc-a8fc8cdb4e29@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af3f7518-7501-4c25-9bbc-a8fc8cdb4e29@app.fastmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_THREE(0.00)[3]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[36];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_LAST(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLa77mm4gi8mw7uppieotozii3)];
 MISSING_XM_UA(0.00)[];
 FREEMAIL_CC(0.00)[suse.cz,zeniv.linux.org.uk,kernel.org,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com,nrubsig.org];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:email, suse.cz:dkim]
X-Rspamd-Queue-Id: 83C405BD28
X-Headers-End: 1wHNvO-0001Ts-BY
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
Cc: Jan Kara <jack@suse.cz>, Paulo Alcantara <pc@manguebit.org>,
 Yuezhang Mo <yuezhang.mo@sony.com>, Carlos Maiolino <cem@kernel.org>,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, Steve French <sfrench@samba.org>,
 Viacheslav Dubeyko <slava@dubeyko.com>, "Darrick J. Wong" <djwong@kernel.org>,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 Steve French <stfrench@microsoft.com>, Shyam Prasad N <sprasad@microsoft.com>,
 frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Christian Brauner <brauner@kernel.org>, Theodore Tso <tytso@mit.edu>,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, Hans de Goede <hansg@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
 Sungjong Seo <sj1557.seo@samsung.com>, Trond Myklebust <trondmy@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon 27-04-26 09:30:28, Chuck Lever wrote:
> 
> On Mon, Apr 27, 2026, at 6:55 AM, Jan Kara wrote:
> > On Fri 24-04-26 21:53:02, Chuck Lever wrote:
> >> Changes since v10:
> >> - cifs: Source case-handling flags from the server's cached
> >>   FS_ATTRIBUTE_INFORMATION reply instead of the nocase mount
> >>   option, with a nocase fallback when the reply is absent
> >> - Address findings from sashiko(gemini-3) and gpt-5.5:
> >>   - nfs: Skip pathconf case bits on NFSv4 (set via FATTR4_CASE_*
> >>     instead)
> >>   - xfs: Hide FS_CASEFOLD_FL from the legacy flags view so
> >>     chattr round-trips do not hit the setflags whitelist
> >>   - ext4, f2fs: Drop redundant fileattr_get patches; the
> >>     FS_CASEFOLD_FL translation in fileattr_fill_flags() already
> >>     reports FS_XFLAG_CASEFOLD for casefolded directories
> >
> > Err, how is this supposed to work? I wasn't able to find any code
> > transforming S_CASEFOLDED inode flag into FS_CASEFOLD_FL on fileattr_get
> > path. Sure, fileattr_fill_flags() takes care of setting FS_XFLAG_CASEFOLD
> > once FS_CASEFOLD_FL is set. What am I missing?
> 
> Agreed, that is a little surprising.
> 
> The path does not go through S_CASEFOLD.  Both filesystems
> report FS_CASEFOLD_FL straight from their on-disk flag word.
> 
> For ext4, EXT4_CASEFOLD_FL is 0x40000000, the same bit value
> as FS_CASEFOLD_FL, and it is included in EXT4_FL_USER_VISIBLE.
> ext4_iget() loads it into ei->i_flags directly from
> raw_inode->i_flags (fs/ext4/inode.c:5358). ext4_fileattr_get()
> then masks with EXT4_FL_USER_VISIBLE and hands the result to
> fileattr_fill_flags(), which translates FS_CASEFOLD_FL into
> FS_XFLAG_CASEFOLD on the way out.

Oh, right. I've missed how EXT4_CASEFOLD_FL propagates into FS_CASEFOLD_FL.
Thanks for clearing that out.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
