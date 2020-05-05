Return-Path: <SRS0=VCAv=6T=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51C9C47259
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 May 2020 16:59:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0BE20836;
	Tue,  5 May 2020 16:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="g4Rz71E3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="aM5pwcHu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGVAziax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0BE20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jW0uM-0006DK-6b; Tue, 05 May 2020 16:59:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jW0uK-0006D5-DX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 May 2020 16:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AEbaMql/a/XiZjpgXw2LwmTs4cLoUrICsR5Q8hoThLA=; b=g4Rz71E345lTO4Jzsiwp2Fw2TW
 vtMUjFH4kYPHijeDRUJPV1mbXbLl8StdsjMtfq/XLnjbNXGYc56/Z5TxwDCOaxRqnn/s4HsdO6kNY
 IWGnHFZxnmqgCrSEoyzZhH+ErTw4KRpPwKBX27j0FqCyyMCzFwXsRblT6CewRJiznPgM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AEbaMql/a/XiZjpgXw2LwmTs4cLoUrICsR5Q8hoThLA=; b=aM5pwcHudI504LRIOODpLHwl+q
 hzyroSwSln3ItZgRnUTa2sud+xOEMciNOPHzcv0qhm0IXqVY4n/8TFuh8RYjDToEb2U5ZiiYxZQ+X
 EPhmFXRKsKISGTuipr6L/aQ75QumTBWrMU80rJqucjnVFcupm8BeXcFaTyiDhar7/XrM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jW0uJ-00Eb63-8r
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 05 May 2020 16:59:00 +0000
Received: from gmail.com (unknown [104.132.1.76])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B49B120757;
 Tue,  5 May 2020 16:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588697928;
 bh=N18rhaJtm01k8g6a0UjT7Q6LzqEp+W4aYkEI1nt+QGM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MGVAziaxz2CPuV6fer1oeWX2KYKiEaAs3iXbuxTffNfh5rfa2+3lCDNDfJR97mRGz
 FR7XkyVbck8+3uHqPfXEA9DYmQ1TwPHGVfgOLtQD/FNDGlHK7UNxn86jwi3KrNKcaH
 bIefYvdqDROf14QqFG54fWlXC7ASGAUqAj+Gy+d4=
Date: Tue, 5 May 2020 09:58:47 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <20200505165847.GA98848@gmail.com>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200505153139.201697-1-jaegeuk@kernel.org>
X-Headers-End: 1jW0uJ-00Eb63-8r
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
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
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 05, 2020 at 08:31:39AM -0700, Jaegeuk Kim wrote:
> We had to grab the inode before retrieving i_ino.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index a0a4413d6083b..9d4c3e3503567 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -168,6 +168,7 @@ static const struct vm_operations_struct f2fs_file_vm_ops = {
>  static int get_parent_ino(struct inode *inode, nid_t *pino)
>  {
>  	struct dentry *dentry;
> +	struct inode *parent;
>  
>  	inode = igrab(inode);
>  	dentry = d_find_any_alias(inode);
> @@ -175,8 +176,13 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
>  	if (!dentry)
>  		return 0;
>  
> -	*pino = parent_ino(dentry);
> +	parent = igrab(d_inode(dentry->d_parent));
>  	dput(dentry);
> +	if (!parent)
> +		return 0;
> +
> +	*pino = parent->i_ino;
> +	iput(parent);
>  	return 1;

This doesn't appear to be necessary.  parent_ino() is:

	spin_lock(&dentry->d_lock);
	res = dentry->d_parent->d_inode->i_ino;
	spin_unlock(&dentry->d_lock);

Since dentry is locked and referenced, ->d_parent is stable and positive.

In the encrypt+casefold patch I was reviewing, it's indeed necessary, but only
because there was a check of inode->i_flags added outside the locked region.
The following would be simpler:

        spin_lock(&dentry->d_lock);
        dir = dentry->d_parent->d_inode;
        *pino = dir->i_ino;
        needs_recovery = IS_ENCRYPTED(dir) && IS_CASEFOLDED(dir);
        spin_unlock(&dentry->d_lock);

BTW, d_find_any_alias() is unnecessary too.  This code should just be using
file_dentry(file) from f2fs_do_sync_file().

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
