Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B042606A331
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DT87lSri;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dRju36jq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=geFiXGvc;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wiT8Ya5/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dk5YjynB;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=h2LQ/IDI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Sa6ZruAS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:References:In-Reply-To:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Et0X8JE25fa5Krvj25T1ZI8dLYxQwWTV5pdkuuBXmgQ=; b=DT87lSriBd1PAuGs5qNmx3MDJv
	atZPW6wGXXnZlt1XpRR4LgI5BfmPV86WySP4PUJMnrwobotNeBv9OdrK8Ejjxta8yoNPDHbPR5tpg
	gJ63csCFX1KHnmIHEyCLpt3oEvp7dEUlgdgWvnBwTVBAqyUHpEQGhtVPYRmAjQ3mmJs4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVwJu-000000002XH-2SQv;
	Tue, 24 Nov 2026 19:36:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <krisman@suse.de>) id 1xVwJs-000000002XA-3BhX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:36:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rbfQPnb/bGQ2Gkjp6lt26EZDU8eKMGkAA4M/WWEU8/c=; b=d
 Rju36jqI2DKs5ZQ5aOsJRTAzyf61yBQnW0yDwNLrJuBENp9col7c2EGcH8ilmaVUzsZQtW1VtUy0g
 FBfBY+VoaV+YiYi+2umu4mcBXfpE57J/1sFa2XZ4aIoAeh0mG5r9RTe238JZHFqYmorp/NgwicMLj
 mevKiSJsZcH4iiMc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rbfQPnb/bGQ2Gkjp6lt26EZDU8eKMGkAA4M/WWEU8/c=; b=geFiXGvcExLOmvKlYqJZ/nh8Jm
 u9i6kVJwcaG8AM3SSglVWp32qPEx0B4CZY7qtrWdAimjj3/05VrWJnvhLzFtY2wT8XE73ukyp4SlZ
 zAUpmqe5aZy+Pca94QMjgJfh24DjONet4BvEaO7iSa+9ReTbnPikX9+3rtBJ6K0oOtRc=;
Received: from smtp-out1.suse.de ([195.135.223.130])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVwJr-000000002yr-3TqE
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:36:48 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 478C6223AC;
 Tue, 24 Nov 2026 19:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795549001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rbfQPnb/bGQ2Gkjp6lt26EZDU8eKMGkAA4M/WWEU8/c=;
 b=wiT8Ya5/HG/DD7Q5wA50FeGnqRAYEFpM2ufxuc+W83Q6gRGxfoIYZsDrPVVbICmn2yN0jR
 zFQD1oULjCblWWQrr4MdUF9IJU0wupvY9z9oPW49UQ8qXuHoODMBmcEwPuLzHxTUJJWuic
 k7io5RDNUB4iTiKm0l2npXMZ9qLa0po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795549001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rbfQPnb/bGQ2Gkjp6lt26EZDU8eKMGkAA4M/WWEU8/c=;
 b=dk5YjynBJCrj49GitF84RZJ2dgPePHqam+YuV+QitmjE0rZOV8sppZVHzD3Btg3owvQ2To
 8SM1E9W+dG+2yLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795549000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rbfQPnb/bGQ2Gkjp6lt26EZDU8eKMGkAA4M/WWEU8/c=;
 b=h2LQ/IDI9VLQ3E7Tws5WfCPIkt0HGGmYoA6Xu62TnhdKBtRQ2fD/djQW0dwzL5JR2J9j1j
 pdDK/TBHwSkSZJ3/qN7t5zHtiihHkeJx8/b2AbVB0RzV7/090vvuDXmQMqGEA8QXYJQyqD
 9NdTAtzQceGIwZ8JCBlpSqI3QJlb49Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795549000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rbfQPnb/bGQ2Gkjp6lt26EZDU8eKMGkAA4M/WWEU8/c=;
 b=Sa6ZruAStbYSh68HiIXKLUc20jCF9BCiQzCoDpqGZbSNX4Y9yzhFNZQxtV9YnS6mNixIuB
 86j1GlyndVGeVaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE3181339F;
 Tue, 24 Nov 2026 19:36:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VZNQJUfnBWs1aQAAD6G6ig
 (envelope-from <krisman@suse.de>); Tue, 24 Nov 2026 19:36:39 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Sarthak Kukreti via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
In-Reply-To: <20261119214944.1480596-2-sarthakkukreti@google.com>
Organization: SUSE
References: <20261119214944.1480596-1-sarthakkukreti@google.com>
 <20261119214944.1480596-2-sarthakkukreti@google.com>
Date: Tue, 24 Nov 2026 14:36:38 -0500
Message-ID: <87pkvuc989.fsf@cartola>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; HAS_ORG_HEADER(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, dirent.name:url,
 decrypted_name.name:url]
X-Spam-Score: -12.80
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVwJr-000000002yr-3TqE
Subject: Re: [f2fs-dev] [PATCH v2 1/3] libfs: reject casefolded names that
 fold to ".", "..", or empty
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Sarthak Kukreti <sarthakkukreti@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sarthak Kukreti via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> writes:

> diff --git a/fs/libfs.c b/fs/libfs.c
> index 46e0205154e7..77997f88e475 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1828,13 +1828,21 @@ int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
>  	const struct inode *dir = READ_ONCE(dentry->d_inode);
>  	struct super_block *sb = dentry->d_sb;
>  	const struct unicode_map *um = sb->s_encoding;
> +	unsigned char buf[3];
>  	int ret;
>  
>  	if (!dir || !IS_CASEFOLDED(dir))
>  		return 0;
>  
>  	ret = utf8_casefold_hash(um, dentry, str);
> -	if (ret < 0 && sb_has_strict_encoding(sb))
> +	if (ret < 0) {
> +		if (sb_has_strict_encoding(sb))
> +			return -EINVAL;
> +		return 0;
> +	}
> +
> +	ret = utf8_casefold(um, str, buf, sizeof(buf));
> +	if (ret == 0 || (ret > 0 && name_is_dot_dotdot(buf, ret)))
>  		return -EINVAL;

I really dislike the idea of doing utf8_casefold here. even on a
small substring.  We are walking down the trie a second time just to do it
again in ->d_compare.

Consider we don't have negative dentries for casefolded directories.  Is
there a case where variants of '.' or '..' are ever cached if ->lookup
rejects them?  I don't think so.  By rejecting the creation of
'.<empty>' ..<empty> we can guarantee there aren't any variants either.

Assuming these don't exist in the dcache, why not let utf8_casefold_hash
hash to a non-existing dentry?  d_compare will not find it, go to
->lookup and only the filesystem needs special handling to reject
invalid names.  The vast majority of real lookups will hit the dcache
and never pay the cost of this check.

If we *must* check the dcache for some reason I miss, can we do it
*only* in d_compare?  There, we are doing some kind of utf8_casefold
anyway.  We can modify utf8_strncasecmp to return the casefolded string,
which we can byte compare for dotdot, avoiding multiple walks over the
trie.

>  	return 0;
>  }
> @@ -1907,10 +1915,28 @@ int generic_ci_match(const struct inode *parent,
>  	    !memcmp(name->name, dirent.name, dirent.len))
>  		goto out;
>  
> -	if (folded_name->name)
> +	if (name_is_dot_dotdot(dirent.name, dirent.len) ||
> +	    name_is_dot_dotdot(name->name, name->len) ||
> +	    (folded_name->name &&
> +	     (!folded_name->len ||
> +	      name_is_dot_dotdot(folded_name->name, folded_name->len))))
> {

Most of these checks seems unnecessary.

First, if name_is_dot_dotdot(dirent.name) is true, which I'm not sure
can really happen, it only matters if name_is_dot_dotdot(name->name) or
name_is_dot_dotdot(folded_name->name) is also true, because then we have
a match.  Otherwise, there's no match.  Checking both seems redundant.

But also, if name_is_dot_dotdot(name->name) is true, that means we are
doing an exact search for '.' or '..', which, IIUC, the VFS will handle
specially and not call this code?

I think the only thing you need to check here is:

name_is_dot_dotdot(folded_name->name, folded_name->len)

if folded_name exists.  If it doesn't, that's because the cached name
initialization failed and you might need to do the utf8_casefold +
name_is_dot_dotdot() dance you do in the hunk below:


> +
> +	if (folded_name->name) {
>  		res = utf8_strncasecmp_folded(um, folded_name, &dirent);
> -	else
> +	} else {
> +		unsigned char buf[3];
> +		int cf_len = utf8_casefold(um, name, buf, sizeof(buf));
> +
> +		if (cf_len == 0 ||
> +		    (cf_len > 0 && name_is_dot_dotdot(buf, cf_len))) {
> +			res = 1;
> +			goto out;
> +		}
>  		res = utf8_strncasecmp(um, name, &dirent);
> +	}
>  
>  out:
>  	kfree(decrypted_name.name);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5b3a100aba77..22c411e046ce 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3368,28 +3368,26 @@ int generic_ci_d_compare(const struct dentry *dentry, unsigned int len,
>   * generic_ci_validate_strict_name - Check if a given name is suitable
>   * for a directory
>   *
> - * This functions checks if the proposed filename is valid for the
> - * parent directory. That means that only valid UTF-8 filenames will be
> - * accepted for casefold directories from filesystems created with the
> - * strict encoding flag.  That also means that any name will be
> - * accepted for directories that doesn't have casefold enabled, or
> - * aren't being strict with the encoding.
> + * This function checks if the proposed filename is valid for the
> + * parent directory. Names that casefold to "", ".", or ".." are
> + * rejected for all casefolded directories. When the filesystem is
> + * created with the strict encoding flag, only valid UTF-8 filenames
> + * are accepted for casefolded directories.
>   *
>   * @dir: inode of the directory where the new file will be created
>   * @name: name of the new file
>   *
>   * Return:
> - * * True: if the filename is suitable for this directory. It can be
> - *   true if a given name is not suitable for a strict encoding
> - *   directory, but the directory being used isn't strict
> - * * False if the filename isn't suitable for this directory. This only
> - *   happens when a directory is casefolded and the filesystem is strict
> - *   about its encoding.
> + * * True: if the filename is suitable for this directory.
> + * * False: if the filename isn't suitable for this directory.
>   */
>  static inline bool generic_ci_validate_strict_name(struct inode *dir,
>  						   const struct qstr *name)
>  {
> -	if (!IS_CASEFOLDED(dir) || !sb_has_strict_encoding(dir->i_sb))
> +	unsigned char buf[3];
> +	int len;
> +
> +	if (!IS_CASEFOLDED(dir))
>  		return true;
>  
>  	/*
> @@ -3399,6 +3397,13 @@ static inline bool generic_ci_validate_strict_name(struct inode *dir,
>  	if (WARN_ON_ONCE(!dir->i_sb->s_encoding))
>  		return true;
>  
> +	len = utf8_casefold(dir->i_sb->s_encoding, name, buf, sizeof(buf));
> +	if (len == 0 || (len > 0 && name_is_dot_dotdot(buf, len)))
> +		return false;
> +

With this in place we should not be creating new files that turn into '.'
and '..'.  If we also reject to create them during a lookup, I think it
is enough to drop the dcache callback changes.

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
