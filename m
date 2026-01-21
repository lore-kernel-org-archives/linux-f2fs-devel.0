Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A329C44502
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Jan 2026 10:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cv8wsAPLqznGcGqEYmBwMVUwtEkqreNIuLlkJlQ3oGA=; b=i2yKWvYowJyPfuijV6thPhrD0q
	56u5XHSrFg5JeeMfdEZR2YQOn09BMI0CQmXCrhaq8VaZPtH0P00UMRfhJJpIb/FSSOSuvle1j/UBi
	fa9e+SkgM/gKBPiOgTI5IQpFapqf5UnZPX08HrGc6vIjtk+nxSBAf8jCbpYVQHtrmm+A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viVFX-0005ma-RQ;
	Wed, 21 Jan 2026 10:15:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jack@suse.cz>) id 1viVFT-0005mK-ME
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jan 2026 10:15:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=; b=RD5sM++plHgVhFmNW4W7RDBMac
 xfMG7oqFCSAjTkpwrqJkwG3gMnOg5tBRLgCaKbYsaVlGn3hyVkD67toXy8bOlzcqd4untGExgJwmg
 SqObIPxRxMFwNGlpmCIhxiRlb6q8zzIkpr5wOYPNAsgpxvQya4B8wSFdt5Bw33qdfbg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=; b=L3wbyPsbtC9SDLTCgrq0VCtsEw
 N6Lta25Pq2oOv3/x0LaRtRKXYNzZb+TBMui+UtCukllnkOKGbUXtNv+T09FNY071ojtDlxVgR+BQJ
 PYal8Jb2cH/BOaX3ikZX6CnIjwfth78qVM54YeOW7poZOwDZQDS7HWd3PaG03cJpJmCM=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1viVFS-00034p-S4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jan 2026 10:15:39 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 411673368B;
 Wed, 21 Jan 2026 10:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768990531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=;
 b=oyZr4bIa8xa6khQR+3eM1H61wEuW3Q0Mnyvw0c7ai3xakzeGQVGU/k5BpLu7zyxFGI53uU
 /Md2kFXYwOpTYCKaVuK9vdlm7AYjoWJosUfSR6+QZ/KVddN/7n+GkQpROamRQAgf+irhFa
 1efAhFd3urlGVtpZhRDELhC8i3q+sWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768990531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=;
 b=hKGDT3RVd5aKhQJyzWkmDrePqUureFmqRjTuFORoR2dLuF3B2vhHl4w5CN1/YYvRUf4RLG
 hO1E2Tf9swmlZDCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oyZr4bIa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hKGDT3RV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1768990531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=;
 b=oyZr4bIa8xa6khQR+3eM1H61wEuW3Q0Mnyvw0c7ai3xakzeGQVGU/k5BpLu7zyxFGI53uU
 /Md2kFXYwOpTYCKaVuK9vdlm7AYjoWJosUfSR6+QZ/KVddN/7n+GkQpROamRQAgf+irhFa
 1efAhFd3urlGVtpZhRDELhC8i3q+sWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1768990531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aF2V3WhsKglhokc+vDCdyrArCDZRi7BaNs5JOgZNrVU=;
 b=hKGDT3RVd5aKhQJyzWkmDrePqUureFmqRjTuFORoR2dLuF3B2vhHl4w5CN1/YYvRUf4RLG
 hO1E2Tf9swmlZDCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34BC63EA63;
 Wed, 21 Jan 2026 10:15:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sl/WDEOncGnVbAAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 21 Jan 2026 10:15:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id E2DBFA09E9; Wed, 21 Jan 2026 11:15:26 +0100 (CET)
Date: Wed, 21 Jan 2026 11:15:26 +0100
From: Jan Kara <jack@suse.cz>
To: Chuck Lever <cel@kernel.org>
Message-ID: <avtj6ud7hb7qyya4ekj24lu2jwmirlqspxa4ptmhjrvuhrgfx6@ghzl2aqdokkg>
References: <20260120142439.1821554-1-cel@kernel.org>
 <20260120142439.1821554-2-cel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260120142439.1821554-2-cel@kernel.org>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWELVE(0.00)[32];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[oracle.com:email,suse.com:email];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_LAST(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLa77mm4gi8mw7uppieotozii3)];
 MISSING_XM_UA(0.00)[];
 FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 411673368B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Headers-End: 1viVFS-00034p-S4
Subject: Re: [f2fs-dev] [PATCH v6 01/16] fs: Add case sensitivity flags to
 file_kattr
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
 adilger.kernel@dilger.ca, linux-cifs@vger.kernel.org, sfrench@samba.org,
 slava@dubeyko.com, linux-ext4@vger.kernel.org, linkinjeon@kernel.org,
 sprasad@microsoft.com, frank.li@vivo.com, linux-nfs@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ronniesahlberg@gmail.com,
 glaubitz@physik.fu-berlin.de, jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp,
 Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue 20-01-26 09:24:24, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Enable upper layers such as NFSD to retrieve case sensitivity
> information from file systems by adding FS_XFLAG_CASEFOLD and
> FS_XFLAG_CASENONPRESERVING flags.
> 
> Filesystems report case-insensitive or case-nonpreserving behavior
> by setting these flags directly in fa->fsx_xflags. The default
> (flags unset) indicates POSIX semantics: case-sensitive and
> case-preserving. These flags are read-only; userspace cannot set
> them via ioctl.
> 
> Relocate struct file_kattr initialization from fileattr_fill_xflags()
> and fileattr_fill_flags() to vfs_fileattr_get() and the ioctl/syscall
> call sites. This allows filesystem ->fileattr_get() callbacks to set
> flags directly in fa->fsx_xflags before invoking the fill functions,
> which previously would have zeroed those values. Callers that bypass
> vfs_fileattr_get() must now zero-initialize the struct themselves.
> 
> Case sensitivity information is exported to userspace via the
> fa_xflags field in the FS_IOC_FSGETXATTR ioctl and file_getattr()
> system call.
> 
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/file_attr.c           | 14 ++++++--------
>  fs/xfs/xfs_ioctl.c       |  2 +-
>  include/linux/fileattr.h |  3 ++-
>  include/uapi/linux/fs.h  |  2 ++
>  4 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/file_attr.c b/fs/file_attr.c
> index 13cdb31a3e94..2700200c5b9c 100644
> --- a/fs/file_attr.c
> +++ b/fs/file_attr.c
> @@ -15,12 +15,10 @@
>   * @fa:		fileattr pointer
>   * @xflags:	FS_XFLAG_* flags
>   *
> - * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
> - * other fields are zeroed.
> + * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
>   */
>  void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
>  {
> -	memset(fa, 0, sizeof(*fa));
>  	fa->fsx_valid = true;
>  	fa->fsx_xflags = xflags;
>  	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
> @@ -46,11 +44,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
>   * @flags:	FS_*_FL flags
>   *
>   * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
> - * All other fields are zeroed.
>   */
>  void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
>  {
> -	memset(fa, 0, sizeof(*fa));
>  	fa->flags_valid = true;
>  	fa->flags = flags;
>  	if (fa->flags & FS_SYNC_FL)
> @@ -84,6 +80,8 @@ int vfs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
>  	struct inode *inode = d_inode(dentry);
>  	int error;
>  
> +	memset(fa, 0, sizeof(*fa));
> +

Umm, but ioctl_getflags() sets fa->flags_valid as a hint for
->fileattr_get() handler and this will now zero-out that hint. So I agree
that zeroing fa in fileattr_fill_{,x}flags() is a bit unexpected and moving
it is desirable but it needs a bit more careful surgery.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
