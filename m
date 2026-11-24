Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BBF606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q8VND0+u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Om3K693I;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CABAGP+D;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=zYY69mhW;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=S7x7P8K2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gypI6d/V;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5PnAQBSm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:References:In-Reply-To:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=eJAuyjuyArFVQ1WNBjHkg/gd/F9D6aNtG+7VZgmLPnU=; b=Q8VND0+uq+PN8+WG2HsE6uZGRA
	DsjceX9Xboxoyg9kg4Af6/BZKaG94c/v3cccMy848KG8KPla4Do7Ad6EK7wyy+Vl/5rpnE6mFpil9
	Nx22zDx/TopSJ3LvGJt3aN0dSO1d5PwQYCo2SPQipQQIomVjYh5QPfLhQ6S/PyDploBY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVwWM-0000000021K-0PAD;
	Tue, 24 Nov 2026 19:49:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <krisman@suse.de>) id 1xVwVr-0000000020x-11sM
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:49:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Txnj8npZv8ues6Q9E3gBrI6hVjJw+5y4gtc7DZoJxPM=; b=O
 m3K693Iv8sTTRZE+Cc1MnUL0KiRIo0rDQupRceGhB4D0rJTyIxEbsJGj+g0RtPV6eC+EiB5AzJ7wL
 OqZdRyPov6bv34SF5Hrv/p3bgHirHhonEpXxKYtq73CDX8slscYRLV9n+FAjPu0/PhN+xVQAv9Rjm
 PShS7N9wKG7G29FI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Txnj8npZv8ues6Q9E3gBrI6hVjJw+5y4gtc7DZoJxPM=; b=CABAGP+DFTyqaY6WOZR3xgWgcy
 C1q8GWGSO8Z+GK3WbVHDPocwy7POtR9+nlOemokJR59HFGKU7wkBqQ/u3cevkenxU38qVsAAotyl1
 +cAf5RTVM9a1hxf/+ZzLMjI0j/qjLrifTSoQirgApLV7TfGEg15njR5aegilY1MWaVAU=;
Received: from smtp-out2.suse.de ([195.135.223.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVwVq-000000004lw-1fkn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 19:49:11 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CB5D71F74B;
 Tue, 24 Nov 2026 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795549744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Txnj8npZv8ues6Q9E3gBrI6hVjJw+5y4gtc7DZoJxPM=;
 b=zYY69mhWGahHtc4rta8xtAR9I9Sms1hO1vd1yoRl9NcgG5w+DcMWzAkUd0kzoNszBW4MVL
 V/gS09B+oOCopBk2j+RqYwkaN77ALHpJUdfniVfq4Mv9k4KPNSFbz5ilwUTOoHhDNx5hOK
 JEmzuEnfTqO/Ww6My24evBrLkCkHCZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795549744;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Txnj8npZv8ues6Q9E3gBrI6hVjJw+5y4gtc7DZoJxPM=;
 b=S7x7P8K2VQ3r1jrchadebt4oVo40oonPl15EmEEptM8mE8NGJNOlxgSM5y4NmJ8QD7PqYk
 CgigCZtB5B26NiCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795549742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Txnj8npZv8ues6Q9E3gBrI6hVjJw+5y4gtc7DZoJxPM=;
 b=gypI6d/VLiNgqpUDnAg2IdzGwqoG9GCLBUFb0SFT+/SyQpXuiX38yhAiWcrIn8JEhYSR9C
 aLvZCUDHIaIEkoi7L5J7xUuzjQHK9Hh0t131BCauRrUzTwgU1vvebEbgcYn5GR48Ags71z
 xpb0PKhKBX3tPhbcDhgV16XDXa9kdag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795549742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Txnj8npZv8ues6Q9E3gBrI6hVjJw+5y4gtc7DZoJxPM=;
 b=5PnAQBSmc70hsTm+07PWOG2TbOnH7SWN75B5bhpoC9uBO2ACT3jBWhezjW44cEd+aBudhi
 aoKDunw42VxtMTDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59C621339F;
 Tue, 24 Nov 2026 19:49:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sYTnNy3qBWsNdgAAD6G6ig
 (envelope-from <krisman@suse.de>); Tue, 24 Nov 2026 19:49:02 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Sarthak Kukreti via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>, Theodore Ts'o <tytso@mit.edu>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
In-Reply-To: <20261119214944.1480596-3-sarthakkukreti@google.com>
Organization: SUSE
References: <20261119214944.1480596-1-sarthakkukreti@google.com>
 <20261119214944.1480596-3-sarthakkukreti@google.com>
Date: Tue, 24 Nov 2026 14:48:56 -0500
Message-ID: <87mrqyc8nr.fsf@cartola>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVwVq-000000004lw-1fkn
Subject: Re: [f2fs-dev] [PATCH v2 2/3] ext4: reject casefolded names that
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Sarthak Kukreti via Linux-f2fs-devel
<linux-f2fs-devel@lists.sourceforge.net> writes:

> Filenames consisting solely of ignorable Unicode characters fold to
> empty strings (causing the first such file to be created on disk and
> subsequent distinct ignorable-only names to collide with it), while
> names with leading dots and ignorable characters fold to "." or "..",
> colliding with on-disk "." and ".." entries and triggering
> EXT4_ERROR_INODE in ext4_lookup().
>
> Skip casefolding when the lookup name is literally "." or "..", reject
> any non-dot names that fold to "", ".", or ".." in
> ext4_fname_setup_ci_filename(), and fall back to opaque byte hashing in
> ext4fs_dirhash() when utf8_casefold() yields "", ".", or "..".
>
> Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
> Co-developed-by: Dmitry Torokhov <dtor@google.com>
> Signed-off-by: Dmitry Torokhov <dtor@google.com>
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
> ---
>  fs/ext4/hash-test.c | 14 ++++++++++++++
>  fs/ext4/hash.c      |  2 +-
>  fs/ext4/namei.c     |  9 +++++++--
>  3 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ext4/hash-test.c b/fs/ext4/hash-test.c
> index 49b0d874c833..a8b206a6d751 100644
> --- a/fs/ext4/hash-test.c
> +++ b/fs/ext4/hash-test.c
> @@ -541,6 +541,20 @@ static void test_ext4fs_dirhash_casefold_fallback(struct kunit *test)
>  	KUNIT_ASSERT_EQ(test, ret_plain, 0);
>  	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
>  	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
> +
> +	ret_cf = ext4fs_dirhash(&ei->vfs_inode, ".\xe2\x80\xae", 4, &folded_dir);
> +	ret_plain = ext4fs_dirhash(plain_dir, ".\xe2\x80\xae", 4, &plain);
> +	KUNIT_ASSERT_EQ(test, ret_cf, 0);
> +	KUNIT_ASSERT_EQ(test, ret_plain, 0);
> +	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
> +	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
> +
> +	ret_cf = ext4fs_dirhash(&ei->vfs_inode, "\xe2\x80\xae", 3, &folded_dir);
> +	ret_plain = ext4fs_dirhash(plain_dir, "\xe2\x80\xae", 3, &plain);
> +	KUNIT_ASSERT_EQ(test, ret_cf, 0);
> +	KUNIT_ASSERT_EQ(test, ret_plain, 0);
> +	KUNIT_EXPECT_EQ(test, folded_dir.hash, plain.hash);
> +	KUNIT_EXPECT_EQ(test, folded_dir.minor_hash, plain.minor_hash);
>  }
>  #endif
>  
> diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
> index 978bd92da0ad..65019de4af93 100644
> --- a/fs/ext4/hash.c
> +++ b/fs/ext4/hash.c
> @@ -327,7 +327,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
>  			return -ENOMEM;
>  
>  		dlen = utf8_casefold(um, &qstr, buff, PATH_MAX);
> -		if (dlen < 0) {
> +		if (dlen <= 0 || name_is_dot_dotdot(buff, dlen)) {
>  			kfree(buff);
>  			goto opaque_seq;
>  		}
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 354fc2d22df1..cd2c9b873cc6 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1368,7 +1368,8 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
>  	int len;
>  
>  	if (!IS_CASEFOLDED(dir) ||
> -	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir))) {
> +	    (IS_ENCRYPTED(dir) && !fscrypt_has_encryption_key(dir)) ||
> +	    name_is_dot_dotdot(iname->name, iname->len)) {

if name_is_dot_dotdot(iname->name, iname->len) is true, isn't that a
byte-exact match to dot or dotdot?  Do we actually get here for
byte-exact matches?

The rest of the patch looks good to me!

>  		cf_name->name = NULL;
>  		return 0;
>  	}
> @@ -1378,9 +1379,13 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
>  		return -ENOMEM;
>  
>  	len = utf8_casefold(dir->i_sb->s_encoding, iname, buf, EXT4_NAME_LEN);
> -	if (len <= 0) {
> +	if (len < 0) {
>  		kfree(buf);
>  		buf = NULL;
> +	} else if (len == 0 || name_is_dot_dotdot(buf, len)) {
> +		kfree(buf);
> +		cf_name->name = NULL;
> +		return -EINVAL;
>  	}
>  	cf_name->name = buf;
>  	cf_name->len = (unsigned) len;
> -- 
> 2.56.1.750.gf70dc682cf-goog
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
