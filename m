Return-Path: <SRS0=ZZcx=2Y=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17626C2D0C2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Jan 2020 17:01:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8C2206DB;
	Fri,  3 Jan 2020 17:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="UzkbB6hE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="T+4OA3yr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0c6Riaif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8C2206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1inQKG-0007Le-GM; Fri, 03 Jan 2020 17:01:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1inQKF-0007LP-BA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jan 2020 17:01:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9n+PfgVP6t3Cg31XkIKp5Iuj/WWbSw3OeBT+QKPMMSk=; b=UzkbB6hErQQ8YCDzJTJR98fitc
 +bGAoj6FKGQIjZ9gxshRikuLJW+1p08N/dSpR1/pyYbkylXv/bHRR9ayhrV3TIQZPCEl3HL5YeRzw
 a2oWWK5xa/P95UIFNkQTSReT/WOf2LNAtHiuPDJuH7M6vGGvdZHLvbP7DWxglA4Sw6h4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9n+PfgVP6t3Cg31XkIKp5Iuj/WWbSw3OeBT+QKPMMSk=; b=T+4OA3yreqWJV3vP3bd66uVRIn
 ABpkoe6dPAn6CTTlw13d8fqHX288Qvlrv3Pg5dEUttLFt3eMcc7tqhnYQLO7qpTPzB5Dk2sIGqFh5
 61FHnpX1yQAtkvVIcp1PgMuiTfOdbyU9IkUOf0x9ORC9XISW5x6ixb1d0jySbUvVURqo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1inQK9-008Y2l-6A
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 03 Jan 2020 17:01:27 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 74DB2206DB;
 Fri,  3 Jan 2020 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578070875;
 bh=HMuouXSipp7GyOORuZndvSxu7oJc36nPRlBYJnzTvfI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=0c6Riaif5UCXPFg0KmFe/6EcY83zl1CgNxWZ8G9Th6X6ej3StmUMFqe7YT76jAdF+
 CIgJI5O8guUL/J87QCnIeoZODInfIQmP1XJ2yd2xCr2ie5qx3g3ZeH35l31c6fQXxQ
 SbrnR6jcQ3akMOEV8pNdkAJPuJpI84QatL6I2wrw=
Date: Fri, 3 Jan 2020 09:01:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Message-ID: <20200103170113.GJ19521@gmail.com>
References: <20191209212348.243331-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191209212348.243331-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1inQK9-008Y2l-6A
Subject: Re: [f2fs-dev] [PATCH] fscrypt: don't check for ENOKEY from
 fscrypt_get_encryption_info()
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
Cc: linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Dec 09, 2019 at 01:23:48PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> fscrypt_get_encryption_info() returns 0 if the encryption key is
> unavailable; it never returns ENOKEY.  So remove checks for ENOKEY.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/ext4/dir.c  | 2 +-
>  fs/f2fs/dir.c  | 2 +-
>  fs/ubifs/dir.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 9fdd2b269d617..4c9d3ff394a5d 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -116,7 +116,7 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
>  
>  	if (IS_ENCRYPTED(inode)) {
>  		err = fscrypt_get_encryption_info(inode);
> -		if (err && err != -ENOKEY)
> +		if (err)
>  			return err;
>  	}
>  
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index c967cacf979ef..d9ad842945df5 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -987,7 +987,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
>  
>  	if (IS_ENCRYPTED(inode)) {
>  		err = fscrypt_get_encryption_info(inode);
> -		if (err && err != -ENOKEY)
> +		if (err)
>  			goto out;
>  
>  		err = fscrypt_fname_alloc_buffer(inode, F2FS_NAME_LEN, &fstr);
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 0b98e3c8b461d..acc4f942d25b6 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -512,7 +512,7 @@ static int ubifs_readdir(struct file *file, struct dir_context *ctx)
>  
>  	if (encrypted) {
>  		err = fscrypt_get_encryption_info(dir);
> -		if (err && err != -ENOKEY)
> +		if (err)
>  			return err;
>  
>  		err = fscrypt_fname_alloc_buffer(dir, UBIFS_MAX_NLEN, &fstr);
> -- 
> 2.24.0.393.g34dc348eaf-goog
> 

Applied to fscrypt.git#master for 5.6.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
